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
    assert_equal [], @company.timesheets
  end

  def test_can_load_employees
    expected = @company.load_employees './data/employees.csv'
    assert_instance_of Hash, expected

    assert_equal true, expected[:success]
    assert_nil expected[:error]

    assert_equal 2, @company.employees.length
  end

  def test_does_reject_bad_employees
    expected = @company.load_employees './data/bad_employees.csv'
    assert_instance_of Hash, expected

    assert_equal false, expected[:success]
    assert_equal 'bad data', expected[:error]

    assert_equal 0, @company.employees.length
  end

  def test_can_load_projects
    expected = @company.load_projects './data/projects.csv'
    assert_instance_of Hash, expected

    assert_equal true, expected[:success]
    assert_nil expected[:error]

    assert_equal 2, @company.projects.length
  end

  def test_does_reject_bad_employees
    expected = @company.load_projects './data/bad_projects.csv'
    assert_instance_of Hash, expected

    assert_equal false, expected[:success]
    assert_equal 'bad data', expected[:error]

    assert_equal 0, @company.projects.length
  end
end
