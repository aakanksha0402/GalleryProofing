class Album < ActiveRecord::Base

  #associations
  has_many :album_shares
  belongs_to :gallery
  has_many :album_photos, dependent: :destroy

  belongs_to :parent_album, :class_name => 'Album',:foreign_key => 'parent'
  has_many :children_album, :class_name => 'Album',  :foreign_key => 'parent' , dependent: :destroy

  has_many :photos, as: :imageable, dependent: :destroy

  has_attached_file :cover_url, :styles => { :small => "108x76" }

  #validation
  validates :title, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  validates_attachment_content_type :cover_url, :content_type => ['image/jpeg', 'image/jpg', 'image/png']
  validates :title, presence: true

  #scope
  scope :get_first_level_albums ,-> { where(:parent => 0)}
  scope :get_next_level_albums , -> (level,parent) {where(:level => level , :parent => parent)}

  def array_checking(children_array = [] ,level)
    children_array << self.id
    sub_albums = self.children_album
    if level == 4
      return 0
    else
      sub_albums.each do |album|
        sub_alb = album.array_checking(children_array , level + 1)
      end
      return children_array
    end
  end



  # def count_sub_album_level(level)
  #   level = level + 1
  #   sub_albums = self.children_album
  #   if !sub_albums.present?
  #     puts "----------hi test---#{level}"
  #     return level
  #   else
  #     sub_albums.each do |album|
  #       level = album.count_sub_album_level(level)
  #     end
  #   end
  #   return level
  # end


  def count_sub_album_level(children_array_level = [])
    children_array_level << self.level
    sub_albums = self.children_album
    if !sub_albums.present?
      return children_array_level
    else
      sub_albums.each do |album|
        sub_alb = album.count_sub_album_level(children_array_level)
      end
    end
    return children_array_level
  end


  def change_sub_level_album(level)
    self.level = level
    self.save
    sub_albums = self.children_album
    if self.level == 3 || !sub_albums.present?
      puts "hi test is here."
      return 0
    else
      sub_albums.each do |album|
        level = album.change_sub_level_album(self.level + 1)
      end
    end

  end

  def assign_photo_parent_album_to_sub_album(parent)
    sub_albums = self.children_album
    if self.level == 3 || !sub_albums.present?
      parent.photos.update_all(:imageable_id => self.id)
      return 0
    else
      sub_albums.each do |album|
        level = album.change_sub_level_album(parent)
      end
    end
  end

  def photos_count
    puts self.id
    puts self.title
    puts "----------------------"
    @album = Album.find(self.id)
    @child_album = Album.where(parent: @album.id)
    if @child_album.present?
      @count = 0
    else
      @count = @album.photos.where(is_delete: false).count
    end
    @count
  end
end
