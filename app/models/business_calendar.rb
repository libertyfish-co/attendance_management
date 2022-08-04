class BusinessCalendar < ApplicationRecord
  belongs_to :corporation

  def self.public_holidays(dt)
    self.select_at(dt, :month).where(proparties: 1)
  end

  def self.select_at(dt, format)
    {
      month: self.where(date: dt.beginning_of_month..dt.end_of_month),
      week: self.where(date: dt.beginning_of_week..dt.end_of_week),
      day: self.where(date: dt.beginning_of_day..dt.end_of_day)
    }[format]
  end
end
