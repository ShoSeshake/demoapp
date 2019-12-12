FactoryBot.define do
  factory :area, class: Area do
    name              {Faker::JapaneseMedia::OnePiece.character}
    description                 {Faker::Internet.email}
    image              {File.open("#{Rails.root}/public/images/test_image.jpg")}
    limit              {Faker::Games::Pokemon.move}
    term              {Faker::Games::Pokemon.move}
    ancestry              {Faker::Games::Pokemon.move}
  end
end
