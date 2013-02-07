class LivrosController < ApplicationController
  before_filter :login_required
  before_filter :load_resources
  before_filter :load_livros_tipo

    def create_editora
      @editora = Editora.new(params[:editora])
      if @editora.save
        @livro = Livro.new
        render :update do |page|
          page.replace_html 'editora', :partial => "shared/campos/campos_editora"
          page.replace_html 'aviso', :text => "EDITORA CADASTRADA, CONTINUE O CADASTRO. LEMBRE-SE DE SELECIONAR A EDITORA"
        end

      end
      
    end

    def create_titulo
      @titulo = Identificacao.new(params[:titulo])
      if @titulo.save
        session[:identificacao_id] = @titulo.id
        @livro = Livro.new
        render :update do |page|
          page.replace_html 'aviso', :text => "Titulo Inserido, favor selecioná-lo"
          page.replace_html 'identificacao', :text => @titulo.livro
          page.replace_html 'subtitulo', :text => "<b>Subtitulo: </b>#{@titulo.subtitulo}"
        end
      end
    end




    def livro
    @livro = Identificacao.find(:all,:conditions => ["livro like ?",params[:nome_livro]+"%"])
    @livro_hash = []
    @livro.each do |id|
      @livro_hash <<  id.livro
    end
    respond_to do |format|
      format.js
      format.json  { render :json => @livro_hash.to_json }
      

    end
  end


  def index

       @contador = Livro.all.count
       @livros = Livro.paginate :all, :page => params[:page], :per_page => 50, :joins => :identificacao,:order => 'livro ASC'


      #@livro = Identificacao.all :order => 'livro ASC'
      #@livros = Livro.paginate :all, :page => params[:page], :per_page => 20

    #@livro_hash = []
    #@livro.each do |id|
    #  @livro_hash <<  id.livro
    #end

    respond_to do |format|
      format.html
      format.json { render :json => Identificacao.paginate(:page => params[:page], :per_page => 50) }
    #  format.js
    #  format.json  { render :json => @livro_hash }
    end

  end

  def show
    @livro = Livro.find(params[:id])
    $teste = @livro.status
  end

  def new
    @livro = Livro.new
  end

  def create
    qtd = params[:livro][:qtde_livros].to_i
    if qtd == 0
      qtd = 1
    end
    tombos = params[:livro][:lista_tombos].split(";")
      i = 0
      @livros_cad = []
      qtd.times do
        @livro = Livro.new(params[:livro])
        #Log.gera_log("CRIACAO", "LIVROS", current_user.id,@livro.id)
        @livro.identificacao_id = session[:identificacao_id]
        @livro.usuario = current_user.id
        @livro.unidade = current_user.unidade_id
        if params[:livro][:qtde_livros].to_i == 0
          @livro.qtde_livros = 1
        else
          @livro.qtde_livros = params[:livro][:qtde_livros].to_i
        end

        @livro.tombo_l = tombos[i]
        #@livros_cad << @livro.tombo_l
        @livro.save
        i += 1
      end
      session[:identificacao_id] = nil
      redirect_to livros_cadastrados_livros_path
      #render :action => 'livros_cadastrados', :collection => @livros_cad
  end


  def livros_cadastrados
    limit = Tombo.last(:conditions => ["user_id = ? and livro_id is not null", current_user])
    @livros_cad = Tombo.all(:conditions => ["user_id = ? and livro_id is not null", current_user], :limit => limit.qtde_livro, :order => "id DESC")
    t = 0
  end

  def edit
    @livro = Livro.find(params[:id])
    @autores_selecionados = @livro.autores
    @autores =  @autores - @autores_selecionados
    @assuntos_selecionados = @livro.assuntos
    @assuntos = @assuntos - @assuntos_selecionados
  end


  def resumo
    @livro = Livro.find(params[:livro])
  end


  def update
    @livro = Livro.find(params[:id])
    if @livro.update_attributes(params[:livro])
      flash[:notice] = "ATUALIZADO COM SUCESSO."
      redirect_to @livro
    else
      render :action => 'edit'
    end
  end

  def destroy
    @livro = Livro.find(params[:id])
    @livro.destroy
    flash[:notice] = "EXCLUIDO COM SUCESSO."
    redirect_to livros_url
  end

  def visualizar_check
    if params[:livro_assunto_id].to_i == 1
      render :partial => "check"
    end
  end

