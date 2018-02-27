# frozen_string_literal: true

require_relative 'test_helper.rb'

require './lib/audit.rb'
require './lib/company.rb'

class AuditTest < Minitest::Test
  def setup
    @audit = Audit.new
    @company = Company.new

    @company.load_employees('./data/employees.csv')
    @company.load_projects('./data/projects.csv')
    @company.load_timesheets('./data/timesheets.csv')
  end

  def test_it_exists
    assert_instance_of Audit, @audit
  end

  def test_can_load_company
    expected = @audit.load_company(@company)

    assert_instance_of Company, expected
  end

  def test_invalid_days
    expected = File.read './test/expected_data/invalid_days.txt'
    @audit.load_company(@company)

    out = @audit.were_invalid_days_worked
    assert_equal expected, out

    expected = "Invalid Days Worked:\nNone"
    audit = Audit.new
    company = Company.new
    company.load_timesheets './data/bad_timesheets.csv'
    audit.load_company company

    assert_equal expected, audit.were_invalid_days_worked
  end
end
