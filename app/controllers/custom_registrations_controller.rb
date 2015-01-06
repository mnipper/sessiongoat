class CustomRegistrationsController < Devise::RegistrationsController
  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(resource_params)
  end

  private :resource_params
end
