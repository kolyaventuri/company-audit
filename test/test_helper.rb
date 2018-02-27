# frozen_string_literal: true

require 'simplecov'

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require 'pry'
SimpleCov.start do
  add_filter '/test/'
end
