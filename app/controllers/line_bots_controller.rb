# frozen_string_literal: true

# This controller handles line bots-related actions.
# app/controllers/line_bots_controller.rb
class LineBotsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, only: %i[callback]
  skip_before_action :require_login, only: %i[callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
      return
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          handle_message(event)
        end
      when Line::Bot::Event::Postback
        handle_postback(event)
      end
    end

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINEBOT_CHANNEL_SECRET']
      config.channel_token = ENV['LINEBOT_CHANNEL_TOKEN']
    end
  end

  def handle_message(event)
    user_message = event.message['text']
    user_id = event['source']['userId']
    user = User.find_by(line_user_id: user_id)
    user_state = UserState.find_by(user_id: user.id)
    if user_state&.state == 'waiting_for_custom_message'
      custom_message = user_message
      confirm_emotion_custom_message(event['replyToken'], user_id, user_state, custom_message)
    elsif user_message.match?(/記録|感情/)
      ask_feeling(event['replyToken'])
    else
      reply_message(event['replyToken'], '感情を記録するには「記録」または「感情」と入力してください。')
    end
  end

  def ask_feeling(reply_token)
    actions = [
      { type: 'postback', label: '嬉しい', data: 'action=feeling&feeling=happy' },
      { type: 'postback', label: '普通', data: 'action=feeling&feeling=normal' },
      { type: 'postback', label: '辛い', data: 'action=feeling&feeling=tired' }
    ]
    template = {
      type: 'buttons',
      text: '今の感情を選んでください。',
      actions:
    }
    message = {
      type: 'template',
      altText: '感情を選んでください。',
      template:
    }
    client.reply_message(reply_token, message)
  end

  def ask_category(reply_token, user_id, feeling)
    user = User.find_by(line_user_id: user_id)
    return unless user

    user_categories = user.user_categories.includes(:category).limit(4)

    actions = user_categories.map do |user_category|
      { type: 'postback', label: user_category.category.name,
        data: "action=category&category=#{user_category.id}&feeling=#{feeling}" }
    end

    template = {
      type: 'buttons',
      text: 'カテゴリを選んでください。',
      actions:
    }
    message = {
      type: 'template',
      altText: 'カテゴリを選んでください。',
      template:
    }
    Rails.logger.info("Sending category message: #{message.inspect}")
    client.reply_message(reply_token, message)
  end

  def ask_rating(reply_token, feeling, category)
    Rails.logger.info("Asking rating for feeling: #{feeling}, category: #{category}")
    actions = [
      { type: 'postback', label: '最高', data: "action=rating&rating=5&feeling=#{feeling}&category=#{category}" },
      { type: 'postback', label: '普通', data: "action=rating&rating=3&feeling=#{feeling}&category=#{category}" },
      { type: 'postback', label: '最悪', data: "action=rating&rating=1&feeling=#{feeling}&category=#{category}" },
      { type: 'postback', label: 'それ以外(良いor悪い)',
        data: "action=rating&rating=other&feeling=#{feeling}&category=#{category}" }
    ]
    template = {
      type: 'buttons',
      text: '評価を選んでください。',
      actions:
    }
    message = {
      type: 'template',
      altText: '評価を選んでください。',
      template:
    }
    Rails.logger.info("Sending rating message: #{message.inspect}")
    client.reply_message(reply_token, message)
  end

  def ask_additional_rating(reply_token, feeling, category)
    Rails.logger.info("Asking additional rating for feeling: #{feeling}, category: #{category}")
    actions = [
      { type: 'postback', label: '良い', data: "action=rating&rating=4&feeling=#{feeling}&category=#{category}" },
      { type: 'postback', label: '悪い', data: "action=rating&rating=2&feeling=#{feeling}&category=#{category}" }
    ]
    template = {
      type: 'buttons',
      text: '評価を選んでください。',
      actions:
    }
    message = {
      type: 'template',
      altText: '評価を選んでください。',
      template:
    }
    Rails.logger.info("Sending additional rating message: #{message.inspect}")
    client.reply_message(reply_token, message)
  end

  def ask_message(reply_token, user_id, feeling, category, rating)
    user = User.find_by(line_user_id: user_id)
    return unless user

    user_templates = user.user_templates.includes(:message_template).limit(4)

    actions = user_templates.map do |user_template|
      { type: 'postback', label: user_template.message_template.message,
        data: "action=message&message=#{user_template.id}&feeling=#{feeling}&category=#{category}&rating=#{rating}" }
    end

    template = {
      type: 'buttons',
      text: 'メッセージを選んでください。',
      actions:
    }
    message = {
      type: 'template',
      altText: 'メッセージを選んでください。',
      template:
    }
    client.reply_message(reply_token, message)
  end

  def prompt_custom_message(reply_token, _feeling, _category, _rating)
    message = {
      type: 'text',
      text: '自由入力でメッセージを入力してください。'
    }
    client.reply_message(reply_token, message)
  end

  def confirm_emotion(reply_token, feeling, category, rating, message_template_id)
    user_template = UserTemplate.find_by(id: message_template_id)
    return unless user_template

    text = <<~TEXT
      感情: #{feeling}
      カテゴリ: #{UserCategory.find_by(id: category).category.name}
      評価: #{rating}
      メッセージ: #{user_template.message_template.message}
    TEXT

    actions = [
      { type: 'postback', label: '記録する',
        data: "action=save&feeling=#{feeling}&category=#{category}&rating=#{rating}&message=#{message_template_id}" },
      { type: 'postback', label: 'キャンセル', data: 'action=cancel' }
    ]
    template = {
      type: 'confirm',
      text:,
      actions:
    }
    message = {
      type: 'template',
      altText: '感情を記録しますか？',
      template:
    }
    client.reply_message(reply_token, message)
  end

  def confirm_emotion_custom_message(reply_token, _user_id, user_state, custom_message)
    feeling = user_state[:feeling]
    category = user_state[:category]
    rating = user_state[:rating]
    message_template_id = user_state[:message_template]

    text = <<~TEXT
      感情: #{feeling}
      カテゴリ: #{UserCategory.find_by(id: category).category.name}
      評価: #{rating}
      メッセージ: #{custom_message}
    TEXT

    actions = [
      { type: 'postback', label: '記録する',
        data: "action=save&feeling=#{feeling}&category=#{category}&rating=#{rating}&custom_message=#{custom_message}" },
      { type: 'postback', label: 'キャンセル', data: 'action=cancel' }
    ]
    template = {
      type: 'confirm',
      text:,
      actions:
    }
    message = {
      type: 'template',
      altText: '感情を記録しますか？',
      template:
    }
    client.reply_message(reply_token, message)
  end

  def handle_postback(event)
    raw_data = event['postback']['data']
    data = raw_data.split('&').map { |s| s.split('=') }.to_h
    Rails.logger.info("Received raw postback data: #{raw_data}")
    Rails.logger.info("Parsed postback data: #{data}")

    action = data['action']
    if action.nil?
      Rails.logger.error('No action found in postback data.')
      return
    end
    action = data['action']
    feeling = data['feeling']
    category = data['category']
    rating = data['rating']
    message_template = data['message']

    case action
    when 'feeling'
      Rails.logger.info('Handling feeling action')
      ask_category(event['replyToken'], event['source']['userId'], data['feeling'])
    when 'category'
      Rails.logger.info('Handling category action')
      ask_rating(event['replyToken'], data['feeling'], data['category'])
    when 'rating'
      Rails.logger.info('Handling rating action')
      if rating == 'other'
        ask_additional_rating(event['replyToken'], feeling, category)
      else
        ask_message(event['replyToken'], event['source']['userId'], data['feeling'], data['category'], data['rating'])
      end
    when 'message'
      user_template = UserTemplate.find_by(id: message_template)
      user_id = event['source']['userId']
      user = User.find_by(line_user_id: user_id)
      if user_template&.message_template&.message == 'その他'
        Rails.logger.info('Handling custom_message action')
        UserState.find_or_create_by(user_id: user.id).update(
          state: 'waiting_for_custom_message',
          feeling:,
          category:,
          rating:,
          message_template:
        )
        prompt_custom_message(event['replyToken'], feeling, category, rating)
      else
        Rails.logger.info('Handling message action')
        confirm_emotion(event['replyToken'], feeling, category, rating, message_template)
      end
    when 'save'
      Rails.logger.info('Handling save action')
      user_id = event['source']['userId']
      user = User.find_by(line_user_id: user_id)
      user_state = UserState.find_by(user_id: user.id)
      puts user_state
      if user_state&.state == 'waiting_for_custom_message'
        custom_message = data['custom_message']
        handle_custom_message_input(event['replyToken'], user_id, user_state, custom_message)
      else
        save_emotion(event['replyToken'], event['source']['userId'], data['feeling'], data['category'], data['rating'],
                     data['message'])
      end
    when 'cancel'
      Rails.logger.info('Handling cancel action')
      user_id = event['source']['userId']
      user = User.find_by(line_user_id: user_id)
      user_state = UserState.find_by(user_id: user.id)
      user_state.destroy if user_state # 状態をクリア
      reply_message(event['replyToken'], '記録をキャンセルしました。')
    when 'notify'
      emotion_id = data['emotion_id']
      emotion = Emotion.find(emotion_id)
      SendLineMessageJob.perform_later(emotion)
      reply_message(event['replyToken'], 'パートナーに通知しました。')
    when 'not_notify'
      reply_message(event['replyToken'], '通知をキャンセルしました。')
    else
      Rails.logger.error("Unknown action: #{action}")
    end
  end

  def save_emotion(reply_token, user_id, feeling, category, rating, message_template)
    user = User.find_by(line_user_id: user_id) # ユーザーをデータベースから検索
    return unless user

    if user.nil?
      Rails.logger.error "User not found for line_user_id: #{user_id}"
      return
    end

    emotion = user.emotions.build(
      feeling:,
      emotion_categories_attributes: [{ user_category_id: category, rating: }],
      emotion_message_attributes: { user_id: user.id, user_template_id: message_template }
    )
    Rails.logger.error("Validation errors: #{emotion.errors.full_messages.join(', ')}")

    if emotion.save
      partner = EmotionPartner.find_by(user_id: user.id)
      partner_user = User.find_by(id: partner.partner_id)
      if partner_user&.line_user_id
        reply_message(reply_token, '感情が記録されました。通知しますか？', emotion.id)
      else
        reply_message(reply_token, '感情が記録されました。')
      end
    else
      Rails.logger.error("Validation errors: #{emotion.errors.full_messages.join(', ')}")
      reply_message(reply_token, '感情の記録に失敗しました。')
    end
  end

  def handle_custom_message_input(reply_token, user_id, user_state, custom_message)
    user = User.find_by(line_user_id: user_id)
    return unless user

    if user.nil?
      Rails.logger.error "User not found for line_user_id: #{user_id}"
      return
    end
    feeling = user_state[:feeling]
    category = user_state[:category]
    rating = user_state[:rating]
    message_template = user_state[:message_template]

    emotion = user.emotions.build(
      feeling:,
      emotion_categories_attributes: [{ user_category_id: category, rating: }],
      emotion_message_attributes: { user_id: user.id, user_template_id: message_template, message: custom_message }
    )
    Rails.logger.error("Validation errors: #{emotion.errors.full_messages.join(', ')}")

    user_state = UserState.find_by(user_id: user.id)
    user_state.destroy if user_state

    if emotion.save
      partner = EmotionPartner.find_by(user_id: user.id)
      partner_user = User.find_by(id: partner.partner_id)
      if partner_user&.line_user_id
        reply_message(reply_token, '感情が記録されました。通知しますか？', emotion.id)
      else
        reply_message(reply_token, '感情が記録されました。')
      end
    else
      Rails.logger.error("Validation errors: #{emotion.errors.full_messages.join(', ')}")
      reply_message(reply_token, '感情の記録に失敗しました。')
    end
  end

  def reply_message(reply_token, message, emotion_id = nil)
    messages = {
      type: 'text',
      text: message
    }
    if emotion_id
      actions = [
        {
          type: 'postback',
          label: '通知する',
          data: "action=notify&emotion_id=#{emotion_id}"
        },
        {
          type: 'postback',
          label: '通知しない',
          data: 'action=not_notify'
        }
      ]
      template = {
        type: 'confirm',
        text: 'パートナーに通知しますか？',
        actions:
      }
      messages = {
        type: 'template',
        altText: 'パートナーに通知しますか？',
        template:
      }
    end
    client.reply_message(reply_token, messages)
    Rails.logger.info("Sent reply message: #{response.body}")
  end
end
