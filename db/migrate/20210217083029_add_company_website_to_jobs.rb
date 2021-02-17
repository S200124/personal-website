class AddCompanyWebsiteToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :company_website, :string
  end
end
