# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 法人
corporation = Corporation.create!(
  name: "リバティ・フィッシュ株式会社",
  time_unit: 1,
  time_limit: 33,
	scheduled_working_hours: 480,
	regular_lines: 10
)

# 通常勤怠オーダー
(1..5).each do |n|
	Order.create!(
		corporation_id: corporation.id,
		code: "1000#{n}1",
		name: "テスト会社#{n}",
		itemized_time: 0,
		display_flg: 0
	)
end

# 休み
order1 = Order.create!(
	corporation_id: corporation.id,
	code: "500000",
	name: "休憩",
	itemized_time: 1,
	display_flg: 0
)

# 遅刻
Order.create!(
	corporation_id: corporation.id,
	code: "920021",
	name: "遅刻(公共機関証明あり)",
	itemized_time: 5,
	display_flg: 1
)

Order.create!(
	corporation_id: corporation.id,
	code: "920022",
	name: "遅刻(公共機関証明なし)",
	itemized_time: 2,
	display_flg: 1
)

Order.create!(
	corporation_id: corporation.id,
	code: "930011",
	name: "早退",
	itemized_time: 2,
	display_flg: 1
)

# 有休
order2 = Order.create!(
	corporation_id: corporation.id,
	code: "940011",
	name: "有給(一般)",
	itemized_time: 3,
	display_flg: 1
)

# 有休(特別)
order3 = Order.create!(
	corporation_id: corporation.id,
	code: "940012",
	name: "有給(特別)",
	itemized_time: 4,
	display_flg: 1
)

order4 = Order.create!(
	corporation_id: corporation.id,
	code: "940021",
	name: "欠勤",
	itemized_time: 2,
	display_flg: 1
)

Order.create!(
	corporation_id: corporation.id,
	code: "940031",
	name: "公休(夏季休暇)",
	itemized_time: 5,
	display_flg: 1
)

Order.create!(
	corporation_id: corporation.id,
	code: "940032",
	name: "代休",
	itemized_time: 5,
	display_flg: 1
)

Order.create!(
	corporation_id: corporation.id,
	code: "950011",
	name: "休職(私傷病休職)",
	itemized_time: 5,
	display_flg: 1
)

# 休職(育児)
Order.create!(
	corporation_id: corporation.id,
	code: "950021",
	name: "休職(育児)",
	itemized_time: 5,
	display_flg: 1
)

# 休職(コロナ)
Order.create!(
	corporation_id: corporation.id,
	code: "950031",
	name: "休職(コロナ)",
	itemized_time: 0,
	display_flg: 1
)

# 有効期限切れの作業コード
Order.create!(
	corporation_id: corporation.id,
	code: "100099",
	name: "有効期限切れテスト会社",
	itemized_time: 0,
	display_flg: 0,
	expiration_date: Date.today.prev_month
)

order5 = Order.create!(
	corporation_id: corporation.id,
	code: "100091",
	name: "テスト会社9",
	itemized_time: 0,
	display_flg: 0
)

# 作業コード
work1 = Work.create!(
	corporation_id: corporation.id,
	code: "500",
	name: "休憩"
)

work2 = Work.create!(
	corporation_id: corporation.id,
	code: "900",
	name: "休み"
)

["デザイン", "テスト", "レビュー", "ドキュメント"].each_with_index do |name, i|
	Work.create!(
		corporation_id: corporation.id,
		code: "10#{i}",
		name: "#{name}"
	)
end

work3 = Work.create!(
	corporation_id: corporation.id,
	code: "105",
	name: "プログラミング"
)

department1 = Department.create!(
	corporation_id: corporation.id,
	code: "C1001",
	name: "システム統括部アプリケーションソリューション課"
)

department2 = Department.create!(
	corporation_id: corporation.id,
	code: "C1004",
	name: "システム統括部ビジネスソリューション課"
)

# 社員
employee1 = Employee.create!(
	email: "test1@email.com",
	password: "password",
	department_id: department1.id,
	employee_code: "1111",
	user_code: "test1@email.com",
	name: "山田 花子",
	kana: "ヤマダ ハナコ",
	proparties: "3",
	invalid_flag: true
)

Employee.create!(
	email: "test2@email.com",
	password: "password",
	department_id: department2.id,
	employee_code: "1112",
	user_code: "test2@email.com",
	name: "田中 太郎",
	kana: "タナカ タロウ",
	proparties: "3",
	invalid_flag: true
)

