class Dog 
  
  attr_accessor :name, :breed, :id 
  
  
  def initialize (id: nil,name:,breed:)
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
    DB[:conn].execute(sql,self.name,self.breed)
    @id= DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    self
  end 
  
  def self.create(hash_attributes)
    dog=Dog.new(hash_attributes)
    dog.save 
    dog 
  end 
  
  def self.new_from_db(row)
    id= row[0]
    name=row[1]
    breed=row[2]
    dog=Dog.new(id: id, name: name, breed: breed)
  end 
  
end 
