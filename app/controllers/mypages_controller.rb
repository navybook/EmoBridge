# frozen_string_literal: true

# This controller handles mypages-related actions
class MypagesController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
    @user_categories = current_user.user_categories.map do |user_category|
      [user_category.category.name, user_category.category_id]
    end
    @user_message_templates = current_user.user_templates.map do |user_template|
      [user_template.message_template.message, user_template.message_template_id]
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, success: 'ユーザーを更新しました', status: :see_other
    else
      flash.now[:error] = 'ユーザーを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cash)
  end
end
