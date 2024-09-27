class CreateGuides < ActiveRecord::Migration[7.2]
  def change
    create_table :guides do |t|
      t.bigint :account_id
      t.bigint :step_id
      t.string :name

      t.timestamps
    end
  end
end
