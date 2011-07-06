class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :bills
  end
end
