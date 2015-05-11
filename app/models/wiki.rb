class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :visible_to, -> { where(private: false) }

  after_initialize :init

  def init
    self.private ||= false
  end
end
