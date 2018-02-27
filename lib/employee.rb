# frozen_string_literal: true

# Defines an employee
class Employee
  attr_reader :id,
              :name,
              :role,
              :start_date,
              :end_date

  def initialize(id, name, role, start_date, end_date)
    @id = id.to_i
    @name = name
    @role = role
    @start_date = Date.parse start_date
    @end_date = Date.parse end_date
  end

  def self.validate(data)
    return false if data.length != 5
    return false if data[0].to_i.to_s != data[0]
    begin
      Date.parse(data[3])
      Date.parse(data[4])
    rescue ArgumentError
      return false
    end
    true
  end
end
