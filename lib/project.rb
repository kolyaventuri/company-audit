# frozen_string_literal: true

require './modules/date_handler'

# Defines a project
class Project
  include DateHandler

  attr_reader :id,
              :name,
              :start_date,
              :end_date

  def initialize(id, name, start_date, end_date)
    @id = id.to_i
    @name = name
    @start_date = DateHandler.string_to_date start_date
    @end_date = DateHandler.string_to_date end_date
  end

  def valid_date(date)
    d = DateHandler::DHDate.new(date)
    d.date_between(@start_date, @end_date)
  end

  def self.validate(data)
    return false if data.length != 4
    return false if data[0].to_i.to_s != data[0]
    begin
      DateHandler.string_to_date data[2]
      DateHandler.string_to_date data[3]
    rescue ArgumentError
      return false
    end
    true
  end
end
