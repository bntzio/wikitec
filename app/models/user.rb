class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy
  has_many :collaborators
  has_many :collaborator_wikis, through: :collaborators, source: :wiki

  after_initialize :init

  def admin?
    role == 'admin'
  end

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def init
    self.role ||= 'standard'
  end

  def upgrade
    self.update_attributes(:role => 'premium')
  end

  def downgrade
    self.update_attributes(:role => 'standard')
  end

  def self.find_version_author(version)
    find(version.terminator)   
  end
end