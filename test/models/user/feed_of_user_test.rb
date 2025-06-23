# frozen_string_literal: true

require 'test_helper'

class FeedOfUserTest < ActiveSupport::TestCase
  test 'feed should have the right posts' do
    michael = users(:michael)
    archer = users(:archer)
    lana = users(:lana)

    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end

    michael.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end

    archer.microposts.each do |post_following|
      assert_not michael.feed.include?(post_following)
    end
  end
end
