# frozen_string_literal: true

# This controller handles top-related actions
class TopsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index; end

  def home; end
end
