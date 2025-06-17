# frozen_string_literal: true

require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:michael)
    remember_user @user
  end

  test 'current returns right when sessions is nil' do
    assert_equal @user, current_user
    # assert is_logged_in?
  end
end
