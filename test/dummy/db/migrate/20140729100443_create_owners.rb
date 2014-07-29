class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name
      t.integer :max_total_file_size

      t.timestamps
    end
  end
end
