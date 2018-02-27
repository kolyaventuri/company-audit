# frozen_string_literal: true

# Defines a project
class Project
  attr_reader :id,
              :name,
              :start_date,
              :end_date

  def initialize(id, name, start_date, end_date)
    @id = id.to_i
    @name = name
    @start_date = Date.parse start_date
    @end_date = Date.parse end_date
  end

  def self.validate(data)
    return false if data.length != 4
    return false if data[0].to_i.to_s != data[0]
    begin
      Date.parse(data[2])
      Date.parse(data[3])
    rescue ArgumentError
      return false
    end
    true
  end
end
