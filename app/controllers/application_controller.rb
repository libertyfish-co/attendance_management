class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        attendances_path
    end
end
