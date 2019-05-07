class User < ApplicationRecord
    has_many:attendances,dependent: :destroy
    has_secure_password
    validates :name,presence:true,length:{maximum:30}
    EMAIL= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },format: { with: EMAIL },
                    uniqueness: { case_sensitive: false }
    validates :password,presence:true,length:{maximum:30},allow_nil:true
    validates :belongs,length:{in: 0..30},allow_blank:true
end
