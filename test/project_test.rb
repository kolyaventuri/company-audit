# frozen_string_literal: true

require_relative 'test_helper.rb'

require './lib/project.rb'

class ProjectTest < Minitest::Test
  def setup
    project_id = '123'
    name = 'Widget Maker'
    start_date = '2015-01-01'
    end_date = '2018-01-01'

    @project = Project.new(project_id, name, start_date, end_date)
  end

  def test_exists
    assert_instance_of Project, @project
  end

  def test_attributes
    assert_equal 123, @project.id
    assert_instance_of Integer, @project.id

    assert_equal 'Widget Maker', @project.name
    assert_equal Date.new(2015, 1, 1), @project.start_date
    assert_equal Date.new(2018, 1, 1), @project.end_date
  end
end
