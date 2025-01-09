class AddAdminToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_column :teachers, :admin, :boolean
  end
end