def consulta_tipo
  
end

def consulta_liv
   unless params[:search].present?
     if params[:type_of].to_i == 7
       @contador = Livro.all(:include => [:localizacao],:conditions => ["localizacoes.unidade_id = ?", current_user.unidade_id]).count
       @livros = Livro.paginate(:all, :include => [:identificacao,:localizacao],:conditions => ["localizacoes.unidade_id = ?", current_user.unidade_id], :page => params[:page], :per_page => 50,:order => 'livro ASC')
       render :update do |page|
         page.replace_html 'livros', :partial => "livros"
       end
     end
   else
      if params[:type_of].to_i == 1
          @contador = Livro.all(:include => [:identificacao, :localizacao], :conditions => ["identificacaos.livro like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%", current_user.unidade_id]).count
          @livros = Livro.paginate( :all,:page => params[:page], :per_page => 50, :include => [:identificacao, :localizacao],  :conditions => ["identificacaos.livro like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%", current_user.unidade_id],:order => 'livro ASC')
          render :update do |page|
            page.replace_html 'livros', :partial => "livros"
          end
          else if params[:type_of].to_i == 2
            @contador = Livro.all(:include => [:area,:localizacao], :conditions => ["areas.nome like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%",current_user.unidade_id]).count
            @livros = Livro.paginate :all, :page => params[:page], :per_page => 50, :include => [:area,:localizacao],  :conditions => ["areas.nome like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%",current_user.unidade_id],:order => 'nome ASC'
            render :update do |page|
              page.replace_html 'livros', :partial => "livros"
            end
            else if params[:type_of].to_i == 3
              @contador = Livro.all(:include => [:autores,:localizacao], :conditions => ["autores.nome like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%",current_user.unidade_id]).count
              @livros = Livro.paginate :all, :page => params[:page], :per_page => 50, :include => [:autores,:localizacao],  :conditions => ["autores.nome like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%",current_user.unidade_id],:order => 'nome ASC'
              render :update do |page|
                page.replace_html 'livros', :partial => "livros"
              end
              else if params[:type_of].to_i == 4
                @contador = Livro.all(:include => [:assuntos,:localizacao], :conditions => ["assuntos.descricao like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%",current_user.unidade_id]).count
                @livros = Livro.paginate(:all, :page => params[:page], :per_page => 50, :include => [:localizacao,:assuntos],  :conditions => ["assuntos.descricao like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%",current_user.unidade_id],:order => 'descricao ASC')
                render :update do |page|
                  page.replace_html 'livros', :partial => "livros"
                end
                else if params[:type_of].to_i == 5
                  @contador = Livro.all(:include => [:editora,:localizacao], :conditions => ["editoras.nome like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%",current_user.unidade_id]).count
                  @livros = Livro.paginate(:all, :page => params[:page], :per_page => 50, :include => [:editora,:localizacao],  :conditions => ["editoras.nome like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%",current_user.unidade_id],:order => 'nome ASC')
                  render :update do |page|
                    page.replace_html 'livros', :partial => "livros"
                  end
                  else if params[:type_of].to_i == 6
                    @contador = Livro.all(:include => :localizacao, :conditions => ["livros.tombo_l like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%",current_user.unidade_id]).count
                    @livros = Livro.paginate(:all, :page => params[:page], :per_page => 50, :include => :localizacao,  :conditions => ["livros.tombo_l like ? and localizacoes.unidade_id = ?", "%" + params[:search].to_s + "%",current_user.unidade_id],:order => 'tombo_l ASC')
                    render :update do |page|
                      page.replace_html 'livros', :partial => "livros"
                    end
                  end
                end
              end
            end
          end
      end
   end
