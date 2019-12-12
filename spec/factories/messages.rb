FactoryBot.define do
  factory :message, class: Message do
    text              {Faker::JapaneseMedia::OnePiece.character}
    chat
    user
  end
end
