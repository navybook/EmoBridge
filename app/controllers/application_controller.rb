# frozen_string_literal: true

# This class handles the base functionalities for all controllers.
class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :error
  before_action :require_login
  before_action :check_service_end

  private

  def not_authenticated
    redirect_to login_path, warning: 'ログインしてください'
  end

  def check_service_end
    return unless Date.today > Date.new(2025, 9, 30)
    return if controller_name == "tops"

    redirect_to root_path, alert: 'サービスは終了しました'
  end
end
