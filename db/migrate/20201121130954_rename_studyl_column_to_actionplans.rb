class RenameStudylColumnToActionplans < ActiveRecord::Migration[5.2]
  def change
    rename_column :actionplans, :studyl, :study
  end
end
