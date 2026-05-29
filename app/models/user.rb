class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Un user a plusieurs projets, et on detruit ses projets quand on le detruit
  has_many :projects, dependent: :destroy
  # Les chats ne sont pas lies directement au user mais a travers ses projets
  # Pas de dependent ici : les chats sont deja detruits par Project (cascade)
  has_many :chats, through: :projects
end
