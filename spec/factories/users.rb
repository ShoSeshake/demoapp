FactoryBot.define do
  factory :user, class: User do
    name              {Faker::JapaneseMedia::OnePiece.character}
    email                 {Faker::Internet.email}
    password              {"00000000"}
    password_confirmation {"00000000"}
    profile              {Faker::Games::Pokemon.move}
    icon              {File.open("#{Rails.root}/public/images/test_image.jpg")}
    background_image  {File.open("#{Rails.root}/public/images/test_image.jpg")}
    ticket            {10}
    adviser           {0}
    admin              {0}
  end

  factory :adviser, class: User do
    name              {Faker::JapaneseMedia::OnePiece.character}
    email                 {Faker::Internet.email}
    password              {"00000000"}
    password_confirmation {"00000000"}
    profile              {Faker::Games::Pokemon.move}
    icon              {File.open("#{Rails.root}/public/images/test_image.jpg")}
    background_image  {File.open("#{Rails.root}/public/images/test_image.jpg")}
    adviser           {1}
    area_id           {1}
    admin              {0}
    schedules {[
      FactoryBot.build(:schedule, user: nil)
    ]}
  end
end
