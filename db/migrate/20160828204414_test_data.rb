#encoding: utf-8
class TestData < ActiveRecord::Migration
  def change
    user = User.new :name => 'Влажная Ватрушка',
                    :email => 'adm@adm.ru',
                    :password => 'adm',
                    :password_confirmation => 'adm',
                    :admin => true
    user.save

    point = Point.new :lng => 30.396,
                      :lat => 59.983,
                      :name => 'Мой кругляк',
                      :description => '24 часа у арки',
                      :user => user
    point.save

    comment = Comment.new :text => 'Внатуре класс!',
                          :user => user,
                          :point => point

    puts comment.inspect
    comment.save

  end
end
