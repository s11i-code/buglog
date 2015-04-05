class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :bug_type, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :votes, :bug_types
  end
end
