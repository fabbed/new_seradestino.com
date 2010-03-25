class VisitorSession < ActiveRecord::Base
  belongs_to :user
  belongs_to :visitor
  
  serialize   :stories
  serialize   :comments
  serialize   :ratings
  serialize   :recommendations
  serialize   :stories_read
  serialize   :stories_order
  serialize   :avatars_order
  serialize   :avatars_clicked
  
end
