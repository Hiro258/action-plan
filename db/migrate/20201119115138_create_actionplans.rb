class CreateActionplans < ActiveRecord::Migration[5.2]
  def change
    create_table :actionplans do |t|
      t.string :action
      t.string :studyl
      t.string :infosource
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
