# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  layout "login"
  # render new.erb.html
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      ambiente = Ambiente.find_all_by_user_id(user)
      #@ambiente = ambiente.last
      if ambiente.present?
        redirect_back_or_default(home_path(:user => user, :type => 0))
      else
        redirect_to(ambiente_configuracoes_path)
      end
      flash[:notice] = "BEM VINDO AO BIBLOS"

    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "ATÉ MAIS....."
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "ACESSO NÃO AUTORIZADO '#{params[:login]}'"
    logger.warn "ACESSO NÃO AUTORIZADO '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
