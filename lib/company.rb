# frozen_string_literal: true

require 'csv'

require_relative 'employee'

# Defines a company
class Company
  attr_reader :employees,
              :projects,
              :timesheets

  def initialize
    @employees = []
    @projects = []
    @timesheets = []
  end

  def load_employees(filename)
    CSV.foreach(
      filename
    ) do |employee_info|
      unless Employee.validate(employee_info)
        return { success: false, error: 'bad data' }
      end

      add_employee(employee_info)
    end

    { success: true, error: nil }
  end

  def add_employee(employee_info)
    employee = Employee.new(
      employee_info[0],
      employee_info[1],
      employee_info[2],
      employee_info[3],
      employee_info[4]
    )

    @employees.push(employee)
  end
end
