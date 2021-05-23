class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :number
      t.string :exp
      t.string :cvc

      t.timestamps
    end
  end
end
