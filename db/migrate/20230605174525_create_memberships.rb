class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, foreign_key: true
      t.boolean :accepted, null: false, default: false
      t.integer :group_reference, null: false

      t.timestamps
    end
  end
end
