FactoryBot.define do
  factory :chat, class: Chat do
    user_peer_id              {Faker::JapaneseMedia::OnePiece.character}
    start_at         {DateTime.now}
    adviser
    user
  end
end
