module ApplicationHelper

  def wday_to_ja(wday)
    return "" if wday.nil?
    ["日", "月", "火", "水", "木", "金", "土"][wday]
  end
  # 引数： (string)ym|ymd|ymd_wday|ymw|wday|day|am_pm, (Time)dt
  # 返り値：文字列（日付）

  # 年月,年月日,年月日曜日,年月週曜日,日,AM/PM
  # にフォーマットする。
  def format_to(dt, format)
    return "" if dt.blank?

    {
      ym:dt.try(:strftime,"%Y/%m"),
      ymd:dt.try(:strftime,"%Y/%m/%d"),
      ymd_wday:dt.try(:strftime,"%Y/%m/%d")+" #{wday_to_ja(dt.try(:wday))}",
      ymw:dt.try(:strftime,"%Y/%m")+" ",# Todo 週
      wday:"#{wday_to_ja(dt.try(:wday))}",
      day:dt.try(:strftime,"%-d"),
      am_pm:dt.try(:strftime,"%R")
    }[format]
  end
end
