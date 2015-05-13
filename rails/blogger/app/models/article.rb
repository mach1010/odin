class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  
  validates_attachment_content_type :image, content_type: 
    ["image/jpg", "image/jpeg", "image/png"]
  validates :author_id, presence: true
  
  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end
  
  def tag_list=(tags_string)
    tags = Tag.all
    tag_names = tags_string.split(",").map {|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.map {|tag| Tag.find_or_create_by(name: tag)}
    self.tags = new_or_found_tags
  end
end
