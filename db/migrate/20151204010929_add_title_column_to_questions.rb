class AddTitleColumnToQuestions < ActiveRecord::Migration
  def change
    change_table :questions do |t|
      t.string :title, null:false
    end
  end
end
