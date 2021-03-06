#set :stage, :production
set :stage, :production
set :branch, 'master' ## 必要があれば変更

server '160.251.15.86', user: 'asatosi69', roles: %w{app db web}, port: 55555

set :ssh_options, {
  port: 55555, #### 変更
  keys: [File.expand_path('~/.ssh/id_rsa')], # リモートサーバー用秘密鍵があるところを指定 １で設定したid_rsaを指定すること
  forward_agent: true,
  auth_methods: %w(publickey)
}
