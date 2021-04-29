class RemoveIntroductionFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :introduction, :string
  end
end
