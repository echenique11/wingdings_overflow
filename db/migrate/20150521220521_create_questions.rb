class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body

      t.timestamps
    end
  end
end
