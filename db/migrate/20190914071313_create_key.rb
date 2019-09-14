class CreateKey < ActiveRecord::Migration[6.0]
  def change
  	create_table :keys do |t|
      t.string :name	
      t.timestamps
    end
  end
end
