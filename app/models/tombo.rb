class Tombo < ActiveRecord::Base
  belongs_to :livro
  belongs_to :dicionario_enciclopedia
  belongs_to :user
end