end

def consulta_liv_are
  if params[:area].present?
    if params[:type_area].to_i == 1
    area = Area.find(params[:area][:id])
    @areas = area.livros.all(:include => [:localizacao], :conditions => ["localizacoes.unidade_id = ?",current_user.unidade_id]).each
      render :update do |page|
         page.replace_html 'dados', :partial => "areas_livro"
      end    
    else
      if params[:type_area].to_i == 2
        area = Area.find(params[:area][:id])
        @areas = area.livros.all
          render :update do |page|
            #page.replace_html 'dados', :partial => "livros_area"
            page.replace_html 'dados', :partial => "areas_livro"
          end
      end
    end
  end
end

def consulta_liv_aut
  if params[:autor].present?
    if params[:type_autor].to_i == 1
    autor = Autor.find(params[:autor][:id])
    @autores = autor.livros.all(:include => [:localizacao], :conditions => ["localizacoes.unidade_id = ?",current_user.unidade_id]).each
      render :update do |page|
         page.replace_html 'dados', :partial => "autores_livro"
      end
    else
      if params[:type_autor].to_i == 2
        autor = Autor.find(params[:autor][:id])
        @autores = autor.livros.all
          render :update do |page|
            #page.replace_html 'dados', :partial => "livros_area"
            page.replace_html 'dados', :partial => "autores_livro"
          end
      end
    end
  end
end

def consulta_liv_ass
  if params[:assunto].present?
    if params[:type_assunto].to_i == 1
    assunto = Assunto.find(params[:assunto][:id])
    @assuntos = assunto.livros.all(:include => [:localizacao], :conditions => ["localizacoes.unidade_id = ?",current_user.unidade_id]).each
      render :update do |page|
         page.replace_html 'dados', :partial => "assuntos_livro"
      end
    else
      if params[:type_assunto].to_i == 2
        assunto = Assunto.find(params[:assunto][:id])
        @assuntos = assunto.livros.all
          render :update do |page|
            page.replace_html 'dados', :partial => "assuntos_livro"
          end
      end
    end
  end
end

def consulta_liv_edi
  if params[:editora].present?
    if params[:type_editora].to_i == 1
    editora = Editora.find(params[:editora][:id])
    @editoras = editora.livros.all(:include => [:localizacao], :conditions => ["localizacoes.unidade_id = ?",current_user.unidade_id]).each
      render :update do |page|
         page.replace_html 'dados', :partial => "editoras_livro"
      end
    else
      if params[:type_editora].to_i == 2
        editora = Editora.find(params[:editora][:id])
        @editoras = editora.livros.all
          render :update do |page|
            page.replace_html 'dados', :partial => "editoras_livro"
          end
      end
    end
  end
end


def consulta_liv_tit
  if params[:titulo].present?
    if params[:type_titulo].to_i == 1
     titulo = Identificacao.find(params[:titulo][:id])
    @titulos = titulo.livros.all(:include => [:localizacao], :conditions => ["localizacoes.unidade_id = ?",current_user.unidade_id]).each
      render :update do |page|
         page.replace_html 'dados', :partial => "titulos_livro"
      end
    else
      if params[:type_titulo].to_i == 2
        titulo = Identificacao.find(params[:titulo][:id])
        @titulos = titulo.livros.all
          render :update do |page|
            page.replace_html 'dados', :partial => "titulos_livro"
          end
      end
    end
  end
end


def consulta_liv_tip
  if params[:livro].present?
    if params[:type_tipo].to_i == 1

    tipo = Livro.find(params[:livro][:tipo])
    @livros = Livro.find.all(:include => [:localizacao], :conditions => ['tipo = ? and localizacoes.unidade_id = ?', $tipo, current_user.unidade_id]).each

      render :update do |page|
         page.replace_html 'dados', :partial => "tipos_livro"
      end
    else
      if params[:type_editora].to_i == 2
        tipo = Livro.find(params[:livro][:id])
        @livros = Livro.find.all
          render :update do |page|
            page.replace_html 'dados', :partial => "editoras_livro"
          end
      end
    end
  end
