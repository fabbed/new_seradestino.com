class AddSurveyTypeToVisitor < ActiveRecord::Migration
  def self.up
    add_column :visitors, :survey_identifier, :string
  end

  def self.down
    remove_column :visitors, :survey_identifier
  end
end
