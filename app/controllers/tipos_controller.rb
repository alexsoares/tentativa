class TiposController < ApplicationController
  def index
    @tipos = Tipo.all
  end

  def show
    @tipo = Tipo.find(params[:id])
  end

  def new
    @tipo = Tipo.new
  end

  def create
    @tipo = Tipo.new(params[:tipo])
    if @tipo.save
      flash[:notice] = "CADASTRADO COM SUCESSO."
      redirect_to @tipo
    else
      render :action => 'new'
    end
  end

  def edit
    @tipo = Tipo.find(params[:id])
  end

  def update
    @tipo = Tipo.find(params[:id])
    if @tipo.update_attributes(params[:tipo])
      flash[:notice] = "CADASTRADO COM SUCESSO."
      redirect_to @tipo
    else
      render :action => 'edit'
    end
  end

  def destroy
    @tipo = Tipo.find(params[:id])
    @tipo.destroy
    flash[:notice] = "EXCLUIDO COM SUCESSO."
    redirect_to tipos_url
  end
end
