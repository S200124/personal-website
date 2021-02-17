class RenameColumnTypeInCertifications < ActiveRecord::Migration[6.0]
  def change
    rename_column(:certifications, :type, :level)
  end
end
