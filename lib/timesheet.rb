# frozen_string_literal: true

# Defines a timesheet
class Timesheet
  attr_reader :employee_id,
              :project_id,
              :date,
              :minutes

  def initialize(employee_id, project_id, date, minutes)
    @employee_id = employee_id.to_i
    @project_id = project_id.to_i
    @date = Date.parse date
    @minutes = minutes.to_i
  end

  def self.validate(data)
    return false if data.length != 4
    return false if data.include? nil
    return false unless validate_integers(data)
    begin
      Date.parse(data[2])
    rescue ArgumentError
      return false
    end
    true
  end

  def self.validate_integers(data)
    begin
      Integer(data[0])
      Integer(data[1])
      Integer(data[3])
    rescue ArgumentError
      return false
    end
    true
  end
end
