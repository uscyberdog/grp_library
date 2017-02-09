class DropTableInfos < ActiveRecord::Migration[5.0]
  def change
  	drop_table :infos
  end
end
