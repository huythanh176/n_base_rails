# Create user
5.times do |index|
  User.create email: "user#{index}@gmail.vn", password: "Aa@123456"
end

# Create Admin
Admin.create email: "admin@gmail.vn", password: "Aa@123456"