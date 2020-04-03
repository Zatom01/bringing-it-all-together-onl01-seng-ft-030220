class Dog 
  
  attr_accessor :name, :breed, :id 
  
  
  def initialize (name:,breed:,id: nil)
    @name=name
    @breed=breed
    @id=id 
  end 
  
  def self.create_table
    sql="CREATE TABLE dogs (id INTEGER PRIMARY KEY, name TEXT, breed TEXT)"
    DB[:conn].execute(sql)
  end 
  
  def self.drop_table 
    sql="DROP TABLE dogs"
    DB[:conn].execute(sql)
  end 
  
  def save 
    sql="INSERT INTO dogs (name,breed) VALUES (?,?)"
    DB[:conn].execute(sql,@name,@breed)
    @id= DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
  end 
  
  
  
  def update 
    sql="UPDATE dogs SET name=?,breed=? WHERE id=?"
    DB[:conn].execute(sql,self.name,self.breed,self.id)
  end 
  
end 
