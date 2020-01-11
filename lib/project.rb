class Project
  attr_reader :id, :title


  def initialize(attributes)
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
  end


  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    return projects
  end


  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}' ) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(project_to_compare)
    self.id.eql?(project_to_compare.id)
  end

  def self.clear
    DB.exec("DELETE FROM projects *;")
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    title = project.fetch("title")
    id = project.fetch("id").to_i
    Project.new({:title => title, :id => id})
  end

  def self.search(name)
    project = DB.exec("SELECT * FROM projects WHERE name = '#{name}'").first
    title = project.fetch("title")
    id = project.fetch("id").to_i
    Project.new({:title => title, :id => id})
  end

  def self.query(name)
    search_results = []
    projects = DB.exec("SELECT * FROM projects WHERE name LIKE '%#{name}%';")
    projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id")
      projects.push(Project.new({:title => title, :id => id}))
    end
    return search_results
  end

  def volunteers
    results = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{id};")
    volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id")
      id = volunteer.fetch("id")
      results.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
    end
    return results
  end

  def update(attributes)
    @title = attributes.fetch(:title)
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end
end
