require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { FactoryBot.create(:user) }

  it 'allows a user to register' do
    visit new_user_path
    fill_in 'user[name]', with: 'Test User'
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'サインアップ'
    expect(page).to have_content('ユーザー登録が完了しました')
    expect(current_path).to eq tops_home_path
  end

  it 'allows a user to log in' do
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_button 'ログイン'
    find('.dropdown').click 
    click_link 'ログアウト'
    expect(page).to have_content('ログアウトしました')
    expect(current_path).to eq root_path
  end
end
