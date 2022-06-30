class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]

  # GET /attendances or /attendances.json
  def index
    @month = params['date'].blank? ? 
      Time.current : Time.parse(params['date'])

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
    @current = params['date'].blank? ? 
      Time.current : Time.parse(params['date'])
    @orders = Order.all
    @works  = Work.all

    if((ada = @emp.attendances.select_attendance_by_date(@current)).nil?)
      @attendance = @emp.attendances.build
      @ada_details = @attendance.attendance_details.init_attendance_detail(@attendance.id)

    else
      @attendance = ada
      @ada_details = ada.attendance_details.init_attendance_detail(@attendance.id)

    end
  end

  # GET /attendances/1/edit
  def edit
    @orders = Order.all
    @works  = Work.all
  end

  # POST /attendances or /attendances.json
  def create
    @attendance = Attendance.new(filter_with_filled_form)

    respond_to do |format|
      if @attendance.save
        Attendance.calc_times_and_consistency_flg_and_save(@attendance.attendance_details)
        format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully created." }
        format.json { render :new, status: :created, location: @attendance }
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
      if @attendance.update!(filter_with_filled_form)
        Attendance.calc_times_and_consistency_flg_and_save(@attendance.attendance_details)
        format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully updated." }
        format.json { render :new, status: :ok, location: @attendance }
      else
        format.html { render :new, status: :unprocessable_entity }
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
      params.require(:attendance).permit(:employee_id, :base_date, attendance_details_attributes: [:id, :start_time, :end_time, :order_id, :work_id, :work_content])
    end

    def filter_with_filled_form
      result = create_attendance_params
      result[:attendance_details_attributes] = result[:attendance_details_attributes].select{|k,v|!v[:start_time].blank?&&!v[:end_time].blank?}
      result
    end

end
