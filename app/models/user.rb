class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:github]

  has_many :bug_types, dependent: :nullify, foreign_key: :creator_id, class_name: "BugType"

  has_many :authorizations, dependent: :destroy

  has_many :votes, dependent: :destroy

end
