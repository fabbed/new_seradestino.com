class Rating < ActiveRecord::Base
  belongs_to :rateable, :polymorphic => true
  has_many :user_ratings

  delegate :max_rating, :to => :rateable

  def rate(score, user_id)
    if user_id.is_a?(Integer)
      user_ratings.find_or_initialize_by_user_id(user_id).update_attributes!(:score => score, :anonymous => false)
    elsif user_id == "anonymous"
      puts "in else now - anonymous"
      user_ratings.create(:score => score, :anonymous => true, :user_id => 0)
      self.update_rating
    else
      puts "cookie is there"
      user_ratings.find_or_initialize_by_vcode(user_id).update_attributes!(:score => score, :anonymous => true)
    end
    reload
  end

  # Call this method the update the avarage rating; you don't normally need to
  # do this manually, saving or updating a user rating already takes care of
  # updating the avarage rating.
  def update_rating
    self.average_rating = user_ratings.average(:score)
    self.ratings_count = user_ratings.count
    save!
  end

end
