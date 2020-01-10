require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
require('pry')
require("pg")

# /
get('/') do
  erb(:main)
end
#projects

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

post('/projects') do
  title = params[:title]
  id = params[:id]
  project = Project.new({:title => title, :id => id})
  project.save()
  redirect to ('/projects')
end

get('/projects/new') do
  erb(:new_project)
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

patch('/projects/:id') do
  project = Project.find(params[:id].to_i())
  project.update(:title => params[:title])
end
