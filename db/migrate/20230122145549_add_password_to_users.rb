class AddPasswordToUsers < ActiveRecord::Migration[7.0]
  def change
    # テーブル名, カラム名, データ型
    add_column :users, :password, :string
  end
end
