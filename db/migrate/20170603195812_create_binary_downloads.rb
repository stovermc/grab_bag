class CreateBinaryDownloads < ActiveRecord::Migration[5.0]
  def change
    create_table :binary_downloads do |t|
      t.references :binary, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
