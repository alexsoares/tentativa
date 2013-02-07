class HomeController < ApplicationController
  before_filter :login_required, :load_resources
  
  def index
    @emprestimos = Emprestimo.paginate(:all,:conditions => ["status = 1 and unidade_id = ?",current_user.unidade], :per_page => 15, :page => params[:page], :order => "id Desc")
    a = Ambiente.find_by_user_id(current_user.id)
    if a.present?
       u = a.user_id
       @a = a
    end
  end

  def load_resources
  end

end
