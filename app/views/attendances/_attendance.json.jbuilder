json.extract! attendance, :id, :corporation_id, :employee_id, :start_time, :end_time, :rest_time, :work_content, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
