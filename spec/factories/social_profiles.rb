FactoryGirl.define do
  factory :social_profile do
    user

    uid { '98331318' }
    service_name  { 'twitter' }
  end
end
