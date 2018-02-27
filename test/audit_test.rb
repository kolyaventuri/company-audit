# frozen_string_literal: true

require_relative 'test_helper.rb'

require './lib/audit.rb'
require './lib/company.rb'

class AuditTest < Minitest::Test
  def setup
    @audit = Audit.new
    @company = Company.new
  end

  def test_it_exists
    assert_instance_of Audit, @audit
  end
end