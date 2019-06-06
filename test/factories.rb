FactoryBot.define do
    factory :user do
        username "Kaz"
        first_name "Kaz"
        last_name "H"
        email "hi@gmail.com"
        photo "asdf.jpg"
        password_digest "sslkdfjk"
        role "Parent"
    end
    
    factory :account do
        user_id 1
        name "Primary"
        interest_rate 10
        balance 40
        account_type "Checking"
    end
end