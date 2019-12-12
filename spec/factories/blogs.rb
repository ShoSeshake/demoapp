FactoryBot.define do
  factory :blog, class: Blog do
    title              {Faker::Superhero.name}
    text                {Faker::Music.band}
    user
  end
end
