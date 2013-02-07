# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130111183855) do

  create_table "ambientes", :force => true do |t|
    t.integer  "turma_id"
    t.integer  "ano_letivo"
    t.integer  "unidade_id"
    t.date     "data"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assuntos", :force => true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assuntos_livros", :id => false, :force => true do |t|
    t.integer "assunto_id", :null => false
    t.integer "livro_id",   :null => false
  end

  create_table "autores", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "autores_livros", :id => false, :force => true do |t|
    t.integer "autor_id", :null => false
    t.integer "livro_id", :null => false
  end

  create_table "cantores", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cantores_midias", :id => false, :force => true do |t|
    t.integer "midia_id",  :null => false
    t.integer "cantor_id", :null => false
  end

  create_table "cart_items", :force => true do |t|
    t.integer  "dpu_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", :force => true do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "configuracaos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "dias_posse"
    t.integer  "dias_para_aviso"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_files", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devolucoes", :force => true do |t|
    t.integer  "emprestimo_id"
    t.date     "data_devolucao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dicionario_enciclopedias", :force => true do |t|
    t.integer  "editora_id"
    t.integer  "area_id"
    t.integer  "localizacao_id"
    t.integer  "identificacao_id"
    t.string   "tombo_seduc"
    t.string   "tombo_l"
    t.string   "colecao"
    t.string   "tipo"
    t.integer  "volume"
    t.date     "data_edicao"
    t.string   "local_edicao"
    t.text     "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",           :default => true
  end

  create_table "dpus", :force => true do |t|
    t.integer  "unidade_id"
    t.string   "tombo"
    t.integer  "livro_id"
    t.integer  "dicionario_enciclopedia_id"
    t.integer  "jogo_id"
    t.integer  "mapa_id"
    t.integer  "midia_id"
    t.integer  "periodico_id"
    t.boolean  "status"
    t.integer  "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "editoras", :force => true do |t|
    t.string   "nome"
    t.string   "cidade"
    t.string   "pais"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emp_temps", :force => true do |t|
    t.integer  "dpu_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emprestimos", :force => true do |t|
    t.integer  "tipo_emprestimo"
    t.integer  "funcionario"
    t.integer  "aluno"
    t.integer  "nome"
    t.integer  "unidade_id"
    t.integer  "alunoclasse_id"
    t.date     "ano"
    t.date     "data_emprestimo"
    t.date     "data_devolucao"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dias_atrasados"
  end

  create_table "emprestimos_realizados", :force => true do |t|
    t.integer  "emprestimo_id"
    t.integer  "dpu_id"
    t.boolean  "ativo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funcionarios", :force => true do |t|
    t.string   "nome"
    t.integer  "matricula"
    t.integer  "unidade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "campo_validacao"
  end

  create_table "generos", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identificacaos", :force => true do |t|
    t.integer  "codigo"
    t.string   "livro"
    t.string   "subtitulo"
    t.text     "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "informativos", :force => true do |t|
    t.text     "mensagem"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "itens_assuntos", :force => true do |t|
    t.integer  "assunto_id"
    t.string   "sub_assunto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jogos", :force => true do |t|
    t.integer  "localizacao_id"
    t.string   "tombo_seduc"
    t.string   "tombo_l"
    t.string   "nome"
    t.string   "faixa_etaria"
    t.string   "tipo"
    t.string   "fabricante"
    t.string   "obs"
    t.boolean  "status",         :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "livros", :force => true do |t|
    t.integer  "identificacao_id"
    t.integer  "area_id"
    t.integer  "editora_id"
    t.integer  "localizacao_id"
    t.integer  "tombo_seduc",      :default => 0
    t.string   "tombo_l"
    t.string   "colecao"
    t.string   "edicao"
    t.date     "data_edicao"
    t.string   "local_edicao"
    t.text     "resumo"
    t.text     "obs"
    t.string   "tipo"
    t.boolean  "status",           :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "localizacoes", :force => true do |t|
    t.integer  "unidade_id"
    t.string   "local_guardado"
    t.string   "aquisicao"
    t.date     "data_aquisicao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", :force => true do |t|
    t.integer  "user_id"
    t.string   "acao"
    t.string   "area"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "find_id"
  end

  create_table "mapas", :force => true do |t|
    t.integer  "editora_id"
    t.integer  "localizacao_id"
    t.string   "titulo"
    t.string   "tombo_seduc"
    t.string   "tombo_l"
    t.string   "tipo"
    t.string   "subtitulo"
    t.date     "ano"
    t.string   "formato"
    t.date     "data_edicao"
    t.string   "local_edicao"
    t.string   "edicao"
    t.text     "obs"
    t.boolean  "status",         :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "midias", :force => true do |t|
    t.integer  "genero_id"
    t.integer  "localizacao_id"
    t.string   "tombo_l"
    t.string   "tombo_seduc"
    t.string   "tipo"
    t.string   "titulo"
    t.string   "subtitulo"
    t.string   "producao"
    t.string   "local_producao"
    t.datetime "data_producao"
    t.string   "obs"
    t.boolean  "status",         :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "midias_musicas", :id => false, :force => true do |t|
    t.integer "midia_id",  :null => false
    t.integer "musica_id", :null => false
  end

  create_table "musicas", :force => true do |t|
    t.string   "nome"
    t.string   "interprete"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "periodicos", :force => true do |t|
    t.integer  "localizacao_id"
    t.string   "tombo_seduc"
    t.string   "tombo_l"
    t.string   "tipo"
    t.string   "titulo"
    t.string   "subtitulo"
    t.string   "colecao"
    t.string   "producao"
    t.string   "periodicidade"
    t.integer  "issn"
    t.string   "local_producao"
    t.date     "data_producao"
    t.string   "obs"
    t.boolean  "status",         :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "possuis", :force => true do |t|
    t.integer  "unidade_id"
    t.string   "tombo"
    t.integer  "livro_id"
    t.integer  "dicionario_enciclopedia_id"
    t.integer  "jogo_id"
    t.integer  "mapa_id"
    t.integer  "midia_id"
    t.integer  "periodico_id"
    t.boolean  "status"
    t.integer  "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "temps", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tipos", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tombos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "livro_id"
    t.string   "index_tombo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "qtde_livro"
    t.integer  "dicionario_enciclopedia_id"
    t.integer  "midia_id"
    t.integer  "jogo_id"
  end

  create_table "unidades", :force => true do |t|
    t.string   "nome"
    t.integer  "unidades_gpd_id"
    t.string   "endereco"
    t.string   "string"
    t.integer  "num"
    t.integer  "integer"
    t.string   "complemento"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "fone"
    t.string   "email"
    t.string   "diretor"
    t.string   "coordenador"
    t.string   "responsavel_bib"
    t.string   "obs"
    t.string   "text"
    t.integer  "tipo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unidades_gpds", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "password_reset_code"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.integer  "unidade_id"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
