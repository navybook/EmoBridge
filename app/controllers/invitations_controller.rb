# frozen_string_literal: true

# This controller handles invitation-related actions
class InvitationsController < ApplicationController
  def new
    @user = current_user
    @invitations = Invitation.where(receiver_id: current_user.id)
  end

  def create
    invited_user = User.find_by(unique_id: invitation_params[:unique_id])
    if invited_user
      @invitation = Invitation.new(sender_id: current_user.id, receiver_id: invited_user.id, status: 0)

      if @invitation.save && !EmotionPartner.exists?(partner_id: invited_user.id)
        SendLineMessageJob.perform_later(@invitation)
        redirect_to tops_home_path, success: '招待が送信されました。'
      else
        redirect_to new_invitation_path, error: 'このユーザーには招待を送信できません。'
      end
    else
      redirect_to new_invitation_path, error: '招待を送信できません。ユーザーが見つかりませんでした。'
    end
  end

  def approve
    invitation = Invitation.find(params[:id])
    invitation.update(status: 1)
    EmotionPartner.create(user_id: invitation.sender_id, partner_id: invitation.receiver_id)
    EmotionPartner.create(user_id: invitation.receiver_id, partner_id: invitation.sender_id)
    redirect_to new_invitation_path, success: '招待を承認しました。'
  end

  def generate_unique_id
    user = current_user
    # ユーザーが既にunique_idを持っていない場合のみ更新する
    if user.unique_id.blank?
      # updateメソッドの戻り値がtrueかfalseかで条件分岐
      if user.update(unique_id: SecureRandom.hex(4).upcase)
        redirect_to new_invitation_path, success: 'IDを発行しました。'
      else
        redirect_to new_invitation_path, error: 'IDの更新に失敗しました。ユーザー情報が不足してます'
      end
    else
      redirect_to new_invitation_path, notice: '既にIDが発行されています。'
    end
  end

  def destroy
    invitation = Invitation.find(params[:id])
    invitation.destroy
    redirect_to new_invitation_path, success: '招待を拒否しました', status: :see_other
  end

  private

  def invitation_params
    params.require(:invitation).permit(:unique_id)
  end
end
