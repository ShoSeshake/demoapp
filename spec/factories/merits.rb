FactoryBot.define do
  factory :merit, class: Merit do
    title              {Faker::JapaneseMedia::OnePiece.character}
  end
end
