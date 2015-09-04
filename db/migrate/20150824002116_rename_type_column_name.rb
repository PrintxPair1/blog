class RenameTypeColumnName < ActiveRecord::Migration
  def change
    rename_column :images, :type, :mime_type
  end
end
