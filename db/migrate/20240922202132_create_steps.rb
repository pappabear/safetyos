class CreateSteps < ActiveRecord::Migration[7.2]
  def change
    create_table :steps do |t|
      t.bigint :account_id
      t.bigint :job_id
      t.string :name
      t.bigint :sequence
      t.text :notes

      t.timestamps
    end
  end
end
