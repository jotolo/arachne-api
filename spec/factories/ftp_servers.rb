FactoryBot.define do
  factory :ftp_server do
    name {Faker::Internet.domain_name}
    host {Faker::Internet.ip_v4_address}
    user {Faker::Internet.user_name(8)}
    password {Faker::Internet.password}
  end
end
