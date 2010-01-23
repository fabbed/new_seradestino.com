class Story  < ActiveRecord::Base
  # belongs_to :user
  belongs_to :category
  belongs_to :country  
  belongs_to :user 

  belongs_to :location

  acts_as_commentable
  acts_as_taggable
  acts_as_rateable

  validates_presence_of   :body, :message => "Debes escribir una historia"
  validates_presence_of   :title, :message => "Debes poner un titulo"
  
  validates_length_of     :title,              :within => 20..100, :message => "Al menos 20 letras, no mas que 100"    
  validates_uniqueness_of :title,              :message => "Ya existe una historia con este titulo"
  
  validates_length_of     :body,              :within => 99..1000000, :message => "Al menos 100 letras"
  validates_presence_of :category_id, :message => "Elige una categoría"

  validates_format_of       :email,    :with => ::Authentication.email_regex, :message => I18n.t("user.email_format"), :allow_nil => true, :if => :email?

  named_scope :moderated, :conditions => ['on_startpage = ?', true]
  named_scope :tops, :order => ['rated_top desc']
  named_scope :flops, :order => ['rated_flop desc']
  named_scope :newest_first, :order => ['created_at desc']
  named_scope :to_moderate, :conditions => ['on_startpage = ?', true]  

  named_scope :from_country, lambda { |country_id|   { :conditions => { :country_id => country_id } } }
  named_scope :from_category, lambda { |category_id|   { :conditions => { :category_id => category_id } } }
  named_scope :for_administering, :order => "created_at desc"
  named_scope :date_between, lambda { |date_range|   { :conditions => { :created_at => date_range } } }
  named_scope :not_anonymous, :conditions => { :anonymous => false }

  named_scope :part_of_experiment, :conditions =>     { :experiment_story => true }
  named_scope :not_part_of_experiment, :conditions => { :experiment_story => false }  
  
  has_friendly_id :seo_title, :use_slug => true, :strip_diacritics => true
  
  before_validation :generate_seo_title
  before_validation :remove_long_words_in_body
  before_validation :remove_long_words_in_title
  


  
  
  def generate_url
    self.to_param
  end
  
  def country_iso
    return "NA" if !location
    location.country.iso
  end
  
  def self.country_builder(country_code)
    builder = self.scope_builder
    builder.from_country(country_code) if country_code
  end
  
  def remove_long_words_in_body
        indexes = []
        body_as_array = self.body.split(" ")
        long_body = false
        body_as_array.each_with_index do |word, i|
          if word.length > 35
            indexes << i
            long_body = true
          end
        end
        
        if long_body
          indexes.each do |index|
            body_as_array[index] = body_as_array[index][0..20]
          end
        
          self.body = body_as_array.join(" ")
        end
  end

  def remove_long_words_in_title
        indexes = []
        title_as_array = self.title.split(" ")
        long_title = false
        title_as_array.each_with_index do |word, i|
          if word.length > 35
            indexes << i
            long_title = true
          end
        end
        
        if long_title
          indexes.each do |index|
            title_as_array[index] = title_as_array[index][0..20]
          end
        
          self.title = title_as_array.join(" ")
        end
  end



  def tags_seperated
    tag_list.map { |tag|  tag+","}
  end

  def generate_seo_title
    if true #self.title.length > 30
      self.seo_title = self.title
    else
      self.seo_title = self.body[0..(60+ (self.body[60..100].index(" ")))]          
    end
  end

  def browser_title
    self.seo_title
  end


  # def to_param
  #   "#{id}-#{body[0..60].gsub(/[^a-z0-9]+/i, '-')}"
  # end




end
