# frozen_string_literal: true

# This class handles emotion partners related actions.
class EmotionPartnersController < ApplicationController
  def destroy
    emotion_partner = current_user.emotion_partner
    reciprocal_emotion_partner = EmotionPartner.find_by(user_id: emotion_partner.partner_id,
                                                        partner_id: current_user.id)

    ActiveRecord::Base.transaction do
      emotion_partner.destroy
      reciprocal_emotion_partner&.destroy
    end

    redirect_to new_invitation_path, success: 'パートナーを解除しました', status: :see_other
  rescue StandardError => e
    redirect_to emotion_partner_path(current_user), alert: 'パートナー情報の解除に失敗しました。'
  end
end
