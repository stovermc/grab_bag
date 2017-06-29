class SessionStat < ApplicationRecord

  def self.log_ins_by_weekday
    log_ins = group(:log_in_day).count
    log_ins.map.with_index do |pair, i|
      {"Weekday": (pair[0]), "Number of Logins": pair[1]}
    end
  end

  def self.average_duration
    ((average(:duration) / 60) / 60).round(2)
  end

end
