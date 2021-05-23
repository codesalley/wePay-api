class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.integer :ballance
      t.string :wallet_address

      t.timestamps
    end
  end
end
