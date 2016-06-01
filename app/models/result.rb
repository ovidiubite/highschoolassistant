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
  # def predict(evaluation_rate, graduation_rate, treshold)
  #   # integer
  #   pr = -1
  #
  #   str1 = "select min(f1), max(f1) from import2015 where media-0.02 <= " + evaluation_rate.ToString() + " and media+0.02 >= " + evaluation_rate.ToString() + " ";
  #   dr1 = ActiveRecord.execute(str1)
  #
  #   # integers
  #   # @TODO check if returns what needs to return
  #   pos1 = results[0]
  #   pos2 = results[1]
  #
  #   if( (pos2 >= pos1) && (pos1 > 0) )
  #     str2 = "select min(mediaadmitere), max(mediaadmitere) from
  #            (select f1, position, mediaexamen, mediaadmitere, mediaabsolvire from
  #            (select (row_number() over (order by mediaexamen desc)) as position, mediaexamen, mediaadmitere, mediaabsolvire, f1 from import2014 ) as imp2014
  #            where position >= #{pos1} and position <= #{pos2}) as pos2014
  #            where mediaabsolvire-0.1 <= #{graduation_rate} and mediaabsolvire+0.1 >= #{graduation_rate}"
  #
  #     SqlCommand cmd2 = new SqlCommand(str2, con)
  #     SqlDataReader dr2 = cmd2.ExecuteReader()
  #     if (dr2.Read())
  #       a = 3, b = 10
  #       min_medie_admitere = (float)dr2.GetDouble(0)
  #       max_medie_admitere = (float)dr2.GetDouble(1)
  #
  #       # p, x -float
  #
  #       # @TODO Change C# math expression with ruby math expressions
  #       if( min_medie_admitere >= treshold)
  #          x = (max_medie_admitere - min_medie_admitere)/2 + min_medie_admitere - treshold
  #          p = 1 / (1 + (1/a) * Math.Exp((-1)*b*x).to_f)
  #       elsif( max_medie_admitere <= treshold )
  #          x = (max_medie_admitere - min_medie_admitere)/2 + min_medie_admitere - treshold
  #          p = 1 / (1 + a * Math.Exp((-1)*b*x).to_f)
  #       else
  #          p = 0.25.to_f + ((treshold - min_medie_admitere) * 0.5.to_f) / (max_medie_admitere - min_medie_admitere)
  #       end
  #
  #       pr = (int)Math.Round(p * 100)
  #     end
  #   end
  #
  #   # @TODO insert in results Table
  #   str3 = "insert into querieslog(querylog_datetime, querylog_exam, querylog_grad, querylog_threshold, querylog_prediction, querylog_version) " +
  #        "values(GETDATE(), " + evaluation_rate.to_s + ", " + graduation_rate.to_s + ", " + treshold.to_s + ", " + pr.to_s + ", 1)";
  #
  #   SqlCommand cmd3 = new SqlCommand(str3, con);
  #   cmd3.ExecuteNonQuery();
  #   return pr
  # end
end
