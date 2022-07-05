class ApplicationController < ActionController::Base
    before_action :init
    before_action :authenticate_employee!

    def init
        @emp = current_employee
        #@corporation = Corporation.find(@emp.corporation.id)
    end
end