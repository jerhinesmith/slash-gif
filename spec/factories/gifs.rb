FactoryGirl.define do
  factory :gif do
    # Attributes
    url { Faker::Internet.url }
  end
end
