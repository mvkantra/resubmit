class User < ActiveRecord::Base
  has_many :posts
  validates :username, :presence => true
  validates :password, :presence=>true, :length => {:minimum => 8, :maximum => 20 }
  validates :unity_id, :presence => true
    validates_uniqueness_of :username
end
