class GroupEvent < ActiveRecord::Base

  before_save :default_values

  def default_values
    self.deleted ||= 0
    self.published ||= 0
    self.duration ||= 0
  end

  def status
    self.published ? 'Published' : 'Draft'
  end

end
