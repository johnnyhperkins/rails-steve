class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :start_ts
      t.datetime :finish_ts

      t.timestamps

    end

    add_index :enrollments, [:course_id, :user_id], unique: true

  end
end
