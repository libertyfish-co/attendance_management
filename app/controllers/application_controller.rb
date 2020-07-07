class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters,if: :devise_controller?
    
    protected
        def configure_permitted_parameters
            sign_in_params = [:emp_num,:password]
            sign_up_params = [:emp_num,:emp_name,:email,:password,:password_confirmation]
            
            devise_parameter_sanitizer.permit(:sign_up,keys: sign_up_params)
            devise_parameter_sanitizer.permit(:sign_in,keys: sign_in_params)
        end
    
end
