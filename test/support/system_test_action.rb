# frozen_string_literal: true

require 'application_system_test_case'

module SystemTestAction
  def login_as(user)
    visit root_url
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end
end
