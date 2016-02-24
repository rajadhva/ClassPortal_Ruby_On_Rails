class RemoveUrlFromReferences < ActiveRecord::Migration
  def change
    remove_column :references, :url, :string
  end
end
