class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
      create_table :task, id: :integer do |t|
      t.string :content

      t.timestamps
     end
  end
end

