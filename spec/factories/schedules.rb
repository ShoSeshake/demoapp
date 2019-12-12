FactoryBot.define do
  factory :schedule, class: Schedule do
    availability    {1}
    day             {1}
    start_time    {Time.now}
    end_time       {Time.now.since(30.minute)}
    user
  end
end
