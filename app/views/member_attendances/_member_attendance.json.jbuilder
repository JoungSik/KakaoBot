json.extract! member_attendance, :id, :due_date, :created_at, :updated_at
json.sender member_attendance.member.name
json.order MemberAttendance.order_number(member_attendance.due_date, member_attendance)