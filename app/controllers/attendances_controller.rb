class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[show edit update destroy]

  # GET /attendances or /attendances.json
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/1 or /attendances/1.json
  def show; end

  def month
    month = params['yyyyMM'].blank? ? Time.zone.now.strftime('%Y%m') : params['yyyyMM']
    @month_date = (month + '01').to_date
    @dw = ["日", "月", "火", "水", "木", "金", "土"]
    #@employee = current_employee
    @employee = Employee.first

    @corporation = Corporation.find(@employee.corporation.id)

    # @attendances = Attendance.includes(:attendance_details).references(:attendance_details).where(base_date: @month_date.beginning_of_month..@month_date.end_of_month, employee_id: @employee.id)

    # @orders = Order.where(corporation_id: @corporation.id, expiration_date: @month_date.beginning_of_month..Float::INFINITY)

  end

  def week; end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit; end

  # POST /attendances or /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to attendance_url(@attendance), notice: 'Attendance was successfully created.' }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1 or /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to attendance_url(@attendance), notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1 or /attendances/1.json
  def destroy
    @attendance.destroy

    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def attendance_params
    params.require(:attendance).permit(:corporation_id, :employee_id, :start_time, :end_time, :rest_time, :work_content)
  end
end
