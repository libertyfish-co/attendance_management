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
)

# TODO:時間、休憩、有休消化ポイントの設計を確認
# 通常勤怠オーダー
(1..5).each do |n|
	Order.create!(
		corporation_id: corporation.id,
		code: "1000#{n}1",
		name: "テスト会社",
		time_flg: 1,
		rest_flg: 0,
		paid_digestion_flg: false
	)
end

# 休み
Order.create!(
	corporation_id: corporation.id,
	code: "500000",
	name: "休憩",
	time_flg: 0,
	rest_flg: 1,
	paid_digestion_flg: false
)

Order.create!(
	corporation_id: corporation.id,
	code: "940031",
	name: "公休(夏季休暇)",
	time_flg: 1,
	rest_flg: 1,
	paid_digestion_flg: false
 )
 
 Order.create!(
	corporation_id: corporation.id,
	code: "940032",
	name: "代休",
	time_flg: 1,
	rest_flg: 1,
	paid_digestion_flg: false
 )
 
 Order.create!(
	corporation_id: corporation.id,
	code: "930011",
	name: "早退",
	time_flg: -1,
	rest_flg: 0,
	paid_digestion_flg: false
 )

# 遅刻
Order.create!(
	corporation_id: corporation.id,
	code: "920021",
	name: "遅刻(公共機関証明あり)",
	time_flg: 1,
	rest_flg: 1,
	paid_digestion_flg: false
)

Order.create!(
	corporation_id: corporation.id,
	code: "920022",
	name: "遅刻(公共機関証明なし)",
	time_flg: -1,
	rest_flg: 0,
	paid_digestion_flg: false
)

# 有休
Order.create!(
	corporation_id: corporation.id,
	code: "940011",
	name: "有給(一般)",
	time_flg: 1,
	rest_flg: 0,
	paid_digestion_flg: true
)

# 有休(特別)
Order.create!(
	corporation_id: corporation.id,
	code: "940012",
	name: "有給(特別)",
	time_flg: 1,
	rest_flg: 0,
	paid_digestion_flg: false
)

# 有効期限切れの作業コード
Order.create!(
	corporation_id: corporation.id,
	code: "100099",
	name: "テスト会社",
	time_flg: 1,
	rest_flg: 0,
	paid_digestion_flg: false,
	expiration_date: Date.today.prev_month
)

# 作業コード
Work.create!(
	corporation_id: corporation.id,
	code: "500",
	name: "休憩"
)

Work.create!(
	corporation_id: corporation.id,
	code: "900",
	name: "休み"
)

["デザイン", "プログラミング", "テスト", "レビュー", "ドキュメント"].each_with_index do |name, i|
	Work.create!(
		corporation_id: corporation.id,
		code: "10#{i}",
		name: "#{name}"
	)
end

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
Employee.create!(
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
