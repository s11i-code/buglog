class CreateBugTypes < ActiveRecord::Migration
  def change
    create_table :bug_types do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.references :creator, index: true

      t.timestamps
    end
  end
end
