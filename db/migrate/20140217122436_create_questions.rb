class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name, :null => false
      t.datetime :time_to_expire, :null => false
      t.decimal :score, :null => false
      t.belongs_to :choice
      t.timestamps
    end
  end
end
