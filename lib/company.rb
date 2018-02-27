# frozen_string_literal: true

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
end