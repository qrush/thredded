class Post  < ActiveRecord::Base

  Filters = []

  require "gravtastic"
  # require "bbcode_filter"
  # require "textile_filter"

  include Gravtastic
  # include BbcodeFilter
  # include TextileFilter

  gravtastic :user_email
  
  # field :notified, :type => Array, :default => []

  belongs_to :topic,  :counter_cache => true
  belongs_to :user,   :counter_cache => true
  has_many   :images

  validates_presence_of :content
  
  attr_accessible :content, :user, :ip, :filter #, :images_attributes

  before_create :set_user_email
  after_create  :modify_parent_topic

  # misc
  # accepts_nested_attributes_for :images

  def self.filters; Filters; end
  def filters;      Filters; end

  def created_timestamp
    created_at.strftime("%Y-%m-%dT%I:%M:%S-0500") if created_at
  end

  def created_date 
    created_at.strftime("%B %d, %Y") if created_at
  end

  private

    def modify_parent_topic
      topic.last_user = user 
      topic.updated_at = self.created_at
      topic.save
    end

    def set_user_email
      @user ||= User.where(:name => self.user).first
      self.user_email = @user.email if @user
    end
    
end
