FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end

    name { 'name' }
    password { '123456' }
  end
end
