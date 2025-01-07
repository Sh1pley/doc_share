class AddTypeToDocuments < ActiveRecord::Migration[8.0]
  def change
    add_column :documents, :type, :string
  end
end
