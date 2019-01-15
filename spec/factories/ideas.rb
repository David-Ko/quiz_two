FactoryBot.define do
  factory :idea do
    association(:user, factory: :user)
    title { Faker::Job.title }
    body { Faker::Job.field }
  end
end
