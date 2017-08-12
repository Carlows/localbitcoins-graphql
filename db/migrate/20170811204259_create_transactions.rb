class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :type, null: false
      t.string :currency, null: false
      t.float :amount, null: false, default: 0

      t.references :user, null: false, type: :uuid, index: true, foreign_key: true
      t.timestamps
    end
  end
end
