class AddUnageToPost < ActiveRecord::Migration
  def change
    add_column :posts, :user, :belong_to
  end
end
