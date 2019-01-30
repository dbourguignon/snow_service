# frozen_string_literal: true

class SnowService::Base
  def self.call(*params)
    new(*params).call
  end

  def initialize(*params)
    @params = params
  end

  def call
    perform
    freeze
    self
  end

  private

  attr_reader :params

  def perform
    raise 'You must implement perform method'
  end
end
