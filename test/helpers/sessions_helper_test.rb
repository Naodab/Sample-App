# frozen_string_literal: true

require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:michael)
    remember_user @user
  end

  test 'should login via remember token cookie' do
    assert_equal @user, current_user
  end
end
