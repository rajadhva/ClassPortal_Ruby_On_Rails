class User < ActiveRecord::Base
	has_many :requests, :dependent => :destroy
	has_many :enrollments, :dependent => :destroy
  has_many :course_instructors, :dependent => :destroy
  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :roles

  def self.search(query)
    where("name like ? or email like ? ", "%#{query}%", "%#{query}%")
  end
end
