class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :error
  before_action :require_login

  private
  def not_authenticated #ログインしていなかったらページにリダイレクト,フラッシュメッセージを表示
    redirect_to login_path, warning: 'ログインしてください'
  end
end
