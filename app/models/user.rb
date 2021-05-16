class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :pin, presence: true, length: {minimum:4, maximum:4}
    
    has_one :wallet, class_name: "Wallet", foreign_key: "user_id", dependent: :destroy
end
