FactoryBot.define do
  factory :room do
    name { "example" }
    channel_id { "1234567890123456789" }
    channel_type { 'OM' }
  end
end
