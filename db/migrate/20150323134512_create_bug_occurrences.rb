class CreateBugOccurrences < ActiveRecord::Migration
  def change
    create_table :bug_occurrences do |t|
      t.references :user, index: true, null: false
      t.references :bug_type, index: true, null: false

      t.timestamps
    end
  end
end
