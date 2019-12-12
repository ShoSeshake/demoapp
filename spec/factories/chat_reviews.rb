FactoryBot.define do
  factory :chat_review, class: ChatReview do
    text              {Faker::JapaneseMedia::OnePiece.character}
    score              {10}
    chat
    user
    reviewee
  end
end
