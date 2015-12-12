FactoryGirl.define do
  factory :user do

    sequence(:fullname) {Faker::Name.name}
    sequence(:email) {|n| "#{n}.#{Faker::Internet.email}" }
    password Faker::Internet.password

  end

end
