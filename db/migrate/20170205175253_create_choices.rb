class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.references :campaign, foreign_key: true, index: true
      t.string     :name,     null: false

      t.timestamps
    end

    add_index :choices, [:campaign_id, :name], unique: true
  end
end
