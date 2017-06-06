FactoryGirl.define do
  factory :application, class: Doorkeeper::Application do
    sequence(:name) { |n| "Application #{n}" }
    redirect_uri 'https://app.com/callback'
  end

  factory :access_token, class: Doorkeeper::AccessToken do
    sequence(:resource_owner_id) { |n| n }
    application
    expires_in 2.hours

    factory :clientless_access_token do
      application nil
    end
  end
  
  factory :user, aliases: [:owner] do
    sequence :name do |n|
      "Name ##{n}"
    end
    sequence :username do |n|
      "username#{n}"
    end
    status 'active'
    sequence :email do |n|
      "email#{n}@email.com"
    end
    phone '5555555555'

    sequence :fb_id do |n|
      n.to_s
    end
    token ENV['facebook_token']
    avatar_url 'https://socwork.wisc.edu/files/joe-glass-lg.jpg'

    factory :regular_user do
      token nil
      fb_id nil
      password 'banana'
      password_confirmation 'banana'
    end

    factory :inactive_user do
      status 'inactive'
    end

    factory :admin do
      role 'admin'
    end

    factory :user_with_folders do
      after(:create) do |user|
        3.times do
          user.home.folders << create(:folder, parent: user.home)

          user.home.binaries << create(:binary, folder: user.home)
        end
      end
    end
    
    factory :user_with_various_binary_types do
      after(:create) do |user|
        user.home.binaries << create(:binary, folder: user.home)
        user.home.binaries << create(:image_binary, folder: user.home)
        user.home.binaries << create(:image_2_binary, folder: user.home)
        user.home.binaries << create(:pdf_binary, folder: user.home)
      end
    end

    factory :user_with_public_folders do
      after(:create) do |user|
        user.home.folders << create(:folder, parent: user.home, permission: "root_global")
        2.times do
          create(:folder, parent: user.owned_folders.second, permission: 'global')
          create(:binary, folder: user.owned_folders.second)
        end
      end
    end
  end

  factory :folder do
    sequence :name do |n|
      "Factory Folder#{n}"
    end
    route '/home'
    owner
  end

  factory :binary, aliases: [:text_binary] do
    sequence :name do |n|
      "File#{n}"
    end
    extension 'txt'
    data_url 'http://textfiles.com/100/914bbs.txt'

    factory :image_binary do
      name 'imgur'
      extension 'jpg'
      data_url 'http://i.imgur.com/nBYOnvl.jpg'
    end
    
    factory :image_2_binary do
      name 'imgur2'
      extension 'png'
      data_url 'http://i.imgur.com/nBYOnvl.png'
    end

    factory :pdf_binary do
      name 'pizza'
      extension 'pdf'
      data_url 'https://www.josh.org/wp-content/uploads/Pizza-for-Everyone.pdf'
    end

    factory :unknown_content_type_binary do
      extension 'ummm'
      data_url "I'm a number!"
    end
  end

  factory :comment do
    before(:create) do |comment|
      user = create(:user)
      comment.binary = create(:binary, folder: user.home)
    end
    text "Comment"
    user
  end
end
