class User < ApplicationRecord
   validates :name, presence: true, length: { maximum: 50 }
   validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
   validates :password, presence: true                 
   has_secure_password
   
   has_many :actionplans
   
   has_many :favorites
   has_many :likes, through: :favorites, source: :actionplan
   
  #favoriteを追加する
  def addfavorite(actionplan)
     self.favorites.find_or_create_by(actionplan_id: actionplan.id)
  end
 
  #favoriteを削除する
  def unfavorite(actionplan)
    favorite = self.favorites.find_by(actionplan_id: actionplan.id)
    favorite.destroy if favorite
  end
  
  #既にお気に入り登録されているか調べる
  def likes?(other_actionplan)
   self.likes.include?(other_actionplan)
  end
   
end
