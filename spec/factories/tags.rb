FactoryGirl.define do
  factory :tag, class: ActsAsTaggableOn::Tag do
    # Attributes
    name { Faker::Lorem.word }
  end
end