# 無効ユーザー
Employee.create!(
	email: "test3@email.com",
	password: "password",
	department_id: department1.id,
	employee_code: "1113",
	user_code: "test3@email.com",
	name: "山田 太郎",
	kana: "ヤマダ ハナコ",
	proparties: "0",
	invalid_flag: false
)

date = Time.current
# 作業 ＋ 休憩 ＋ 有給(一般)
attendance1 = Attendance.create!(
	employee_id: employee1.id,
	base_date: date,
	start_time: Time.new(date.year, date.month, date.day, 9),
	end_time: Time.new(date.year, date.month, date.day, 18),
	break_time: 60,
	operating_time: 180,
	paid_time: 300,
	work_content: '勤怠備考1'
)

AttendanceDetail.create!(
	order_id: order5.id,
	work_id: work3.id,
	attendance_id: attendance1.id,
	start_time: Time.new(date.year, date.month, date.day, 9),
	end_time: Time.new(date.year, date.month, date.day, 12),
	work_content: 'テスト1'
)

AttendanceDetail.create!(
	order_id: order1.id,
	work_id: work1.id,
	attendance_id: attendance1.id,
	start_time: Time.new(date.year, date.month, date.day, 12),
	end_time: Time.new(date.year, date.month, date.day, 13),
	work_content: 'テスト2'
)

AttendanceDetail.create!(
	order_id: order2.id,
	work_id: work2.id,
	attendance_id: attendance1.id,
	start_time: Time.new(date.year, date.month, date.day, 13),
	end_time: Time.new(date.year, date.month, date.day, 18),
	work_content: 'テスト3'
)

# 有給(特別)
attendance2 = Attendance.create!(
	employee_id: employee1.id,
	base_date: date.next_day,
	start_time: Time.new(date.year, date.month, date.next_day.day, 9),
	end_time: Time.new(date.year, date.month, date.next_day.day, 18),
	break_time: 60,
	special_paid_time: 480,
	work_content: '勤怠備考2'
)

AttendanceDetail.create!(
	order_id: order3.id,
	work_id: work2.id,
	attendance_id: attendance2.id,
	start_time: Time.new(date.year, date.month, date.next_day.day, 9),
	end_time: Time.new(date.year, date.month, date.next_day.day, 12),
	work_content: 'テスト4'
)

AttendanceDetail.create!(
	order_id: order1.id,
	work_id: work1.id,
	attendance_id: attendance2.id,
	start_time: Time.new(date.year, date.month, date.next_day.day, 12),
	end_time: Time.new(date.year, date.month, date.next_day.day, 13),
	work_content: 'テスト5'
)

AttendanceDetail.create!(
	order_id: order3.id,
	work_id: work2.id,
	attendance_id: attendance2.id,
	start_time: Time.new(date.year, date.month, date.next_day.day, 13),
	end_time: Time.new(date.year, date.month, date.next_day.day, 18),
	work_content: 'テスト6'
)

# 欠勤
attendance3 = Attendance.create!(
	employee_id: employee1.id,
	base_date: date.prev_day,
	start_time: Time.new(date.year, date.month, date.prev_day.day, 9),
	end_time: Time.new(date.year, date.month, date.prev_day.day, 18),
	break_time: 60,
	deduction_time: 480,
	work_content: '勤怠備考2'
)

AttendanceDetail.create!(
	order_id: order4.id,
	work_id: work2.id,
	attendance_id: attendance3.id,
	start_time: Time.new(date.year, date.month, date.prev_day.day, 9),
	end_time: Time.new(date.year, date.month, date.prev_day.day, 12),
	work_content: 'テスト4'
)

AttendanceDetail.create!(
	order_id: order1.id,
	work_id: work1.id,
	attendance_id: attendance3.id,
	start_time: Time.new(date.year, date.month, date.prev_day.day, 12),
	end_time: Time.new(date.year, date.month, date.prev_day.day, 13),
	work_content: 'テスト5'
)

AttendanceDetail.create!(
	order_id: order4.id,
	work_id: work2.id,
	attendance_id: attendance3.id,
	start_time: Time.new(date.year, date.month, date.prev_day.day, 13),
	end_time: Time.new(date.year, date.month, date.prev_day.day, 18),
	work_content: 'テスト6'
)