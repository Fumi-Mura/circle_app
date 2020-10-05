# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '54.168.172.183', user: 'fumi', roles: %w(app db web)

# デプロイするサーバーにsshログインする鍵の情報を記述
set :ssh_options, keys: '~/.ssh/ones_place_key_rsa'
