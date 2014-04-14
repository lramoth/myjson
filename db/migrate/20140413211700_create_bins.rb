class CreateBins < ActiveRecord::Migration
  def change
    create_table :bins do |t|
      t.json :data

      t.timestamps
    end
  end
end
