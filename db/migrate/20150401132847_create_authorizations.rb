class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.references :user, index: true, null: false
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :username

      t.timestamps null: false
    end
    add_foreign_key :authorizations, :users
  end
end
