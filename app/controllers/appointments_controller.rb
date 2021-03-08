class AppointmentsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :set_appointment, only: %i[ show edit update destroy ]

  # GET /appointments or /appointments.json
  def index
    recreateFixedAppointments # create Fixed Appointments

    @appointments = Appointment.all

    respond_to do |format|
      format.html {}
      format.json { render json: @appointments, status: :ok }
    end
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments or /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: "Appointment was successfully created." }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: "Appointment was successfully updated." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: "Appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.fetch(:appointment, {}).permit(:title, :start, :end, :allDay, :backgroundColor, :borderColor, :daysOfWeek, :startTime, :endTime, :fixed, :recurring)
    end

    def recreateFixedAppointments
        Appointment.where(fixed: true).delete_all

        Appointment.new({
          title: "Morning",
          daysOfWeek: ['1', '2', '3', '4', '5'].to_json,
          start: 0,
          end: 0,
          startTime: "00:00:00",
          endTime: "08:00:00",
          backgroundColor: "#592321",
          borderColor: "#000000",
          fixed: true,
          recurring: true
        }).save
        Appointment.new({
          title: "Evening",
          daysOfWeek: ['1', '2', '3', '4', '5'].to_json,
          start: 0,
          end: 0,
          startTime: "18:00:00",
          endTime: "24:00:00",
          backgroundColor: "#592321",
          borderColor: "#000000",
          fixed: true,
          recurring: true
        }).save
        Appointment.new({
          title: "Lunch",
          daysOfWeek: ['1', '2', '3', '4', '5'].to_json,
          start: 0,
          end: 0,
          startTime: "12:00:00",
          endTime: "13:00:00",
          backgroundColor: "#592321",
          borderColor: "#000000",
          fixed: true,
          recurring: true
        }).save
        Appointment.new({
          title: "Weekend",
          daysOfWeek: ['0', '6'].to_json,
          start: 0,
          end: 0,
          startTime: "00:00:00",
          endTime: "24:00:00",
          backgroundColor: "#592321",
          borderColor: "#000000",
          fixed: true,
          recurring: true
        }).save

        Appointment.new({
          title: "1",
          start: DateTime.parse("#{Date.today.monday}T10:15:00+01:00").to_time.to_i * 1000,
          end: DateTime.parse("#{Date.today.monday}T10:30:00+01:00").to_time.to_i * 1000,
          allDay: false,
          backgroundColor: "#808080",
          borderColor: "#000000",
          fixed: true,
          recurring: false
        }).save
        Appointment.new({
          title: "2",
          start: DateTime.parse("#{Date.today.monday + 1.days}T11:00:00+01:00").to_time.to_i * 1000,
          end: DateTime.parse("#{Date.today.monday + 1.days}T11:30:00+01:00").to_time.to_i * 1000,
          allDay: false,
          backgroundColor: "#808080",
          borderColor: "#000000",
          fixed: true,
          recurring: false
        }).save
        Appointment.new({
          title: "3",
          start: DateTime.parse("#{Date.today.monday + 1.days}T15:30:00+01:00").to_time.to_i * 1000,
          end: DateTime.parse("#{Date.today.monday + 1.days}T16:30:00+01:00").to_time.to_i * 1000,
          allDay: false,
          backgroundColor: "#808080",
          borderColor: "#000000",
          fixed: true,
          recurring: false
        }).save
        Appointment.new({
          title: "4",
          start: DateTime.parse("#{Date.today.monday + 2.days}T10:00:00+01:00").to_time.to_i * 1000,
          end: DateTime.parse("#{Date.today.monday + 2.days}T10:30:00+01:00").to_time.to_i * 1000,
          allDay: false,
          backgroundColor: "#808080",
          borderColor: "#000000",
          fixed: true,
          recurring: false
        }).save
        Appointment.new({
          title: "5",
          start: DateTime.parse("#{Date.today.monday + 2.days}T11:00:00+01:00").to_time.to_i * 1000,
          end: DateTime.parse("#{Date.today.monday + 2.days}T12:30:00+01:00").to_time.to_i * 1000,
          allDay: false,
          backgroundColor: "#808080",
          borderColor: "#000000",
          fixed: true,
          recurring: false
        }).save
        Appointment.new({
          title: "6",
          start: DateTime.parse("#{Date.today.monday + 2.days}T17:30:00+01:00").to_time.to_i * 1000,
          end: DateTime.parse("#{Date.today.monday + 2.days}T18:00:00+01:00").to_time.to_i * 1000,
          allDay: false,
          backgroundColor: "#808080",
          borderColor: "#000000",
          fixed: true,
          recurring: false
        }).save
    end
end
