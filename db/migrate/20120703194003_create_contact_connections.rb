class CreateContactConnections < ActiveRecord::Migration
  def self.up
    create_table "contact_connections", :force => true, :id => false do |t|
        t.integer :contact_a_id, :null => false
        t.integer :contact_b_id, :null => false
    end
  end
  def self.down
    drop_table "contact_connections"
  end
end
