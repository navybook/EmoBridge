require 'rails_helper'

RSpec.describe 'Notifications', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:partner) { FactoryBot.create(:user) }
  let(:emotion) { FactoryBot.create(:emotion, user: partner) }

  before do
    login_user(user)
    visit new_invitation_path
    fill_in 'invitation[unique_id]', with: partner.unique_id
    click_button '招待を送信する'
    expect(page).to have_content('招待が送信されました。')
    expect(current_path).to eq tops_home_path
    find('div.dropdown', match: :first).click
    click_link 'ログアウト'
    expect(page).to have_content('ログアウトしました')
    login_user(partner)
    visit new_invitation_path
    click_link '承認'
    visit new_emotion_path
    expect(page).to have_css('svg[data-value="happy"]', wait: 5)
    find('svg[data-value="happy"]').click
    select '仕事', from: 'emotion[emotion_categories_attributes][0][user_category_id]'
    find('svg[data-value="5"]').click
    select '良いことがあったから話を聞いて下さい', from: 'emotion[emotion_message_attributes][user_template_id]'
    click_button '記録'
    page.dismiss_confirm 'パートナーへLINEメッセージを送信しますか？'
    expect(page).to have_content('Emotion記録が作成されました。')
    find('div.dropdown', match: :first).click
    click_link 'ログアウト'
    expect(page).to have_content('ログアウトしました')
    login_user(user)
  end

  it 'displays the notification badge with unread notifications' do
    # 未読の通知がある場合バッジが表示されることを確認
    expect(page).to have_css('.badge-primary', visible: true)
  end

  it 'shows the notification when clicking the bell icon' do
    # 通知のベルをクリック
    find('#notification-button').click

    # 通知の内容が表示されることを確認
    within('#notifications-container') do
      expect(page).to have_content("#{partner.name}が記録しました")
    end
  end

  it 'marks notifications as read when opening the list' do
    visit root_path

    # 通知のベルをクリックして通知一覧を表示
    find('#notification-button').click

    # 全ての通知が既読になっているか確認
    Notification.all.each do |notification|
      expect(notification.reload.status).to eq('read')
    end
  end
end
