FactoryBot.define do
  factory :schedule, class: Schedule do
    availability    {0}
    day             {1}
    start_time    {Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default)}
    end_time       {Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default)}
    user
  end
end
