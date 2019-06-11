class User < ApplicationRecord
    has_many:attendances,dependent: :destroy
    has_many:sends,dependent: :destroy
    has_many:send2s,dependent: :destroy
    has_many :notices
    
    has_secure_password
    validates :name,presence:true,length:{maximum:30}
    EMAIL= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 100 },format: { with: EMAIL },
                    uniqueness: { case_sensitive: false }
    validates :password,presence:true,length:{maximum:30},allow_nil:true
    validates :affiliation,length:{in: 0..30},allow_blank:true,presence:true
    
    def self.import(file)
        CSV.foreach(file.path,headers:true) do |row|
            user=find_by(id:row['id']) || new
            user.attributes=row.to_hash.slice(*import_parameters)
            user.save!
            if user.superior==true
                Notice.create!(user_id:user.id)
            end        
        end        
    end
    
    def self.import_parameters
        ["name","email","affiliation","employee_number","uid",
         "basic_work_time","designated_work_start_time","designated_work_end_time",
         "superior","admin","password"]
    end        
end
