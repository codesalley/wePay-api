class User < ApplicationRecord
    has_secured_password
    
    has_one :wallet, class_name: "wallet", foreign_key: "wallet_id"
end
