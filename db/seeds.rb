require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)
@total_users = 100
@public_binaries = []

def add_random_binary(folder)
  binaries = [Binary.new(name: "Pizza", folder: folder, data_url: "https://s3-us-west-1.amazonaws.com/1701grabbag/uploads/pizza.png", extension: "png"),
              Binary.new(name: "Stromboli", folder: folder, data_url: "https://s3-us-west-1.amazonaws.com/1701grabbag/uploads/stromboli.jpg", extension: "jpg"),
              Binary.new(name: "Bratwurst", folder: folder, data_url: "https://s3-us-west-1.amazonaws.com/1701grabbag/uploads/recipe_grilled-brat.pdf", extension: "pdf"),
              Binary.new(name: "Blackberry Pie is ok", folder: folder, data_url: "https://s3-us-west-1.amazonaws.com/1701grabbag/uploads/blackberry_pie.txt", extension: "txt")]
  binaries.sample
end

def download_own_file(user, binary)
  BinaryDownload.create(user: user, binary: binary, created_at: user.created_at + rand(100))
end

def download_public_file
  binary = @public_binaries.sample
  user = User.find(1 + rand(@total_users))
  BinaryDownload.create(user: user, binary: binary, created_at: user.created_at + rand(100))
end

@total_users.times do |n|
  user = User.create!(name: Faker::LordOfTheRings.character,
              username: "user#{n}",
              email: Faker::Internet.safe_email,
              phone: '5555555555',
              status: 'active',
              password: 'banana',
              avatar_url: Faker::Avatar.image("#{Faker::Internet.email}"),
              created_at: Date.current - rand(365))
  puts "User #{user.username} created"


  folder1 = Folder.create!(name: "Food", parent: user.home)
  folder2 = Folder.create!(name: "Pies", parent: folder1)
  puts "Folder #{folder2.name} created within #{folder1.name}!"


  2.times do |n|
    binary = add_random_binary(user.home)

    if binary.save
      puts "Binary #{binary.name} created in home folder."

      rand(5).times do |n|
        download_own_file(user, binary)
      end
    end
  end

  if n % 10 == 0
    user.folders_shared_with << User.last(3).first.home
    folder3 = Folder.create!(name: "Pub Folder#{n}", parent: user.home, permission: 'root_global')
    folder4 = Folder.create!(name: "Internal Pub Folder#{n}", parent: folder3, permission: 'global')

    binary = add_random_binary(folder3)
    @public_binaries << binary
    binary.save!
    puts "Binary #{binary.name} created in root_global folder."

    binary = add_random_binary(folder4)
    @public_binaries << binary
    binary.save!
    puts "Binary #{binary.name} created in global folder."
  end


  user.owned_folders.each do |folder|
    folder.binaries.each do |binary|
      count = 0
      2.times do
        binary.comments.create!(text: "This is comment ##{count += 1}", user_id: user.id)
        binary.likes.create!(user_id: user.id, likeable_type: "Binary", likeable_id: 1)
        # comment1 = binary1.comments.create(text: "This is a commment #1", user_id: user.id)
        # binary4.likes.create(user_id: user.id, likeable_type: "Binary", likeable_id: 1)
      end
    end
  end

  user.comments.each do |comment|
    2.times do
      comment.likes.create!(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
      # comment1.likes.create(user_id: user.id, likeable_type: "Comment", likeable_id: 1)
    end
  end
  n += 1
  puts "Created #{user.name}"
end

User.last.update(name: 'Gandalf', role:'admin', username: "admin1", avatar_url: "https://thumb.ibb.co/htakav/default_profile.jpg")

100.times do |n|
  download_public_file
end

50.times do |n|
  weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  durations = (500..50000)
  SessionStat.create(log_in_day: weekdays.sample, duration: rand(durations))
end
