class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    render partial: 'notifications/list', locals: { notifications: @notifications }
  end

  def show
    @notification = Notification.find(params[:id])
    @notification.update(status: :read) if @notification.status == 'unread'
  end
end