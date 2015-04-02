class RemovePublicFromBugTypes < ActiveRecord::Migration
  def change
    remove_column :bug_types, :public
  end
end
