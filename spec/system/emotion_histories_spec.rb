require 'rails_helper'

RSpec.describe "EmotionHistories", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:partner) { FactoryBot.create(:user) }

  before do
    login_user(user)
    visit new_invitation_path
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
    FactoryBot.create(:emotion, user: user, feeling: 'happy', feeling_score: 3)
    FactoryBot.create(:emotion, user: partner, feeling: 'tired', feeling_score: 0)
  end

  it 'displays user emotion history' do
    visit emotions_path(partner)
    expect(page).to have_content('tired')
  end

  it 'displays partner emotion history' do
    visit partner_index_emotions_path(partner)
    expect(page).to have_content('happy')
  end
end
