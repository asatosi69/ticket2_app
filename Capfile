# capistranoの基本動作を設定
require "capistrano/setup"   
require "capistrano/deploy"  
require "capistrano/scm/git" 
install_plugin Capistrano::SCM::Git


require "capistrano/rails" 
require "capistrano/rails/assets"
require "capistrano/rails/migrations" 
# rbenvの設定
require "capistrano/rbenv" #ok
require "capistrano/bundler"
require "pry" # 全然必要ないけどデバッグで便利でした...

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
