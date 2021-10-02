FactoryBot.define do
  factory :ban_keyword do
    category { 0 }
    name { "카카오톡 오픈 채팅방" }
    word { "open.kakao.com" }
  end
end
