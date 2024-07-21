# frozen_string_literal: true

# This controller handles like-related actions.
class LikesController < ApplicationController
  before_action :set_emotion

  def create
    @emotion.likes.create(sender: current_user, receiver: @emotion.user)
    redirect_to partner_index_emotions_path
  end

  def destroy
    @emotion.likes.find_by(sender: current_user, receiver: @emotion.user)&.destroy
    redirect_to partner_index_emotions_path
  end

  private

  def set_emotion
    @emotion = Emotion.find(params[:emotion_id])
  end
end
