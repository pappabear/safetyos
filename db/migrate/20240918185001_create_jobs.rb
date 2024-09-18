class CreateJobs < ActiveRecord::Migration[7.2]
  def change
    create_table :jobs do |t|
      t.bigint :account_id
      t.string :name
      t.bigint :sequence
      t.text :description
      t.text :notes

      t.timestamps
    end
  end
end
