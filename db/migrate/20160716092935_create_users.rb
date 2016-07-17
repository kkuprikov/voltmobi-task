class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :role
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
