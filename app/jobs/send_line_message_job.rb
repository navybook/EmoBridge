require 'line/bot'

class SendLineMessageJob < ApplicationJob
  queue_as :default

  def perform(argument)
    # 引数が Emotion オブジェクトの場合は、感情の通知を送信する
    if argument.is_a?(Emotion)
      send_emotion_notification(argument)
    # 引数が Invitation オブジェクトの場合は、招待の通知を送信する
    elsif argument.is_a?(Invitation)
      send_invitation_notification(argument)
    # 引数の型が未知の場合は、エラーログを出力する
    else
      Rails.logger.error("Unknown argument type: #{argument.class}")
    end
  end

  private

  def line_client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINEBOT_CHANNEL_SECRET']
      config.channel_token = ENV['LINEBOT_CHANNEL_TOKEN']
    }
  end

  def send_emotion_notification(emotion)
    # パートナーのIDを取得する処理を安全に行う
    if emotion.user.emotion_partner.present?
      partner_id = emotion.user.emotion_partner.partner_id

      # パートナーのUserオブジェクトを安全に取得する
      partner = User.find_by(id: partner_id)

      if partner && partner.line_user_id.present?
        category_name = emotion.emotion_categories.includes(:category).map { |ec| ec.category&.name }.compact.join(', ')
        message_template = emotion.emotion_message.message_template&.message
        message = if message_template == 'その他'
                    # メッセージを作成する
                    {
                      type: 'text',
                      text: "感情記録が追加されました。\n感情: #{emotion.feeling}\nカテゴリー: #{category_name}\nメッセージ: #{emotion.emotion_message.message}"
                    }
                  else
                    # メッセージを作成する
                    {
                      type: 'text',
                      text: "感情記録が追加されました。\n感情: #{emotion.feeling}\nカテゴリー: #{category_name}\nメッセージ: #{message_template}"
                    }
                  end

        # パートナーのline_user_idを使用してメッセージを送信する
        response = line_client.push_message(partner.line_user_id, message)

        # レスポンスコードを確認して、成功かどうかログに記録する
        if response&.code == "200"
          Rails.logger.info("Message sent to LINE successfully.")
        else
          Rails.logger.error("Failed to send message to LINE: #{response&.body}")
        end
      else
        Rails.logger.error("Partner's LINE ID is not available or Partner not found.")
      end
    else
      Rails.logger.error("No emotion partner associated with this user.")
    end
  end

  def send_invitation_notification(invitation)
    sender = User.find(invitation.sender_id)
    receiver = User.find(invitation.receiver_id)

    if receiver.line_user_id.present?
      message = {
        type: 'text',
        text: "#{sender.name}さんから招待が届いています。\nEmotionを共有する場合は、招待を承認してください。"
      }

      response = line_client.push_message(receiver.line_user_id, message)

      if response&.code == "200"
        Rails.logger.info("Message sent to LINE successfully.")
      else
        Rails.logger.error("Failed to send message to LINE: #{response&.body}")
      end
    else
      Rails.logger.error("Receiver's LINE ID is not available.")
    end
  end
end
