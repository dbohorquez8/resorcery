class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :workspaces, inverse_of: :user
  after_create :create_workspace

  private
    def create_workspace
      workspaces.create
    end
end
