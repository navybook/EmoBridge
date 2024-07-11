# frozen_string_literal: true

# This controller handles emotion-related actions.
class EmotionsController < ApplicationController
  def new
    @emotion = Emotion.new
    @emotion.emotion_categories.build
    @emotion.build_emotion_message

    @user_categories = current_user.user_categories.map do |user_category|
      [user_category.category.name, user_category.id]
    end
    @user_message_templates = current_user.user_templates.map do |user_template|
      [user_template.message_template.message, user_template.id]
    end
  end

  def create
    @emotion = current_user.emotions.build(emotion_params)
    if @emotion.save
      SendLineMessageJob.perform_later(@emotion) if params[:send_line_message] == 'true'
      redirect_to tops_home_path, success: 'Emotion記録が作成されました。', status: :see_other
    else
      @user_categories = current_user.user_categories.map do |user_category|
        [user_category.category.name, user_category.category_id]
      end
      @user_message_templates = current_user.user_templates.map do |user_template|
        [user_template.message_template.message, user_template.message_template_id]
      end
      flash.now[:error] = 'Emotion登録が失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @emotions = current_user.emotions.includes(:emotion_categories,
                                               :emotion_message).order(created_at: :desc).page(params[:page])
  end

  def partner_index
    @partner = EmotionPartner.find_by(user_id: current_user.id)
    if @partner
      @partner_emotions = current_user.partner_emotions.includes(:emotion_categories,
                                                                 :emotion_message).order(created_at: :desc).page(params[:page])
    else
      @partner_emotions = []
    end
  end

  def destroy
    @emotion = Emotion.find(params[:id])
    @emotion.destroy
    render turbo_stream: turbo_stream.remove("emotion_#{params[:id]}")
  end

  private

  def emotion_params
    params.require(:emotion).permit(
      :feeling,
      :feeling_score,
      emotion_categories_attributes: %i[id emotion_id user_category_id rating],
      emotion_message_attributes: %i[id emotion_id user_id message user_template_id]
    )
  end
end
