class OauthsController < ApplicationController
  skip_before_action :require_login, only: [:oauth, :callback]

  def oauth
    provider = auth_params[:provider]
    login_at(provider)
  end

  def callback
    provider = auth_params[:provider]
    if (@user = login_from(provider))
      redirect_to tops_home_path, success: "#{provider.titleize}でログインしました"
    else
      begin
        @user = create_from(provider)
        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to tops_home_path, notice: "#{provider.titleize}でログインしました"
      rescue
        redirect_to root_path, alert: "#{provider.titleize}でログインできませんでした"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state, :friendship_status_changed)
  end
end
