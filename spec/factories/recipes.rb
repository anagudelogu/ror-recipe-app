FactoryBot.define do
  factory :recipe do
    name { 'MyString' }
    preparation_time { 120 }
    cooking_time { 40 }
    description { 'MyText' }
    public { false }
    user
  end
end
