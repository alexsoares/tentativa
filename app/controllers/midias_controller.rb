class MidiasController < ApplicationController

  before_filter :login_required
  before_filter :load_resources


  # GET /midias
  # GET /midias.xml
  def index
    @midias = Midia.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @midias }
    end
  end

  # GET /midias/1
  # GET /midias/1.xml
  def show
    @midia = Midia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @midia }
    end
  end

  # GET /midias/new
  # GET /midias/new.xml
  def new
    @midia = Midia.new

    end


  # GET /midias/1/edit
  def edit
    @midia = Midia.find(params[:id])
  end


  def create
    @midia = Midia.new(params[:midia])
    if @midia.save
      flash[:notice] = "Successfully created audio visual."
      redirect_to @midia
    else
      render :action => 'new'
    end
  end


  # PUT /midias/1
  # PUT /midias/1.xml
  def update
    @midia = Midia.find(params[:id])

    respond_to do |format|
      if @midia.update_attributes(params[:midia])
        flash[:notice] = 'Midia was successfully updated.'
        format.html { redirect_to(@midia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @midia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /midias/1
  # DELETE /midias/1.xml
  def destroy
    @midia = Midia.find(params[:id])
    @midia.destroy

    respond_to do |format|
      format.html { redirect_to(midias_url) }
      format.xml  { head :ok }
    end
  end


   def create_local
    @localizacao = Localizacao.new(params[:localizacao])
    @localizacao.add_unidade(current_user.unidade_id)
    if @localizacao.save
      @localizacoes = Localizacao.all
      @midia = Midia.new
      render :update do |page|
        page.replace_html 'local', :partial => "shared/campos/campos_local"
        page.replace_html 'aviso', :text => "NOVA LOCALIZAÇÃO CADASTRADA, CONTINUE O CADASTRO"
      end

    end
  end


   def create_cantor
    @cantor = Cantor.new(params[:cantor])
    if @cantor.save
      @cantores = Cantor.all
      @midia = Midia.new
      render :update do |page|
        page.replace_html 'cantores', :partial => "shared/campos/campos_cantor"
        page.replace_html 'aviso', :text => "CANTOR CADASTRADO, CONTINUE O CADASTRO. LEMBRE-SE DE SELECIONAR O AUTOR"
      end

    end
  end
   def create_musica
    @musica = Musica.new(params[:musica])
    if @musica.save
      @musicas = Musica.all
      @midia = Midia.new
      render :update do |page|
        page.replace_html 'musicas', :partial => "shared/campos/campos_musica"
        page.replace_html 'aviso', :text => "MÚSICA CADASTRADA, SELECIOINAR A MUSICA E CONTINUAR O CADASTRO"
      end

    end
  end


 def consultaMid
   unless params[:search].present?
     if params[:type_of].to_i == 6
       @contador = Midia.all.count
       @midias = Midia.paginate :all, :page => params[:page], :per_page => 10,:order => 'titulo ASC'
       render :update do |page|
         page.replace_html 'midias', :partial => "midias"
       end
     end
   else
      if params[:type_of].to_i == 1
          @contador = Midia.all(:conditions =>  ["titulo like ? and tipo =?", "%" + params[:search].to_s + "%","CD"]).count
          @midias = Midia.paginate :all, :page => params[:page], :per_page => 10, :conditions => ["titulo like ? and tipo =?", "%" + params[:search].to_s + "%","CD"], :order => 'titulo ASC'
          render :update do |page|
            page.replace_html 'midias', :partial => "midias"
          end
          else if params[:type_of].to_i == 2
          @contador = Midia.all(:conditions => ["titulo like ? and tipo =?", "%" + params[:search].to_s + "%","DVD"]).count
          @midias = Midia.paginate :all, :page => params[:page], :per_page => 10,:conditions => ["titulo like ? and tipo =?", "%" + params[:search].to_s + "%","DVD"], :order => 'titulo ASC'
            render :update do |page|
              page.replace_html 'midias', :partial => "midias"
            end
            else if params[:type_of].to_i == 3
              @contador = Midia.all(:conditions => ["titulo like ? and tipo =?", "%" + params[:search].to_s + "%","VHS"]).count
              @midias = Midia.paginate :all, :page => params[:page], :per_page => 10,:conditions => ["titulo like ? and tipo =?", "%" + params[:search].to_s + "%","VHS"], :order => 'titulo ASC'
              render :update do |page|
                page.replace_html 'midias', :partial => "midias"
              end
              else if params[:type_of].to_i == 4
               @contador = Midia.all(:conditions => ["titulo like ? and tipo =?", "%" + params[:search].to_s + "%","OUTROS"]).count
               @midias = Midia.paginate :all, :page => params[:page], :per_page => 10,:conditions => ["titulo like ? and tipo =?", "%" + params[:search].to_s + "%","OUTROS"], :order => 'titulo ASC'
                render :update do |page|
                  page.replace_html 'midias', :partial => "midias"
                end
                else if params[:type_of].to_i == 5
                  @contador = Midia.all(:conditions => ["titulo like ? and genero_id =?", "%","17"]).count
                  @midias = Midia.paginate :all, :page => params[:page], :per_page => 10,:conditions => ["titulo like ? and genero_id =?", "%" ,"17"], :order => 'titulo ASC'
                  render :update do |page|
                    page.replace_html 'midias', :partial => "midias"
                  end
                end
              end
            end
          end
      end
   end
end


protected

  def load_resources
    @cantores= Cantor.all(:order => 'nome ASC')
    @musicas= Musica.all(:order => 'nome ASC')
    @generos= Genero.all(:order => 'nome ASC')
    if current_user.unidade_id == 53
      @localizacoes = Localizacao.all(:order => 'local_guardado ASC')
    else
      @localizacoes = Localizacao.all(:conditions => ['unidade_id = ?', current_user.unidade_id], :order => 'local_guardado ASC')
    end

end

end