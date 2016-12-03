FactoryGirl.define do
  factory :player do
    sequence :name do |n|
      "player_#{n}"
    end
  end
end
