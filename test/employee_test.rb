# frozen_string_literal: true

require './test/test_helper'
require './lib/employee'

class EmployeeTest < Minitest::Test
  def setup
    employee_id = '5'
    name = 'Sally Jackson'
    role = 'Engineer'
    start_date = '2015-01-01'
    end_date = '2018-01-01'

    @employee = Employee.new(employee_id, name, role, start_date, end_date)
  end

  def test_instantiation
    assert_instance_of Employee, @employee
  end

  def test_attributes
    assert_equal 5, @employee.id
    assert_instance_of Integer, @employee.id

    assert_equal 'Sally Jackson', @employee.name
    assert_equal 'Engineer', @employee.role

    assert_equal Date.new(2015, 1, 1), @employee.start_date
    assert_equal Date.new(2018, 1, 1), @employee.end_date
  end

  def test_can_validate_data
    good = Employee.validate(['1', 'A', 'B', '2012-01-1', '2013-01-01'])
    assert good

    bad = Employee.validate(['1', 'A-', 'B'])
    refute bad

    bad = Employee.validate(['fire', 'A', 'B', '2012-01-1', '2013-01-01'])
    refute bad
  end
end
