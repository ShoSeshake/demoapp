FactoryBot.define do
  factory :voice, class: Voice do
    text              {Faker::JapaneseMedia::OnePiece.character}
    chat
    user
  end
end
