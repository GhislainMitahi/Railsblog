class CreateUsersModels < ActiveRecord::Migration[7.0]
  def change
    create_table :users_models do |t|

      t.timestamps
    end
  end
end
