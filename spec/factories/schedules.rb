FactoryBot.define do
  factory :schedule, class: Schedule do
    name              {Faker::JapaneseMedia::OnePiece.character}
    email                 {Faker::Internet.email}
    password              {"00000000"}
    password_confirmation {"00000000"}
    profile              {Faker::Games::Pokemon.}
    icon              {File.open("#{Rails.root}/public/images/test_image.jpg")}
    background_image  {File.open("#{Rails.root}/public/images/test_image.jpg")}
    ticket            {0}
    adviser           {0}
    area_id           {1}
    admin              {0}
  end
end
