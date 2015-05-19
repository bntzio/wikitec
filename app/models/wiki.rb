class Wiki < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  scope :visible_to_premium, -> (user) { where(user: user, private: true) }

  after_initialize :init

  def init
    self.private ||= false
  end

  def markdown_body
    render_as_markdown body
  end

  def public?
    self.private == false
  end

  private

  def render_as_markdown(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end
end
