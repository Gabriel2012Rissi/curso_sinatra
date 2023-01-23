class CreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :password_digest
      t.string :token

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
