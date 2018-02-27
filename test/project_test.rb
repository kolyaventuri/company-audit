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

  def test_can_validate_data
    good = Project.validate(['1', 'B', '2012-01-1', '2013-01-01'])
    assert good

    bad = Project.validate(['1', '12-0'])
    refute bad

    bad = Project.validate(['fire', 'B', '2012-01-1', '2013-01-01'])
    refute bad
  end
end
