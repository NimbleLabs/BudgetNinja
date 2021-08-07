class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :uuid
      t.references :family, foreign_key: true

      t.timestamps
    end

    add_column :users, :invitee_uuid, :string
    add_index :invitations, :uuid
  end
end