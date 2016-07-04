# == Schema Information
#
# Table name: results
#
#  id                   :integer          not null, primary key
#  percentage           :string
#  overall_grade        :string
#  evaluation_rate      :string
#  graduation_rate      :string
#  date                 :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  highschool_detail_id :integer
#  user_id              :integer
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
  #
  # @return [Float] - percentage
  def self.predict(evaluation_rate, graduation_rate, highschool_details)
    if AdmissionResult.where(year: Date.today.year).empty?
      last_admission_rate = highschool_details.last_rate.squish

      admission_grade = admission_grade(graduation_rate, evaluation_rate)

      predict_from_admission_results(admission_grade.to_f, last_admission_rate.to_f)
    else
      predict_from_evaluation_results(evaluation_rate, graduation_rate, highschool_details)
    end
  end

  private

  def self.admission_grade(graduation_rate, evaluation_rate)
    ((graduation_rate.to_f + 3*evaluation_rate.to_f).to_f/4).round(2)
  end

  def self.prediction_algorithm(min_medie_admitere, max_medie_admitere, treshold)
    # cresterea exponentiala
    a = 1
    b = 6
    x = (max_medie_admitere - min_medie_admitere)/2 + min_medie_admitere - treshold
    if( min_medie_admitere >= treshold)
       p = 1 / (1 + (1/a) * Math.exp((-1)*b*x).to_f)
    elsif( max_medie_admitere <= treshold )
       p = 1 / (1 + a * Math.exp((-1)*b*x).to_f)
    else
       p = 0.25.to_f + ((treshold - min_medie_admitere) * 0.5.to_f) / (max_medie_admitere - min_medie_admitere)
    end
    prediction = p * 100
    prediction.round
  end

  def self.predict_from_admission_results(admission_grade, last_rate)
    # algoritmul simplu bazat pe highschool details
    min_medie_admitere = admission_grade - 0.02
    max_medie_admitere = admission_grade + 0.02
    prediction_algorithm(min_medie_admitere, max_medie_admitere, last_rate)
  end

  def self.predict_from_evaluation_results(evaluation_rate, graduation_rate, highschool_details)
    county = highschool_details.highschool.county
    last_rate = highschool_details.last_rate

    this_year_results = EvaluationResult.select("position")
      .where("year = (?) AND county_id = (?)", Date.today.year, county.id)
      .where("CAST(evaluation_rate AS FLOAT)-0.02 <= (?)", evaluation_rate.to_f)
      .where("CAST(evaluation_rate AS FLOAT)+0.02 >= (?)", evaluation_rate.to_f)

    # integers
    pos1 = this_year_results.last.position
    pos2 = dr1.first.position

    str2 = "select min(admission_rate), max(admission_rate) from
    (select position, evaluation_rate, admission_rate, graduation_rate from
    (select position, evaluation_rate, admission_rate, graduation_rate from admission_results ) as presentYear
    where county_id = #{county.id} AND year = #{Date.today.year} AND position >= #{pos1} AND position <= #{pos2}) as lastYear
    where graduation_rate-0.1 <= #{graduation_rate} AND graduation_rate+0.1 >= #{graduation_rate}"

    dr2 = ActiveRecord::Base.connection.execute(str2)
    min_medie_admitere = dr2.values[0].to_f
    max_medie_admitere = dr2.values[1].to_f
    prediction_algorithm(min_medie_admitere, max_medie_admitere, last_rate)
  end
end