end


  def filtrar    
    if params[:busca].present?
      @identificacoes = Identificacao.all(:conditions =>["livro like ?", params[:busca][:busca]+"%"])
    end
#      render :update do |page|
#        page.replace_html 'ident', :partial => "campos_identificacao"
#        page.replace_html 'aviso', :text => "Filtrado!"
#      end
      render :update do |page|
        page.replace_html 'lista_livros', :partial => "lista_livros"
      end
  end

  def return      
      session[:identificacao_id] = params[:selected]
      @identificacao = Identificacao.find(params[:selected])
      render :update do |page|
        page.replace_html 'identificacao', :text => @identificacao.livro
        page.replace_html 'subtitulo', :text => "<b>Subtitulo: </b>#{@identificacao.subtitulo}"
      end
  end


  def create_autor
    @autor = Autor.new(params[:autor])
    if @autor.save
      @autores = Autor.all
      @livro = Livro.new
      render :update do |page|
        page.replace_html 'autores', :partial => "shared/campos/campos_autor"
        page.replace_html 'aviso', :text => "AUTOR CADASTRADO, CONTINUE O CADASTRO. LEMBRE-SE DE SELECIONAR O AUTOR"
      end

    end
  end

  def create_assunto
    @assunto = Assunto.new(params[:assunto])
    if @assunto.save
      @assuntos = Assunto.all
      @livro = Livro.new
      render :update do |page|
        #page.replace_html 'assuntos', :partial => "shared/campos/campos_assunto"
        page.replace_html '#test', :partial => "shared/campos/assunto"
        page.replace_html 'aviso', :text => "ASSUNTO CADASTRADO, CONTINUE O CADASTRO. LEMBRE-SE DE SELECIONAR O ASSUNTO"
      end

    end
  end
  
  def create_local
    @localizacao = Localizacao.new(params[:localizacao])
    @localizacao.add_unidade(current_user.unidade_id)
    if @localizacao.save
      @localizacoes = Localizacao.all(:conditions => ["unidade_id = ?", current_user.unidade_id])
      @livro = Livro.new
      render :update do |page|
        page.replace_html 'local', :partial => "shared/campos/campos_local"

        page.replace_html 'aviso', :text => "NOVA LOCALIZAÇÃO CADASTRADA, CONTINUE O CADASTRO"
      end

    end
  end


 def subtitulo
  session[:identificacao] = params[:livro_identificacao_id]
   #@identificacao = Identificacao.find(:all, :conditions => ["id=?", session[:identificacao]])
   @identificacao = Identificacao.find_by_id(session[:identificacao]).subtitulo
   #$teste = @identificacao.subtitulo
   render :partial => 'subtitulo'
 end

 def lista_tipo
    $tipo = params[:livro_tipo]
    @livros = Livro.find(:all, :conditions => ['tipo = ?', $tipo])

    render :partial => 'livros'
  end


  protected

  def load_resources
    @assuntos = Assunto.all(:order => "descricao ASC")
    @identificacoes  = Identificacao.all(:order => 'livro ASC')
    @autores  = Autor.all(:order => "nome ASC")
    @areas = Area.all(:order => 'nome ASC')
    @editoras = Editora.all(:order => 'nome ASC')
    @titulos = Identificacao.all(:order => 'livro ASC')
    if current_user.unidade_id == 53
      @localizacoes = Localizacao.all(:include => :unidade,:order => 'local_guardado ASC')
    else
      @localizacoes = Localizacao.all(:include => :unidade, :conditions => ['unidade_id = ?', current_user.unidade_id], :order => 'local_guardado ASC')
    end    
  end

   def load_livros_tipo
      @livros_tipo = Livro.find(:all, :select => 'distinct tipo')
      
  end
end
