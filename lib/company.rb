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
      employee = Employee.new(
        employee_info[0],
        employee_info[1],
        employee_info[2],
        employee_info[3],
        employee_info[4]
      )

      @employees.push(employee)
    end

    { success: true, error: nil}
  end
end