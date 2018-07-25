class AddTokenToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :request_token, :string
  end
end
