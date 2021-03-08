namespace :init do
  desc "TODO"
  task create_fixed_appointments: :environment do
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
