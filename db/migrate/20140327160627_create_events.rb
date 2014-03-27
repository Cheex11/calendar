class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.column :description, :string
      t.column :location, :string
      t.column :start_date, :date
      t.column :end_date, :date
      t.column :start_time, :time
      t.column :end_time, :time
    end
  end
end
