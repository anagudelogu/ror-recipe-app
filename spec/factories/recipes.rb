FactoryBot.define do
  factory :recipe do
    name { 'MyString' }
    preparation_time { '2022-08-29 16:27:34' }
    cooking_time { '2022-08-29 16:27:34' }
    description { 'MyText' }
    public { false }
    user
  end
end
