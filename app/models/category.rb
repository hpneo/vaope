class Category < ActiveRecord::Base

  has_many :places

  scope :are_parents, where(:parent_id => 0)

  def children
    @children ||= Category.where(:parent_id => self.id)
  end
  
end
