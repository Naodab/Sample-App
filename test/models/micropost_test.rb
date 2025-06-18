require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "invalid when user id is nil" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "invalid content edge cases" do
    invalid_contents = [
      "           ",
      "a" * 141
    ]
    invalid_contents.each do |content|
      @micropost.content = content
      assert_not @micropost.valid?
    end
  end

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
