class User < ApplicationRecord
     
       attr_accessor :remember_token, :activation_token
                before_save :downcase_email
                before_create :create_activation_digest
         

	has_secure_password
	validates :p_id, :name, :dob, :phone, :address,:password,:email,:confirm_password,:presence => true
	validates :p_id, :length => { :minimum => 3}
	validates :password,:confirm_password, :length => {:minimum => 5}
	validates :phone, length: { is: 10 }
	validates :phone, numericality: { only_integer: true }
	validates :p_id, :phone,:email, uniqueness: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
        # Creates and assigns the activation token and digest.
            def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
             end
            def downcase_email
              self.email = email.downcase
             end
              def User.new_token
                 SecureRandom.urlsafe_base64
                end
                def User.digest(string)
                   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
                    BCrypt::Password.create(string, cost: cost)
                end
                    def authenticated?(attribute, token)
                   digest = send("#{attribute}_digest")
                       return false if digest.nil?
                          BCrypt::Password.new(digest).is_password?(token)
                         end
end









