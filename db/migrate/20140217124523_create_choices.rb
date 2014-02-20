class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :name, :null => false
      t.belongs_to :question, :null => false
      t.timestamps
    end
  end
end
