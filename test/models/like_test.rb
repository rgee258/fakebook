require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
    @like = Like.new(liking_user_id: 1, liked_post_id: 2)
  end
  
  test "successful valid like" do
    assert @like.valid?
  end

  test "invalid like with unknown liking_user_id" do
    @like.liking_user_id = 999999
    assert_not @like.valid?
  end

  test "invalid like with unknown liked_post_id" do
    @like.liked_post_id = 999999
    assert_not @like.valid?
  end

end
