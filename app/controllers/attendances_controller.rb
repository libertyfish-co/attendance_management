class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]

  # GET /attendances or /attendances.json
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/1 or /attendances/1.json
  def show
  end

  # GET /attendances/1/YYYYMM or /attendances/1/YYYYMM.json
  def month
    month = params['date'].blank? ? Time.zone.now.strftime('%Y%m') : params['date']
    @month_date = (month + '01').to_date
    @nav_prev = @month_date.prev_month.strftime("%Y%m")
    @nav_next = @month_date.next_month.strftime("%Y%m")
    @dw = ["日", "月", "火", "水", "木", "金", "土"]
    @employee = current_employee
    
    
    @corporation = Corporation.find(@employee.corporation.id)
    @attendances = @employee.attendances.where(base_date: @month_date.beginning_of_month..@month_date.end_of_month, employee_id: @employee.id).includes(:attendance_details).references(:attendance_details).order(base_date: "ASC")
    @attendance_array = @attendances.to_a

    @business_calendar = BusinessCalendar.where(date: @month_date.beginning_of_month..@month_date.end_of_month, proparties: 1, corporation_id: @corporation.id).order(date: "ASC")

    # それぞれの合計時間を出す
    # 作業 休憩は稼働がないときは表に表示させないようにしているため、計算対象に入らないので稼働があるときのみ加算
    @sum_work_time = Attendance.where(base_date: @month_date.beginning_of_month..@month_date.end_of_month, employee_id: @employee.id).all.sum(:operating_time) + Attendance.where(base_date: @month_date.beginning_of_month..@month_date.end_of_month, employee_id: @employee.id).where.not(operating_time: nil).all.sum(:break_time) 

    # 休憩 稼働がなければ表示しないため稼働があるときのみ加算
    @sum_break_time = Attendance.where(base_date: @month_date.beginning_of_month..@month_date.end_of_month, employee_id: @employee.id).where.not(operating_time: nil).all.sum(:break_time)

    # 稼働
    @sum_operating_time = Attendance.where(base_date: @month_date.beginning_of_month..@month_date.end_of_month, employee_id: @employee.id).all.sum(:operating_time)

    # 有給一般
    @sum_paid_time = Attendance.where(base_date: @month_date.beginning_of_month..@month_date.end_of_month, employee_id: @employee.id).all.sum(:paid_time)

    # 有給特別
    @sum_special_paid_time = Attendance.where(base_date: @month_date.beginning_of_month..@month_date.end_of_month, employee_id: @employee.id).all.sum(:special_paid_time)

    # 実働
    @sum_actual_time = @sum_work_time = Attendance.where(base_date: @month_date.beginning_of_month..@month_date.end_of_month, employee_id: @employee.id).all.sum(:operating_time) + Attendance.where(base_date: @month_date.beginning_of_month..@month_date.end_of_month).all.sum(:paid_time) + Attendance.where(base_date: @month_date.beginning_of_month..@month_date.end_of_month).all.sum(:special_paid_time)

    # 控除
    @sum_deduction_time = Attendance.where(base_date: @month_date.beginning_of_month..@month_date.end_of_month, employee_id: @employee.id).all.sum(:deduction_time)
  end
    
  def week
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances or /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully created." }
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
        format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully updated." }
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
      format.html { redirect_to attendances_url, notice: "Attendance was successfully destroyed." }
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

    def month_params
      
    end
end
