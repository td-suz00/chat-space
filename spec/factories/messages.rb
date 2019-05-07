FactoryBot.define do

  factory :message do
    text    {Faker::Lorem.sentence}
    image   {File.open("#{Rails.root}/public/ねこ.jpeg")}
    user
    group
  end

end
