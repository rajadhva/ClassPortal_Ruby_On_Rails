class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :description
      t.attachment :string
      t.references :course

      t.timestamps null: false

    end
  end
end
