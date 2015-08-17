class GroupEvent < ActiveRecord::Base

  validates :name, :location, :description, :start_date, :end_date, :duration, :published, presence: true, :on => :update, :if => :just_published?

  before_save :default_values

  def default_values
    self.deleted ||= 0
    self.published ||= 0
    self.duration ||= 0
  end

  def status
    self.published ? 'Published' : 'Draft'
  end

  def just_published?
    changed.include?('published') && published?
  end

end
