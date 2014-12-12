require 'shift_planning/api_error'
require 'shift_planning/connection'
require 'shift_planning/api_module'

class ShiftPlanning::Client
  attr_reader :connection

  def initialize(key)
    @connection = ShiftPlanning::Connection.new(key)
    draw_routes
  end

  private

  def draw_routes
    # API map
    api_module :staff do |m|
      m.get :login, [:username, :password]
      m.get :logout

      m.get :employees
      m.create :employees

      m.get :employee, [:id]
      m.create :employee
      m.update :employee, [:id]
      m.delete :employee, [:id]

      m.get :skills
      m.get :skill, [:id]
      m.create :skill, [:name]
      m.update :skill, [:id, :name]
      m.delete :skill, [:id]

      m.get :customfields
      m.get :customfield, [:id]
      m.create :customfield, [:name, :type]
      m.update :customfield, [:id]
      m.delete :customfield, [:id]

      m.create :ping, [:to, :message]

      m.update :formatcheck, [:type]

      m.get :leavetypes
      m.update :leavetypes, [:id]
    end

    api_module :terminal do |m|
      m.get :login, [:terminal_key]
      m.get :clockin, [:terminal_key]
      m.get :clockout, [:terminal_key]
    end

    api_module :location do |m|
      m.get :locations

      m.get :location, [:id]
      m.create :location, [:name, :type]
      m.update :location, [:id]
      m.delete :location, [:id]
    end

    api_module :api do |m|
      m.get :methods
      m.get :config
    end

    api_module :timeclock do |m|
      m.get :timeclocks

      m.get :timeclock, [:id]
      m.create :timeclock, [:start_date, :schedule, :employee, :start_time]
      m.update :timeclock, [:id]
      m.delete :timeclock, [:id]

      m.get :clockin

      m.get :preclockin
      m.create :preclockin

      m.get :preclockins

      m.get :clockout

      m.get :status

      m.get :manage, [:id, :action]

      m.get :screenshots

      m.create :screenshot, [:filedata]

      m.create :event, [:timeclock, :type]
      m.update :event, [:timeclock, :type]
      m.delete :event, [:timeclock, :type, :event]

      m.get :timesheets

      m.get :addclocktime, [:employee, :datein]

      m.get :savenote, [:id]

      m.get :forceclockout, [:id]

      m.create :location, [:name]
      m.delete :location, [:id]

      m.create :terminal, [:name, :location]
      m.update :terminal, [:id]
      m.delete :terminal, [:id]
    end

    api_module :schedule do |m|
      m.get :schedules

      m.get :schedule, [:id]
      m.create :schedule, [:name]
      m.update :schedule, [:id]
      m.delete :schedule, [:id]

      m.get :shifts

      m.get :shift, [:id]
      m.create :shift, [:start_time, :end_time, :start_date, :end_date]
      m.update :shift, [:id]
      m.delete :shift, [:id]

      m.get :shiftapprove, [:id]
      m.create :shiftapprove, [:id]
      m.update :shiftapprove #?
      m.delete :shiftapprove, [:id]

      m.get :trades

      m.get :trade, [:id]
      m.create :trade, [:shift, :tradewith, :reason]
      m.update :trade, [:trade, :action]

      m.get :tradelist, [:id]

      m.create :tradeswap, [:shift, :swap, :reason]
      m.update :tradeswap, [:trade, :action]

      m.get :vacations

      m.get :vacation, [:id]
      m.create :vacation, [:start_date, :end_date]
      m.update :vacation, [:id]
      m.delete :vacation, [:id]

      m.get :collisions, [:start_date, :end_date]

      m.get :conflicts

      m.get :copy, [:from_start, :from_end, :to_start, :to_end]

      m.get :clear

      m.get :restore

      m.get :wizard, [:from_start, :from_end, :to_start, :to_end]

      m.update :adjust, [:from, :to, :budge]

      m.get :fill, [:shifts]

      m.get :publish, [:shifts]

      m.update :requests, [:id, :type, :mode]

      m.create :ical, [:url, :name]
      m.update :ical, [:ical_id]
      m.get :ical # [:id] ?
      m.delete :ical # [:ical_id] ?

      m.create :ical_events, [:ical_id]
      m.update :ical_events #?
      m.get :ical_events
      m.delete :ical_events # [:ical_event_id] ?

      m.get :breakrule, [:id]
      m.create :breakrule, [:id, :break, :paid]
      m.delete :breakrule, [:id]

      m.create :shiftrequests, [:shift]

      m.get :notes, [:start_date]

      m.get :note, [:id]
      m.create :note, [:date, :note]
      m.update :note, [:id]
      m.delete :note, [:id]

      m.get :count_notes, [:start_date, :end_date]

      m.get :publish_note, [:id]
    end
  end

  def api_module(name, &block)
    mod = Class.new(ShiftPlanning::ApiModule)
    block.call(mod)
    self.class.class_eval { attr_reader name }
    instance_variable_set "@#{ name }", mod.new(connection, name)
  end
end
