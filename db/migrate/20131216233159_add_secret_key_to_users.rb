class AddSecretKeyToUsers < ActiveRecord::Migration
  def up
    add_column :uids, :user_id, :integer
    add_column :uids, :secret_key, :string

    all_uids = select_values('SELECT id FROM uids')
    all_uids.each do |uid|
      execute('UPDATE uids SET secret_key = ? WHERE id = ? AND secret_key IS NULL',
              [ROTP::Base32.random_base32, uid])
    end
    execute(<<-SQL)
      UPDATE uids
      SET user_id = (
        SELECT users.id
        FROM users
        JOIN keys ON keys.user_id = users.id
        WHERE keys.id = uids.key_id)
    SQL
  end

  def down
    remove_column :uids, :secret_key
    remove_column :uids, :user_id
  end
end
