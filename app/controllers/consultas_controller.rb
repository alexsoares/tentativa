class ConsultasController < ApplicationController
  def tabela_selecionada
      tabela = params[:tabelas]
      @campos = (tabela.camelize.singularize.constantize).column_names.insert(0,"*")
      render :partial => "lista_campos"
  end

  def teste
    t = params[:livro][:assunto_ids]
    u = 0
  end


  def criar_consulta
    #@campos = User.column_names
    @livro = Livro.new
    @assuntos = Assunto.all
     @tabelas = []
    @tables = ActiveRecord::Base.connection.tables
    @tables.each do |z|
      elementos = z.split("_")
      if elementos.count == 1
        @tabelas << z
      end
    end
    @tabelas.insert(0,"")
  end

  def params_consulta    
    campos = params[:fields].chop! if params[:fields][params[:fields].length-1,1] == ","
    tabela = params[:table].singularize.capitalize!
    clausula = params[:clausulas]
    @result = tabela.constantize.all(:select => campos)
    t = 0
  end
end