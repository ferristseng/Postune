set :application, "postune"
set :repository,  "."

set :location, 		"198.199.74.85"

set :deploy_via,	"copy"
set :deploy_to, 	"/var/www/html/cap-#{application}"
set :branch,			"master"
set :scm, 				"git"

set :user, 				"deploy"
set :use_sudo,		false

role :web, location                        								 # Your HTTP server, Apache/etc
role :app, location									                       # This may be the same as your `Web` server
role :db,  location, :primary => true 										 # This is where Rails migrations will run

#set :server, 			:passenger

after "deploy:restart", "deploy:cleanup"

#after "deploy:cleanup"

#namespace :deploy do
#	task :start do ; end
#	task :stop do ; end
#	task :restart, :roles => :app, :except => { :no_release => true } do
#		run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#	end
#end
