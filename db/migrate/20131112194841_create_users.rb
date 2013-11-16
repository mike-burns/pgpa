class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
    end

    create_table :keys do |t|
      t.timestamps
      t.belongs_to :user
      t.string :keyid
      t.text :raw
    end

    create_table :uids do |t|
      t.timestamps
      t.belongs_to :key
      t.string :email
      t.string :name
      t.string :secret
      t.boolean :revoked, null: false, default: false
      t.boolean :checked, null: false, default: false
    end
  end
end
