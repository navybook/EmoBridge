class NotificationsController < ApplicationController
  def index
    partner = current_user.emotion_partner&.partner

    if partner.nil?
      @error = 'partnerがいません'
      render json: {
        error: @error,
        notifications: render_to_string(partial: 'notifications/list', locals: { notifications: [] })
      }
    else
      @notifications = partner.notifications.order(created_at: :desc).limit(20)
      # 未読通知を既読に更新する
      @notifications.unread.update_all(status: :read)

      render json: {
        notifications: render_to_string(partial: 'notifications/list', locals: { notifications: @notifications })
      }
    end
  end

  def unread_count
    partner = current_user.emotion_partner&.partner

    if partner.nil?
      render json: { unread_count: 0 }
    else
      unread_count = partner.notifications.unread.count # 未読通知の数
      render json: { unread_count: } # JSONで返す
    end
  end

  def destroy
    notification = Notification.find(params[:id])
    notification.destroy

    # 通知削除後、Turbo Streamを使用して対象の通知を削除する
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(notification) }
    end
  end
end
