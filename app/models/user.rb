require 'digest/sha1'

class User  < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_many :stories
  has_many :comments
  has_many :user_ratings
  belongs_to :location

  validates_presence_of     :login,    :message => I18n.t("user.login_required")
  validates_length_of       :login,    :within => 4..40, :message => I18n.t("user.login_length")
  validates_uniqueness_of   :login, :message => I18n.t("user.login_exists")
  validates_format_of       :login,    :with => Authentication.login_regex, :message => I18n.t("user.login_format") 

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email, :message => I18n.t("user.email_required")
  validates_length_of       :email,    :within => 6..100, :message => I18n.t("user.email_length")
  validates_uniqueness_of   :email, :message => I18n.t("user.email_exists")
  validates_format_of       :email,    :with => Authentication.email_regex, :message => I18n.t("user.email_format")

  validates_presence_of     :birthdate,   :message => I18n.t("user.birthdate_required")
  # validates_presence_of     :gender,   :message => I18n.t("user.gender_required")
  
  validates_inclusion_of :gender, :in => %w(m f),   :message => I18n.t("user.gender_required")
  



  
  before_create :make_activation_code 

  has_attached_file :avatar, :styles => { :large => "126x126", :medium => "65x65#", :small => "34x34#" }, :default_url => "/avatars/:style/missing.png"


  named_scope :active, { :conditions => { :state => :active } }
  named_scope :newest_first, { :order => "activated_at asc" }

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :avatar, :gender, :birthdate


  def self.get_new_users
    find(:all, :limit => 6)
  end

  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end
  
  def assign_content

    if self.vcode
      UserRating.find(:all, :conditions => ['vcode = ?', self.vcode]).each do |user_rating|
        user_rating.user_id = self.id
        puts "rating"
        user_rating.save
      end
    
      Visitor.find_by_vcode(self.vcode).visitor_sessions.each do |session|
        session.stories.each do |story_id|
          story = Story.find(story_id)
          story.user_id = self.id
          puts "story: #{story.id}"
          story.save!
        end
        session.comments.each do |comment_id|
          comment = Comment.find(comment_id)
          comment.user_id = self.id
          puts "comment"
          comment.save
        end
      end
    
    end
    return true
  end

  def top_rated_stories
    top_rated_stories = user_ratings.find(:all, :conditions => ['score = ?', 5]).inject([]) { |stories, user_rating| stories << Story.find(user_rating.rating.rateable_id) }
  end

  def flop_rated_stories
    top_rated_stories = user_ratings.find(:all, :conditions => ['score = ?', 1]).inject([]) { |stories, user_rating| stories << Story.find(user_rating.rating.rateable_id) }
  end

  def commented_stories
    commented_stories = comments.map {|comment| Story.find(comment.commentable_id)}
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find :first, :conditions => ['email = ?', email] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected
    
    def make_activation_code
        self.activation_code = self.class.make_token
    end


end
