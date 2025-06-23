require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test 'should require logged-in user when create relationship' do
    assert_no_difference 'Relationship.count' do
      post relationships_path
    end
    assert_redirected_to login_url
  end

  test 'should require logged-in user when destroy relationship' do
    assert_no_difference 'Relationship.count' do
      delete relationship_path(relationships(:one))
    end
    assert_redirected_to login_url
  end
end
