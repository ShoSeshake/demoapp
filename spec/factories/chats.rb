FactoryBot.define do
  factory :chat, class: Chat do
    user_peer_id              {Faker::JapaneseMedia::OnePiece.character}
    adviser
    user
  end
end
