class AddUserToStory < ActiveRecord::Migration[7.0]
  def change
    add_reference :stories, :user, null: true, foreign_key: true
    fix_data
    change_column_null :stories, :user_id, false
  end

  def fix_data
    user = User.last || User.create(username: 'default_user', password: SecureRandom.hex(10))
    Story.where(user_id: nil).update_all(user_id: user.id)
  end
end
