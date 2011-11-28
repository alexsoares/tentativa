class ConfiguracaosController < ApplicationController
  def index
    @configuracaos = Configuracao.all
  end

  def show
    @configuracao = Configuracao.find(params[:id])
  end

  def new
    @configuracao = Configuracao.new
  end

  def create
    @configuracao = Configuracao.new(params[:configuracao])
    if @configuracao.save
      flash[:notice] = "Successfully created configuracao."
      redirect_to @configuracao
    else
      render :action => 'new'
    end
  end

  def edit
    @configuracao = Configuracao.find(params[:id])
  end

  def update
    @configuracao = Configuracao.find(params[:id])
    if @configuracao.update_attributes(params[:configuracao])
      flash[:notice] = "Successfully updated configuracao."
      redirect_to @configuracao
    else
      render :action => 'edit'
    end
  end

  def destroy
    @configuracao = Configuracao.find(params[:id])
    @configuracao.destroy
    flash[:notice] = "Successfully destroyed configuracao."
    redirect_to configuracaos_url
  end
end
