class AddPassphraseToUids < ActiveRecord::Migration
  def change
    add_column :uids, :salt, :string
    add_column :uids, :hashed_passphrase, :string
  end
end
