# frozen_string_literal: true

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  def valid_user_params
    {
      name: 'Example User',
      email: 'user@example.com',
      password: 'zzzz111',
      password_confirmation: 'zzzz111'
    }
  end

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {
        name: '',
        email: 'user@invalid',
        password: 'foo',
        password_confirmation: 'bar'
      } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test 'should signup with valid information creates a user and sends activation email' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: valid_user_params }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
  end

  test 'user should not be activated immediately after signup' do
    post users_path, params: { user: valid_user_params }
    user = assigns(:user)
    assert_not user.activated?
  end

  test 'should not log in before account activation' do
    post users_path, params: { user: valid_user_params }
    user = assigns(:user)
    log_in_as(user)
    assert_not logged_in?
  end

  test 'should activate fails with invalid token' do
    post users_path, params: { user: valid_user_params }
    user = assigns(:user)
    get edit_account_activation_path('invalid token', email: user.email)
    assert_not logged_in?
  end

  test 'should activate fails with wrong email' do
    post users_path, params: { user: valid_user_params }
    user = assigns(:user)
    get edit_account_activation_path(user.activation_token, email: 'wrong@example.com')
    assert_not logged_in?
  end

  test 'should activate succeeds with correct token and email' do
    post users_path, params: { user: valid_user_params }
    user = assigns(:user)
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert logged_in?
  end

  test 'should not allow admin attribute to be set via signup' do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {
        name: 'example',
        email: 'example@example.com',
        password: 'zzz111',
        password_confirmation: 'zzz111',
        admin: true
      } }
    end
    user = User.find_by(email: 'example@example.com')
    assert_not user.admin?
  end
end
