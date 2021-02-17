class AddCompanyImageToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :company_image64, :text
  end
end
