# frozen_string_literal: true

require 'csv'

require_relative 'employee'
require_relative 'project'

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
        @employees = []
        return { success: false, error: 'bad data' }
      end

      add_employee(employee_info)
    end

    { success: true, error: nil }
  end

  def load_projects(filename)
    CSV.foreach(
      filename
    ) do |project_info|
      unless Project.validate(project_info)
        @projects = []
        return { success: false, error: 'bad data' }
      end

      add_project(project_info)
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

  def add_project(project_info)
    project = Project.new(
      project_info[0],
      project_info[1],
      project_info[2],
      project_info[3]
    )

    @projects.push(project)
  end
end
