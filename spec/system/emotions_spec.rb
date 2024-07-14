require 'rails_helper'

RSpec.describe "Emotions", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_user(user)
    visit new_emotion_path
  end

  it 'records a new emotion' do
    expect(page).to have_css('svg[data-value="happy"]', wait: 5)
    find('svg[data-value="happy"]').click
    select '仕事', from: 'emotion[emotion_categories_attributes][0][user_category_id]'
    find('svg[data-value="5"]').click
    select '良いことがあったから話を聞いて下さい', from: 'emotion[emotion_message_attributes][user_template_id]'
    click_button '記録'
    page.dismiss_confirm 'パートナーへLINEメッセージを送信しますか？'
    expect(page).to have_content('Emotion記録が作成されました。')
    expect(current_path).to eq tops_home_path
  end

  it 'records a new emotion without a message' do
    expect(page).to have_css('svg[data-value="tired"]', wait: 5)
    find('svg[data-value="tired"]').click
    select '趣味', from: 'emotion[emotion_categories_attributes][0][user_category_id]'
    find('svg[data-value="4"]').click
    select 'その他', from: 'emotion[emotion_message_attributes][user_template_id]'
    fill_in 'emotion[emotion_message_attributes][message]', with: '今日は素晴らしい日でした。'
    click_button '記録'
    page.dismiss_confirm 'パートナーへLINEメッセージを送信しますか？'
    expect(page).to have_content('Emotion記録が作成されました。')
    expect(current_path).to eq tops_home_path
  end
end
