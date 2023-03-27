# db直下にcsvファイルを配置。ファイル指定してseeds実行
# rails r db/production.rb

require "csv"

CSV.foreach("db/corporation.csv", headers: true) do |row|
	Corporation.create(
		id: row['id'],
		name: row['name'],
		time_unit: row['time_unit'],
		time_limit: row['time_limit'],
		scheduled_working_hours: row['scheduled_working_hours'],
		regular_lines: row['regular_lines']
	)
end

CSV.foreach("db/department.csv", headers: true) do |row|
	Department.create(
		id: row['id'],
		corporation_id: row['corporation_id'],
		code: row['code'],
		name: row['name']
	)
end

CSV.foreach("db/business_calendar.csv", headers: true) do |row|
	BusinessCalendar.create(
		id: row['id'],
		corporation_id: row['corporation_id'],
		date: row['date'],
		proparties: row['proparties']
	)
end

CSV.foreach("db/employee.csv", headers: true) do |row|
	Employee.create(
		id: row['id'],
		department_id: row['department_id'],
		employee_code: row['employee_code'],
		user_code: row['user_code'],
		email: row['email'],
		name: row['name'],
		kana: row['kana'],
		proparties: row['proparties'],
		invalid_flag: row['invalid_flag'],
		password: row['password']
	)
end

CSV.foreach("db/order.csv", headers: true) do |row|
	Order.create(
		id: row['id'],
		corporation_id: row['corporation_id'],
		code: row['code'],
		name: row['name'],
		itemized_time: row['itemized_time'],
		display_flg: row['display_flg'],
		flg: row['flg'],
		expiration_date: row['expiration_date']
	)
end

CSV.foreach("db/work.csv", headers: true) do |row|
	Work.create(
		id: row['id'],
		corporation_id: row['corporation_id'],
		code: row['code'],
		name: row['name']
	)
end