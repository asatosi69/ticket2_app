#set :stage, :production
set :branch, 'master' ## 必要があれば変更

server 'IP.AD.RE.SS', user: 'hogehuga', roles: %w{app db web}, port: 55555

set :ssh_options, {
  port: 55555, #### 変更
  keys: [File.expand_path('~/.ssh/id_rsa')], # リモートサーバー用秘密鍵があるところを指定 １で設定したid_rsaを指定すること
  forward_agent: true,
  auth_methods: %w(publickey)
}
