# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  email             :string(255)
#  display_name      :string(255)
#  login_name        :string(255)      not null
#  password_digest   :string(255)
#  remember_digest   :string(255)
#  admin             :boolean          default(FALSE)
#  activation_digest :string(255)
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  reset_digest      :string(255)
#  reset_sent_at     :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  uid               :string(255)
#  provider          :string(255)
#  image_url         :string(255)
#

FactoryBot.define do
  factory :user, class: User, aliases: [:owner] do
    sequence(:login_name) { |n| "hoge#{n}" }
    sequence(:email) { |n| "hoge#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
    activated { true }
    activated_at { Time.zone.now }

    trait :admin do
      admin { true }
    end

    trait :not_activate do
      activated { false }
      activated_at { nil }
    end
  end

  factory :unactivated_user, class: User do
    login_name { 'misokun' }
    email { 'misokun@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
    activated { false }
  end
end
