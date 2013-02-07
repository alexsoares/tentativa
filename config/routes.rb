ActionController::Routing::Routes.draw do |map|
  map.resources :carts
  map.resources :cart_items
  map.resources :classes
  map.resources :informativos
  map.resources :tombos,:only => [:index], :collection => {:usuario => :get, :livros_diarios => :get,:de_diarios => :get}
  map.resources :logs
  map.resources :consultas,:only => [:index] , :collection => {:global => :get,:gerar_tombos => :get,:criar_consulta => :get, :lista_tombo => :get}
  map.resources :midias, :collection => {:midias_cadastradas => :get}
  map.resources :musicas
  map.resources :cantores
  map.resources :generos
  map.resources :roles_users, :collection => {:lista_users => :get}
  map.resources :configuracoes, :collection => {:ambiente => :get}
  map.resources :importar
  map.resources :emprestimos, :member => [:devolucao,:recibo],:collection => {:busca_tombo => :get,:ativos => :get,:realiza_busca => :get,:busca_emprestimo => :get,:funcionario => :get, :alunos => :get,:classe => :get, :dpu => :get, :busca => :get, :devolve_unit => :get, :retorna_busca => :get, :cria_carrinho => :get}
  map.resources :funcionarios
  map.resources :tipos
  map.resources :unidades
  map.resources :musicas
  map.resources :autores
  map.resources :itens_assuntos
  map.resources :assuntos
  map.resources :jogos, :collection => {:jogos_cadastrados => :get}
  map.resources :periodicos
  map.resources :mapas
  map.resources :mapas
  map.resources :dicionario_enciclopedias, :collection => {:de_cadastrados => :get}
  map.resources :livros,:collection => {:livros_cadastrados => :get}
  map.ambientes '/configuracoes/ambiente', :controller => 'configuracoes', :action => 'create_ambiente'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users
  map.resource :session
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resource :password
  map.reset_password '/reset_password/:id', :controller => 'passwords', :action => 'edit'
  map.resources :users
  map.resumo '/resumo/:livro', :controller => 'livros', :action => 'resumo'
  map.current_cart 'cart', :controller => 'carts', :action => 'show'

  map.consultaDic '/consultaDic', :controller => 'dicionario_enciclopedias', :action => 'consulta_dic'
  map.consultaLiv '/consultaLiv', :controller => 'livros', :action => 'consulta_liv'
  map.consultaLivAre '/consultaLivAre', :controller => 'livros', :action => 'consulta_liv_are'
  map.consultaLivAut '/consultaLivAut', :controller => 'livros', :action => 'consulta_liv_aut'
  map.consultaLivAss '/consultaLivAss', :controller => 'livros', :action => 'consulta_liv_ass'
  map.consultaLivEdi '/consultaLivEdi', :controller => 'livros', :action => 'consulta_liv_edi'
  map.consultaLivTit '/consultaLivTit', :controller => 'livros', :action => 'consulta_liv_tit'
  map.consultaLivTip '/consultaLivTip', :controller => 'livros', :action => 'consulta_liv_tip'

  map.consultaJog '/consultaJog', :controller => 'jogos', :action => 'consulta_jog'

  map.consultaMap '/consultaMap', :controller => 'mapas', :action => 'consulta_map'

  map.consultaAut '/consultaAut', :controller => 'autores', :action => 'consulta_aut'
  map.consultaAutLiv '/consultaAutLiv', :controller => 'autores', :action => 'consulta_aut_liv'


  map.consultaTipo '/consultaTipo', :controller => 'livros', :action => 'consulta_tipo'

  map.consultaAre '/consultaAre', :controller => 'areas', :action => 'consulta_are'
  


  map.consultaEdi '/consultaEdi', :controller => 'editoras', :action => 'consulta_edi'
  map.consultaEdiLiv '/consultaEdiLiv', :controller => 'editoras', :action => 'consulta_edi_liv'
  map.consultaTit '/consultaTit', :controller => 'identificacaos', :action => 'consulta_tit'
  map.consultaGen '/consultaGen', :controller => 'generos', :action => 'consultaGen'
  map.consultaCan '/consultaCan', :controller => 'cantores', :action => 'consultaCan'
  map.consultaCanMus '/consultaCanMus', :controller => 'cantores', :action => 'consultaCanMus'
  map.consultaMus '/consultaMus', :controller => 'musicas', :action => 'consultaMus'
  map.consultaAud '/consultaAud', :controller => 'audio_visuais', :action => 'consultaAud'
  map.consultaMid '/consultaMid', :controller => 'midias', :action => 'consultaMid'
  map.consultaAsu '/consultaAsu', :controller => 'assuntos', :action => 'consultaAsu'
  map.consultaAsuLiv '/consultaAsuLiv', :controller => 'assuntos', :action => 'consultaAsuLiv'
  map.resource :session
  map.resources :editoras
  map.resources :areas
  map.resources :localizacoes
  map.resources :identificacaos
  map.home '', :controller => 'home', :action => 'index'
  map.root :controller => "home"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.geo "/geos/geo/:id", :controller => "geos", :action => "geo"
  map.show_ambiente "/configuracoes/show_ambiente/:id", :action => "show_ambiente", :controller => "configuracoes"
end
