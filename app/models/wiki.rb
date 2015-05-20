class Wiki < ActiveRecord::Base
  has_paper_trail
  acts_as_taggable

  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }
  scope :visible_to_premium, -> (user) { where(user: user, private: true) }

  validates :title, length: { minimum: 7, maximum: 72 }, presence: true
  validates :body, length: { minimum: 120 }, presence: true
  validates :tag_list, presence: :true
  validates :user, presence: true

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
