class Like < ActiveRecord::Base
          validates_uniqueness_of :user_id, :scope=>:post_id
end
