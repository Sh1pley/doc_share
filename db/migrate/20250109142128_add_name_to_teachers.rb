class AddNameToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_column :teachers, :first_name, :string
    add_column :teachers, :last_name, :string
  end
end
