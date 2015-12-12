FactoryGirl.define do
  factory :auction do
    sequence(:title) { Faker::Company.bs }
    detail Faker::Lorem.paragraph
    end_date 30.days.from_now
    sequence(:price) { 11 + rand(1000000)}
  end

end
