FactoryBot.define do
  factory :food do
    name { 'MyString' }
    measurement_unit { 'MyString' }
    price { 1.5 }
    quantity { 1 }
    user
  end
end
