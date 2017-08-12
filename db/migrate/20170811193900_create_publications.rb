class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications, id: :uuid do |t|
      t.text :title, null: false
      t.text :description, null: false
      t.float :amount, null: false, default: 0
      t.string :currency, null: false, default: 'btc'
      t.boolean :active, null: false, default: true

      t.references :user, null: false, type: :uuid, index: true, foreign_key: true
      t.timestamps
    end

    add_index :publications, :active
  end
end
