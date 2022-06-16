class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        attendances_path
    end

    def after_sign_out_path_for(resource)
        sign_in_path
    end
end
