class CreateUserTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string  :name
      t.string  :email
      t.string  :password
      t.string  :employee_id
      t.string  :mobile_no
    end
  end

  def down
  end
end
