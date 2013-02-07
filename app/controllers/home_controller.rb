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
    begin
      session[:falha] = nil
      if current_user.unidade_id == 53
        @classes = Aluno.all(:select => "id_classe, classe_descricao, classe_ano, id_escola",:conditions => ["classe_ano = ?", Date.today.strftime("%Y").to_i], :group => ["id_classe,classe_descricao, classe_ano,id_escola"] , :order => "classe_descricao")
      else
        @classes = Aluno.all(:select => "id_classe, classe_descricao, classe_ano, id_escola",:conditions => ["classe_ano = ? and id_escola = ?", Date.today.strftime("%Y").to_i, current_user.unidade.unidades_gpd_id], :group => ["id_classe,classe_descricao, classe_ano,id_escola"] , :order => "classe_descricao")
      end
    rescue
      session[:falha] = "Impossivel conectar ao servidor. Emprestimos e Devoluções desabilitadas"
    end
     #@disponiveis = Dpu.all(:include => [:livro =>[:identificacao]],:conditions => ["(dpus.livro_id is not null) and dpus.status = 1 and dpus.unidade_id = ?", current_user.unidade_id],:order => "identificacaos.livro ASC")
  end

end
