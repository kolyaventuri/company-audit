# frozen_string_literal: true

require './modules/date_handler'

# Defines an employee
class Employee
  include DateHandler

  attr_reader :id,
              :name,
              :role,
              :start_date,
              :end_date

  def initialize(id, name, role, start_date, end_date)
    @id = id.to_i
    @name = name
    @role = role
    @start_date = DateHandler.string_to_date start_date
    @end_date = DateHandler.string_to_date end_date
  end

  def self.validate(data)
    return false if data.length != 5
    return false if data[0].to_i.to_s != data[0]
    begin
      DateHandler.string_to_date data[3]
      DateHandler.string_to_date data[4]
    rescue ArgumentError
      return false
    end
    true
  end
end
