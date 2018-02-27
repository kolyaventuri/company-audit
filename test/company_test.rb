# frozen_string_literal: true

require_relative 'test_helper.rb'

require './lib/company.rb'

class CompanyTest < Minitest::Test
  def setup
    @company = Company.new
  end

  def test_does_create_company
    assert_instance_of Company, @company
  end

  def test_attributes
    assert_equal [], @company.employees
    assert_equal [], @company.projects
    assert_equal [], @company.timesheetss
  end
end
