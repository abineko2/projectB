class User < ApplicationRecord
    has_secure_password
    validates :name,presence:true,length:{maximum:30}
    validates :email,presence:true,length:{maximum:30},uniqueness:true
    validates :password,presence:true,length:{maximum:30},allow_nil:true
    validates :belongs,length:{in: 0..30},allow_blank:true
end
