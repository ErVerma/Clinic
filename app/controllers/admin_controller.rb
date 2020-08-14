class AdminController < ApplicationController
	add_flash_types :danger,:info, :success,:warning
	before_action :confirm_logged_in, :except =>[:index,:attempt_login,:logout,:forgot_password]
  
  def index
   
  end
  
  def delete
    @slot = Doctor.find(params[:id])
    @slot.destroy
    redirect_to add_path
  end
  def add
    @doctor = Doctor.new
  end
  def add_slot
    @doctor = Doctor.new(slotparams)
    if @doctor.save
        redirect_to add_path, success: "Slot added successfully!!"
        else
          render 'add'
        end
  end
  def edit
    @edit = Doctor.find(params[:id])
  end
  def update
    @edit =Doctor.find(params[:id])
 
    if @edit.update(slotparams)
      redirect_to add_path
    else
      render 'edit'
    end

  end
  def status
  end
  def status_done
    @order = Appointment.find(params[:id])
    if @order
   
   UserMailer.confirmation(@order).deliver_now
    redirect_to status_path,success: "Slot Booked for  #{@order.p_name}"
    
    
  else
    redirect_to status_path,danger: "Some Error Occured, Please Try Again!!"
  end
  end
  
  def forgot_password
    redirect_to admin_path, info: "Please Contact the Manoj Verma for Password!!"
  end
  def attempt_login
  	username=adminparams[:adminid]
  	password=adminparams[:password]
  	if username.present? && password.present?
      found_user = Admin.where(:adminid => username).first
     if found_user
        authorized_user = found_user.authenticate(adminparams[:password])
      end
    end
    if authorized_user
      # TODO: mark user as logged in
      session[:user_id]=authorized_user.id
      session[:adminid]=authorized_user.adminid
      redirect_to  add_path,success: "Logged In"
    else
      redirect_to admin_path, danger: "Invalid Login Credentials!!"
    end
  end
  
  def logout
    session[:user_id]=nil
    session[:adminid]=nil
    redirect_to home_path,info: "Logged out!!"
  end
  private
  def adminparams
		params.require(:adminlogin).permit(:adminid,:password)
	end
  private
  def slotparams
    params.require(:doctor).permit(:slot_name)
  end
  private
  def editparams
    params.require(:edits).permit(:slot_name)
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
