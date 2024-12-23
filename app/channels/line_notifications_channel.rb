class LineNotificationsChannel < ApplicationCable::Channel
  # このメソッドはクライアントがチャンネルに接続したときに呼ばれる
  def subscribed
    stream_from 'line_notifications_channel'
  end

  # このメソッドはクライアントがチャンネルから切断されたときに呼ばれる
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
