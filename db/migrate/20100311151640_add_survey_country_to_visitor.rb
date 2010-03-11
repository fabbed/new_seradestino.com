class AddSurveyCountryToVisitor < ActiveRecord::Migration
  def self.up
    add_column :visitors, :survey_country, :string
    add_column :visitors, :survey_nationality_of_page, :string
    add_column :visitors, :survey_gender, :string    
  end

  def self.down
    remove_column :visitors, :survey_country
    remove_column :visitors, :survey_nationality_of_page
    remove_column :visitors, :survey_gender
  end
end
