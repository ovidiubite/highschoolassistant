# == Schema Information
#
# Table name: results
#
#  id                    :integer          not null, primary key
#  percentage            :string
#  overall_grade         :string
#  evaluation_rate       :string
#  graduation_rate       :string
#  date                  :date
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  highschool_details_id :integer
#  user_id               :integer
#

class Result < ActiveRecord::Base
  include Math
  belongs_to :user
  belongs_to :highschool_detail

  def float_evaluation_rate
    self.evaluation_rate.to_f
  end

  def float_graduation_rate
    self.graduation_rate.to_f
  end

  def float_overall_grade
    self.overall_grade.to_f
  end

  def float_percentage
    self.percentage.to_f
  end

  def self.calculate_percentage

  end

  # calculate percentage
  # @param evaluation_rate // media evaluare nationala
  # @param graduation_rate // media absolvire
  # @param treshold - treshold
  #
  # @return [Float] - percentage
  def self.predict(evaluation_rate, graduation_rate, treshold)
    prediction = -1

    # tabela de evaluare nationala
    # trebuie inclus si anul si liceul...
    str1 = "select min(f1), max(f1) from import2015 where media-0.02 <= " + evaluation_rate.to_s + " and media+0.02 >= " + evaluation_rate.to_s + " ";
    dr1 = ActiveRecord::Base.connection.execute(str1)

    # integers
    # @TODO check if returns what needs to return
    pos1 = dr1.values[0]
    pos2 = dr1.values[1]

    # tabela de admitere din anul precedent
    # trebuie inclus si anul si liceul...
    if( (pos2 >= pos1) && (pos1 > 0) )
      str2 = "select min(mediaadmitere), max(mediaadmitere) from
             (select f1, position, mediaexamen, mediaadmitere, mediaabsolvire from
             (select (row_number() over (order by mediaexamen desc)) as position, mediaexamen, mediaadmitere, mediaabsolvire, f1 from import2014 ) as imp2014
             where position >= #{pos1} and position <= #{pos2}) as pos2014
             where mediaabsolvire-0.1 <= #{graduation_rate} and mediaabsolvire+0.1 >= #{graduation_rate}"

      dr2 = ActiveRecord::Base.connection.execute(str2)
      a = 3, b = 10
      min_medie_admitere = dr2.values[0].to_f
      max_medie_admitere = dr2.values[1].to_f

      # p, x -float

      # @TODO Change C# math expredictionession with ruby math expressions
      if( min_medie_admitere >= treshold)
         x = (max_medie_admitere - min_medie_admitere)/2 + min_medie_admitere - treshold
         p = 1 / (1 + (1/a) * Math.exp((-1)*b*x).to_f)
      elsif( max_medie_admitere <= treshold )
         x = (max_medie_admitere - min_medie_admitere)/2 + min_medie_admitere - treshold
         p = 1 / (1 + a * Math.exp((-1)*b*x).to_f)
      else
         p = 0.25.to_f + ((treshold - min_medie_admitere) * 0.5.to_f) / (max_medie_admitere - min_medie_admitere)
      end
      prediction = p * 100
      prediction.round
    end

    # @TODO insert in results Table
    # str3 = "insert into querieslog(querylog_datetime, querylog_exam, querylog_grad, querylog_threshold, querylog_prediction, querylog_version) " +
            # "values(GETDATE(), " + evaluation_rate.to_s + ", " + graduation_rate.to_s + ", " + treshold.to_s + ", " + prediction.to_s + ", 1)";

    Result.create(evaluation_rate: evaluation_rate.to_s, graduation_rate: graduation_rate.to_s, percentage: prediction.to_s)

    return prediction
  end
end
