class Product < ActiveRecord::Base

  acts_as_indexed :fields => [:name, :description, :summary]
  
  acts_as_taggable_on :tags

  validates :name, :presence => true, :uniqueness => true
  validate :validate_category
  
  scope :less_than, lambda { |price| where("price < ?", price) }
  scope :greater_than, lambda { |price| where("price > ?", price) }
  
  scope :best_sellers, where(:best_seller => true)
  scope :featured,    where(:featured    => true)
  scope :new_products, where(:new_product => true)
  
  scope :by_category, lambda { |category_id| 
                                  ids = []
                                  Category.find(category_id).children.each do |child|
                                    ids << child.id
                                  end
                                  ids << category_id
                                  
                                  joins(:categories).where("categories.id" => ids)
                             }
  
  belongs_to :image
  has_and_belongs_to_many :categories  
  has_many :line_items
  has_many :variants
    
  def title
    name
  end
    
  def validate_category
    categories.each do |category|
      if category.children.present?
        errors.add_to_base("Cannot assign product to a category that has sub-categories")
      end
    end
  end
end
