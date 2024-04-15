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
    user.update(unique_id: SecureRandom.hex(4).upcase) unless user.unique_id.present?
    redirect_to new_invitation_path, success: 'IDを発行しました。'
  end

  def destroy
    invitation = Invitation.find(params[:id])
    invitation.destroy
    redirect_to new_invitation_path, success: "招待を拒否しました", status: :see_other
  end

  private

  def invitation_params
    params.require(:invitation).permit(:unique_id)
  end
end