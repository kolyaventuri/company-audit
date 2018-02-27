# frozen_string_literal: true

require './test/test_helper'
require './modules/date_handler'
require 'date'

class DateHandlerTest < Minitest::Test
  include DateHandler

  def test_instantiation
    date = Date.new(2018, 1, 25) # January 25, 2018
    dh = DateHandler::DHDate.new(date)
    assert_instance_of DateHandler::DHDate, dh
  end

  def test_date_between
    date = Date.new(2018, 1, 25) # January 25, 2018
    start_date = Date.new(2018, 1, 1) # January 1, 2018
    end_date = Date.new(2018, 3, 31) # March 31, 2018

    dh = DateHandler::DHDate.new(date)
    assert dh.date_between(start_date, end_date)
  end

  def test_days_between
    start_date = Date.new(2018, 1, 1) # January 1, 2018
    end_date = Date.new(2018, 3, 31) # March 31, 2018

    assert_equal 89, DateHandler.days_between(start_date, end_date)
  end

  def test_minutes_conversion
    minutes_worked = 234
    expected = { hours: 3, minutes: 54 }
    assert_equal expected, DateHandler.minutes_conversion(minutes_worked)
  end

  def test_string_to_date
    date_string = '2018-01-13'
    date = DateHandler.string_to_date(date_string)

    assert_instance_of Date, date
    assert_equal 2018, date.year
    assert_equal 1, date.month
    assert_equal 13, date.day
  end
end
