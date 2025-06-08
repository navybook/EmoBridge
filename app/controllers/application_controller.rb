# frozen_string_literal: true

# This class handles the base functionalities for all controllers.
class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :error
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path, warning: 'ログインしてください'
  end
end
