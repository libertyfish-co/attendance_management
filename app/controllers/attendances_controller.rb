class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]

  # GET /attendances or /attendances.json
  def index

    @orders = Order.all

    @month = params['date'].blank? ? 
      Time.current : Time.parse(params['date'])

    @nav_prev = @month.prev_month.strftime("%Y/%m")

    @nav_next = @month.next_month.strftime("%Y/%m")

    @attendances = @emp.attendances.monthly_attendance_record(@month).
      order(base_date: "ASC").process_in_month(@month)

    @sum = @emp.attendances.select_at(@month,:month).aggregate_time

  end

  def check
    @month = params['date'].blank? ? 
      Time.current : Time.parse(params['date'])
      
    @errors = @emp.attendances.monthly_attendance_record(@month).
      valid_check(BusinessCalendar.public_holidays(@month))

    respond_to do |format|
      format.html
      format.js
    end

  end

  def orders
    @month = params['date'].blank? ? 
    Time.current : Time.parse(params['date'])
    
    orders = params.require(:attendance_detail).permit(orders: {})
    
    order_ids = orders[:orders].values.reject{|v| v.blank?}
    
    attd_arr = @emp.attendances.monthly_attendance_record(@month).order(base_date: "ASC").
    filter{|r| r.attendance_details.where(order_id: order_ids).length > 0}
    
    @attendances = Attendance.where(id: attd_arr.map{ |attd| attd.id}).
        process_in_month(@month)
    
    @sum = @emp.attendances.select_at(@month,:month).aggregate_time

      respond_to do |format|
        format.html
        format.js
      end
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
    @nav_prev = @current.prev_day.strftime("%Y/%m/%d")
    @nav_next = @current.next_day.strftime("%Y/%m/%d")
    @orders = Order.all
    @works  = Work.all

    if((ada = @emp.attendances.select_attendance_by_date(@current).first).nil?)
      @attendance = @emp.attendances.build
      @ada_details = @attendance.attendance_details.init_attendance_detail(@attendance.id)

    else
      @attendance = ada
      @ada_details = ada.attendance_details.init_attendance_detail(@attendance.id)

    end
    @errors = errors = AttendanceDetail.valid?(@attendance.attendance_details)

    if ((warning = AttendanceDetail.warning?(@attendance.attendance_details)).length > 0)
      @errors += warning
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
    if ((errors = AttendanceDetail.valid?(@attendance.attendance_details)).length) > 0
      flash.now[:errors] = errors
    end

    if ((warning = AttendanceDetail.warning?(@attendance.attendance_details)).length > 0)
      flash[:warning] = warning
    end

    ActiveRecord::Base.transaction do
        if @attendance.save
          Attendance.calc_times_and_consistency_flg_and_save(@attendance.attendance_details)
          flash[:success] = '登録に成功しました。'
          redirect_to new_attendance_path(date: @attendance.base_date)
        else
          render :new
        end
      end
  end

  # PATCH/PUT /attendances/1 or /attendances/1.json
  def update
    @orders = Order.all
    @works  = Work.all
    @errors = errors = AttendanceDetail.valid?(@attendance.attendance_details)

    if ((warning = AttendanceDetail.warning?(@attendance.attendance_details)).length > 0)
      @errors += warning
    end
    ActiveRecord::Base.transaction do
      if errors.length < 1 && @attendance.update!(filter_with_filled_form)
        Attendance.calc_times_and_consistency_flg_and_save(@attendance.attendance_details)
        @errors = [['success', '登録に成功しました。']]
      end
      redirect_to action: :new, date: @attendance.base_date
    end
  end

  # DELETE /attendances/1 or /attendances/1.json
  def destroy

    dt = Time.parse(Regexp.new('\d{4}-\d{2}-\d{2}').match(request.referer)[0])

    attendance = Attendance.find_by(id: params[:id])

    attendance.destroy if attendance

    @attendance = @emp.attendances.build(base_date: dt)

    @ada_details = @attendance.attendance_details.init_attendance_detail(@attendance.id)

    redirect_to action: :new, date: dt

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
      params.require(:attendance).permit(:id, :employee_id, :base_date, attendance_details_attributes: [:id, :start_time, :end_time, :order_id, :work_id, :work_content])
    end

    def filter_with_filled_form
      result = create_attendance_params
      result[:attendance_details_attributes] = result[:attendance_details_attributes].select{|k,v|!v[:start_time].blank?&&!v[:end_time].blank?}
      result
    end

end
