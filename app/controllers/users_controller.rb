class UsersController < Clearance::UsersController

  def show
    @user = User.new(params[:user])

  end

	def user_from_params
    user_params = params[:user] || Hash.new
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    first_name = user_params.delete(:first_name)
    last_name = user_params.delete(:last_name)
    gender = user_params.delete(:gender)
    nationality = user_params.delete(:nationality)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.first_name = first_name
      user.last_name = last_name
      user.gender = gender
      user.nationality = nationality
    	end
  	end

  	def permit_params
    	params.require(:user).permit(:name, :email, :first_name, :last_name, :gender, :nationality, :encrypted_password, :password, :confirmation_token, :remember_token)
  	end
end