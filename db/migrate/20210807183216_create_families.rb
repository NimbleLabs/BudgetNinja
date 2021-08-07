class CreateFamilies < ActiveRecord::Migration[6.1]
  def change
    create_table :families do |t|
      t.string :name
      t.string :slug, index: true, unique: true

      t.timestamps
    end

    add_column :users, :family_id, :integer, index: true, foreign_key: true
  end
end
