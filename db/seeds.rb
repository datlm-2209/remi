# db/seeds.rb

Video.destroy_all
User.destroy_all

# Seed Users
users = 3.times.map do
  User.create!(
    username: Faker::Internet.username(specifier: 5..8),
    email: Faker::Internet.email,
    password: 'password'
  )
end

# Create Test User
User.create!(
  username: "test_user",
  email: "test@test.com",
  password: 'password'
)

puts "#{User.count} users created."

# Seed Videos
videos = [
  { url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', user_id: users.sample.id },
  { url: 'https://www.youtube.com/watch?v=RtBbinpK5XI', user_id: users.sample.id },
  { url: 'https://www.youtube.com/watch?v=QBK6xymmKHM', user_id: users.sample.id }
]

videos.each do |video_data|
  Video.create(video_data)
end

puts "#{Video.count} videos created."
