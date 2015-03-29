class DropTableBugOccurrences < ActiveRecord::Migration
  def change
    drop_table :bug_occurrences
  end
end
