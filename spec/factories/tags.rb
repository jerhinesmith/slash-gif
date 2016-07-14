FactoryGirl.define do
  factory :tag, class: ActsAsTaggableOn::Tag do
    # Attributes
    name { "#{Faker::Lorem.word}#{rand(1..1_000_000)}" }
  end
end
