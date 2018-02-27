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
end
