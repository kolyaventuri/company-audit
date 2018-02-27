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
end
