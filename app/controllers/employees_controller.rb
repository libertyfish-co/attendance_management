class EmployeesController < ApplicationController
    def update
        if @employee.update(employee_params) && @employee.avatar.attach(params[:avatar])
          redirect_to employee_path(@employee)
        else
          render "edit"
        end
    end
end
