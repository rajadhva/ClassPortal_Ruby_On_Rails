class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :roles

   has_many :conversations, :foreign_key => :sender_id

  def self.search(query)
    where("name like ? or email like ? ", "%#{query}%", "%#{query}%")
  end
end
