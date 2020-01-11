require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
require('pry')
require("pg")

DB = PG.connect({:dbname => 'volunteer_tracker'})


also_reload('lib/**/*.rb')


# /
get('/') do
  redirect to ('/projects')
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

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.update(:title => params[:title])
  @projects = Project.all
  redirect to ('/')
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i)
  erb(:edit_project)
end


get('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  project = Project.new(:title => @project.title, :id => params[:id])
  @volunteers = project.volunteers
  erb(:project)
end


delete('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.delete()
  @projects = Project.all
  redirect to ("/projects/:id")
end

get('/projects/:id/volunteers') do

end

post('/projects/:project_id/volunteers') do
  project_id = params[:project_id]
  name = params[:name]
  id = params[:id]
  volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => id})
  volunteer.save()
  redirect to ("/projects/#{params[:project_id]}")
end

get('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i)
  erb(:volunteer)
end
