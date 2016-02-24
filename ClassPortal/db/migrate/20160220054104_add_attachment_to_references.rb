class AddAttachmentToReferences < ActiveRecord::Migration
  def change
    add_column :references, :attachment, :string
  end
end
