FactoryBot.define do
  factory :client do
    name { "JoungSik-Desktop" }
    email { "example@example.com" }
    phone { "+82-10-3021-1717" }
    password { 'qwer1234' }
    uuid { 'a2FrYW9ib3Qgc2VydmVyIHByb2plY3QgZGV2aWNlIG5hbWU=' }
    access_token { '5j1ppbl1ofxseq5eblxlovzxd8y7gqhs9vufcx379tmxq7x69k1bw6oifsov' }
    refresh_token { 'eszhr5x6kq6kvnmtrbpy3k04w2mrikyhr1ygb7p0wnj3hk98xdf0v8erj3w7' }
    client_id { 123456789 }
  end
end
