class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :uuid
      t.references :family, foreign_key: true
      t.string :slug, index: true, unique: true

      t.timestamps
    end

    add_column :users, :invitation_uuid, :string
    add_index :invitations, :uuid
  end
end
