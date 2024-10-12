class CreateTodos < ActiveRecord::Migration[7.2]
  def change
    create_table :todos do |t|
      t.bigint :account_id
      t.bigint :step_id
      t.string :name
      t.bigint :sequence
      t.bigint :todo_status_id
      t.text :description
      t.text :notes

      t.timestamps
    end
  end
end
