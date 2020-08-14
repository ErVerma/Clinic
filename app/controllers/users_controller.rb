class UsersController < ApplicationController
	add_flash_types :danger,:info, :success,:warning
	before_action :confirm_logged_in, :except =>[:index,:forgot_p_id,:forgot,:signup,:show,:login,:attempt_ulogin,:logout,:validate,:register,:forgot_form]
	def index
		@users= User.all
	end
	def forgot

		
	end
	def appointmentdelete
    @order = Appointment.find(params[:id])
    @slot = Doctor.find_by(slot_name: @order.slot_name)
    ###########################################################################################
  

    	@order.destroy
    	redirect_to appointment_path(session[:p_id])
   	
  	end
	def forgot_form
		@mail = forgotparams[:email]
		@fuser = User.where(:email => @mail).first
		if @fuser==nil
			redirect_to forgot_path, danger: "Email_id not found in users list!!"
		else
			UserMailer.forgot(@fuser).deliver_now
			redirect_to login_path, info: "Check your email for login credentials #{@fuser.name}"
		end

	end
	def signup
	 @user = User.new
 
              

      
          end
    def show
		redirect_to signup_path, success: "User Account Activated Succesfully!!"
	end
	def appointment
		ptid = session[:p_id]
		@appointment=Appointment.new
		@buser = User.where(:p_id => ptid).first
		
      		@temp= Appointment.where(:pid=> session[:p_id])
      		@temp.each do |list|
      			
      		end
      		
	
	end
##################BOOK Appointment


	def book_slot
	@buser = User.where(:p_id => session[:p_id]).first
            
    @appointment=Appointment.new(appointmentparams)
            ##############
                    if Date.today>=@appointment.doa || @appointment.p_name==nil
                        flash[:danger] = "Appointment Not requested Try again"
                        @appointment.destroy
   			redirect_to appointment_path(session[:p_id])
             ##################
                        else
                              username = session[:p_id]
                              found_user = User.where(:p_id => username).first
                                 found_slot = Doctor.where(:slot_name => @appointment.slot_name).first
                    if found_user # taking email in phone column
   @appointment.update_attributes(:pid => found_user.p_id ,:p_name =>  @appointment.p_name,:phone =>  found_user.email,:doa =>@appointment.doa)
 
      if @appointment.save
      
    	found_slot1 = Doctor.where(:slot_name => @appointment.slot_name).first
      		redirect_to appointment_path(session[:p_id]), success: "Appointment  Requested Successfully, You will get E-mail when your request will get accepted!! "
      	else
      		@appointment.destroy
      		redirect_to appointment_path(session[:p_id]), warning: "Appointment was not requested successfully!!"
   
      
        render '/users/appointment'
      end 
    else
      flash[:danger] = "Please try again!!"
      render '/users/appointment'
    end
    end

  end
	def login

	end
	

 def attempt_ulogin   
  	username=uloginparams[:p_id]
  	password=uloginparams[:password]
  	if username.present? && password.present?
               found_user = User.where(:p_id => username).first
               if found_user && found_user.activated?
                     authorized_user = found_user.authenticate(uloginparams[:password])
                                           if authorized_user
                                                 # TODO: mark user as logged in
                                                 session[:user_id]=authorized_user.id
                                                     session[:p_id]=authorized_user.p_id
                                                      redirect_to  appointment_path(session[:p_id]),success: "Hi #{session[:p_id]}"
                                               else
                                                       redirect_to login_path, danger: "Invalid Login Credentials!!"
                                               end
               else
                    message = "User Not Found or Account not activated. "
                    message += "Check your email for the activation link."
                    flash[:warning] = message
                    redirect_to root_url
             end
        end
  
  end
  
  def logout
    session[:user_id]=nil
    session[:p_id]=nil
    redirect_to home_path,info: "Logged out!!"
  end
  def confirm
    ptid = session[:p_id]
    @fuser = User.where(:p_id => ptid).first
    @mail = @fuser.email
    if @fuser==nil
      redirect_to home_path, danger: "Invalid Credentials!!"
    else
      redirect_to appointment_path(session[:p_id]), success: "You will get E-mail when your request will get accepted!!"
    end
  end
	def cancel

	end
	
	def register
                                    
		@user=User.new(regparams)
                    if Date.today-@user.dob<18
                        flash[:danger] = "User must be atleast 12 years old!!"
   			render 'signup'
                   else
                        
		   if @user.password==@user.confirm_password 
			if @user.save
    		          #redirect_to @user

                          UserMailer.account_activation(@user).deliver_now
                             flash[:info] = "Please check your email to activate your account."
                                 redirect_to root_url
                                    
  			    else
   				render 'signup'
   			end
   		else
   			flash[:danger] = "password & confirm_password doesn't match!!"
   			render 'signup'
   		end
             end

	end
	
	private
	def regparams
		params.require(:user).permit(:p_id, :name, :dob, :gender, :phone, :address, :password,:email,:confirm_password)
	end
	def validateparams
		params.require(:valid).permit(:cid)
	end
	def uloginparams
		params.require(:ulogin).permit(:p_id,:password)
	end
	def forgotparams
		params.require(:forgot).permit(:email)
	end
	 def appointmentparams
    params.require(:book_slots).permit(:p_name,:slot_name,:doa)
  	end
	private
	def confirm_logged_in
		unless session[:user_id]
			redirect_to home_path, warning: "Please Login!!"
			return false
		else
			return true
		end
	end
end

