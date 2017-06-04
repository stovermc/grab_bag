require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)
total_users = 101

total_users.times do |n|
  user = User.create!(name: Faker::LordOfTheRings.character,
              username: "user#{n}",
              email: Faker::Internet.safe_email,
              phone: '5555555555',
              status: 'active',
              password: 'banana',
              avatar_url: Faker::Avatar.image("#{Faker::Internet.email}"),
              created_at: Date.today - rand(365))
  puts "User #{user.username} created"


  folder1 = Folder.create!(name: "Food", parent: user.home)
  folder2 = Folder.create!(name: "Pies", parent: folder1)
  puts "Folder #{folder2.name} created within #{folder1.name}!"

  binary2 = Binary.create!(name: "Pizza", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/1701grabbag/uploads/pizza.png", extension: ".png")
  binary3 = Binary.create!(name: "Stromboli", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/1701grabbag/uploads/stromboli.jpg", extension: ".jpg")
  binary1 = Binary.create!(name: "Bratwurst", folder: user.home, data_url: "https://s3-us-west-1.amazonaws.com/1701grabbag/uploads/recipe_grilled-brat.pdf", extension: ".pdf")
  puts "Binary #{binary1.name}, #{binary2.name}, and #{binary3.name}, created in home folder."
  binary4 = Binary.create!(name: "Blackberry Pie is ok", folder: folder2, data_url: "https://s3-us-west-1.amazonaws.com/1701grabbag/uploads/blackberry_pie.txt", extension: ".txt")
  puts "Binary #{binary4.name}, created in #{folder2.name} folder."

  if n % 10 == 0
    user.folders_shared_with << User.last(3).first.home
    folder3 = Folder.create!(name: "Pub Folder#{n}", parent: user.home, permission: 'root_global')
    folder4 = Folder.create!(name: "Pies#{n}", parent: folder1)
    folder5 = Folder.create!(name: "Internal Pub Folder#{n}", parent: folder3, permission: 'global')
    binary3 = Binary.create!(name: "Strombolies#{n}", folder: folder3, data_url: "https://s3-us-west-1.amazonaws.com/1701grabbag/uploads/stromboli.jpg", extension: ".jpg")
    binary5 = Binary.create!(name: "Stromb#{n}", folder: folder4, data_url: "https://s3-us-west-1.amazonaws.com/1701grabbag/uploads/stromboli.jpg", extension: ".jpg")
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

# BinaryDownload.create!(user_id: rand(total_users), binary_id: rand(total_users))
