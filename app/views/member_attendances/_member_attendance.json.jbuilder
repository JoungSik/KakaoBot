json.extract! member_attendance, :id, :due_date, :created_at, :updated_at
json.sender member_attendance.member_name
json.order member_attendance.order_number