require 'rails_helper'

RSpec.describe "PartnerInvitations", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:partner) { FactoryBot.create(:user) }

  before do
    login_user(user)
    visit new_invitation_path
  end

  it 'sends an invitation to a partner' do
    fill_in 'invitation[unique_id]', with: partner.unique_id
    click_button '招待を送信する'
    expect(page).to have_content('招待が送信されました。')
    expect(current_path).to eq tops_home_path
    find('.dropdown').click 
    click_link 'ログアウト'
    expect(page).to have_content('ログアウトしました')
    login_user(partner)
    visit new_invitation_path
    click_link '承認'
    expect(page).to have_content('招待を承認しました。')
    expect(current_path).to eq new_invitation_path
    click_link '解除'
    page.accept_alert '本当に解除しますか？'
    expect(page).to have_content('パートナーを解除しました')
    expect(current_path).to eq new_invitation_path
  end
end
