class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :family, null: false, foreign_key: true
      t.string :slug, index: true, unique: true

      t.timestamps
    end
  end
end
