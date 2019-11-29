class User < ActiveRecord::Base
  has_many :bookmarks
  has_many :storys


  has_secure_password
  validates_presence_of :username, :password_digest
  validates :username, uniqueness: true

  def bookmarked_collect
    self.bookmarks.collect {|b| b.recipe}
  end

  def add_bookmark(story)
    Bookmark.create(user_id: self.id, recipe_id: recipe.id)
    save
  end

  def remove_bookmark(story)
    bookmark = Bookmark.find_by(user_id: self.id, recipe_id: recipe.id)
    bookmark.destroy
    save
  end


end
