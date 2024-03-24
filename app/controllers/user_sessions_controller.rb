class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  
  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path, success: "ログインしました", status: :see_other
    else
      flash.now[:error] = "ログインに失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, success: "ログアウトしました", status: :see_other
  end
end
