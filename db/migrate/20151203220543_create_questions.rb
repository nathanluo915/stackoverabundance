class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string  :content, null: false
      t.references :user, null: false
      t.references :answer, null: false

      t.timestamps null: false
    end
  end
end
