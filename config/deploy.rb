# config valid only for current version of Capistrano
# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.11.2'

# Capistranoのログの表示に利用する
set :application, 'demoapp'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:ShoSeshake/demoapp.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1' #カリキュラム通りに進めた場合、2.5.1か2.3.1です

# どの公開鍵を利用してデプロイするか
# set :ssh_options, auth_methods: ['publickey'],
#                   keys: ['<ローカルPCのEC2インスタンスのSSH鍵(pem)へのパス（例：~/.ssh/key_pem.pem）>'] 
set :ssh_options, auth_methods: ['publickey'],keys: ['~/.ssh/id_rsa']

# デプロイするブランチ（デフォルトはmasterブランチ）
# set :branch, master

# デプロイ先のディレクトリ
# set :deploy_to, "/var/www/demoapp"

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
  AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
  AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"]
}

# secrets.yml用のシンボリックリンクを追加
set :linked_files, fetch(:linked_files, []).push("config/master.key")

# 元々記述されていた after 「'deploy:publishing', 'deploy:restart'」以下を削除して、次のように書き換え

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    # invoke 'unicorn:restart'
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end

  desc 'upload secrets.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/secrets.yml', "#{shared_path}/config/secrets.yml")
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end