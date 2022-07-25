module AttendancesHelper
  def itemized_time_hash
    result = {}
    Order.all.each do |order|
      result[order.id] = order.itemized_time
    end
    result
  end
end
