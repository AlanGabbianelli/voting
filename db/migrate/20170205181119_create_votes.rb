class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :choice, foreign_key: true, index: true
      t.datetime :time
      t.string :validity
      t.boolean :valid_vote

      t.timestamps
    end
  end
end
