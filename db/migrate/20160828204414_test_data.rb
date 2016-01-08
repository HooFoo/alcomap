#encoding: utf-8
class TestData < ActiveRecord::Migration
  def change
    user = User.new :name => 'Test User',
                    :email => 'test@test.com',
                    :password => 'test',
                    :password_confirmation => 'test',
                    :admin => true
    user.save

    point = Point.new :lng => 30.396,
                      :lat => 59.983,
                      :name => 'Test shop',
                      :description => 'maybe here',
                      :user => user
    point.save

    comment = Comment.new :text => 'Test comment!',
                          :user => user,
                          :point => point

    puts comment.inspect
    comment.save

  end
end
