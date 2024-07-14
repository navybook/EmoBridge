require 'rails_helper'

RSpec.describe "MyPages", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_user(user)
    visit mypage_path
  end

  it 'add and saves emotion categories' do
    fill_in 'category[name]', with: 'テストカテゴリー'
    find('form#category-form input[type="submit"][value="作成"]').click
    expect(page).to have_content('登録が完了しました')
  end

  it 'add and saves message templates' do
    fill_in 'message_template[message]', with: 'テストテンプレート'
    find('form#message_template-form input[type="submit"][value="作成"]').click
    expect(page).to have_content('登録が完了しました')
  end

  it 'edits user information' do
    visit edit_mypage_path
    fill_in 'user[name]', with: 'UpdateUser'
    fill_in 'user[email]', with: 'newemail@example.com'
    fill_in 'user[password]', with: 'newpassword'
    fill_in 'user[password_confirmation]', with: 'newpassword'
    click_button '更新'
    expect(page).to have_content('ユーザーを更新しました')
    expect(user.reload.name).to eq('UpdateUser')
  end
end
