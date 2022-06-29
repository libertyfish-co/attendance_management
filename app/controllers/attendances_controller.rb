class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]

  # GET /attendances or /attendances.json
  def index
    @month = params['date'].blank? ? 
      Time.zone.now : Time.parse(params['date'])

    @nav_prev = @month.prev_month.strftime("%Y%m")

    @nav_next = @month.next_month.strftime("%Y%m")

    @attendances = @emp.attendances.monthly_attendance_record(@month,:month,:attendance_details).
      order(base_date: "ASC").process_in_month

    @sum = @emp.attendances.select_at(@month,:month).aggregate_time
  end

  # GET /attendances/1 or /attendances/1.json
  def show
  end
  
  def week
  end

  # GET /attendances/new
  def new
    @orders = Order.all
    @works  = Work.all
    if((ada = Employee.first.attendances.select_attendance_by_date(Time.now)).nil?)
      @attendance = Employee.first.attendances.build
      # @ada_details = AttendanceDetail.init_attendance_detail
      # 10.times do |i|
      #   @ada_details = @attendance.attendance_details.build(start_time:nil,end_time:nil,order_id:nil,work_id:nil,work_content:nil)
      # end
      @ada_details = @attendance.attendance_details.build(start_time:nil,end_time:nil,order_id:nil,work_id:nil,work_content:nil)
    else
      @attendance = ada
      @ada_details = ada.attendance_details.build
    end
  end

  # GET /attendances/1/edit
  def edit
    @orders = Order.all
    @works  = Work.all
  end

  # POST /attendances or /attendances.json
  def create
    @attendance = Attendance.new(create_attendance_params)

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
    @orders = Order.all
    @works  = Work.all
    respond_to do |format|
      if @attendance.update!(create_attendance_params)
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

    def create_attendance_params
      params.require(:attendance).permit(:employee_id, :base_date, attendance_details_attributes: [:start_time, :end_time, :order_id, :work_id, :work_content])
    end

    def month_params
      
    end
end
