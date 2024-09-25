class AddFieldsToSteps < ActiveRecord::Migration[7.2]
  def change
    add_column :steps, :description, :text
    add_column :steps, :url_to_action, :string
    add_column :steps, :status, :string
  end
end
