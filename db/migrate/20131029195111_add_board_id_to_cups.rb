class AddBoardIdToCups < ActiveRecord::Migration
  def change
    add_column :cups, :board_id, :integer
  end
end
