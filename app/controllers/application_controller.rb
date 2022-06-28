class ApplicationController < ActionController::Base
    before_action :init

    def init
        @emp = Employee.first
        @corporation = Corporation.find(@emp.corporation.id)
    end
end
