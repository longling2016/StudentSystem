
require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Student
  include DataMapper::Resource
  property :studentID, Serial
  property :firstname, String
  property :lastname, String
  property :birthday, Date
  property :address, String


  def birthday=date
    super Date.strptime(date, '%m/%d/%Y')
  end
end

DataMapper.finalize

get '/students' do
  @students = Student.all
  erb :students
end

get '/students/new' do
  @students = Student.new
  erb :new_student
end

get '/students/:studentID' do
  @students = Student.get(params[:studentID])
  erb :show_student
end

get '/students/:studentID/edit' do
  @students = Student.get(params[:studentID])
  erb :edit_student
end

post '/students' do
  student = Student.create(params[:student])
  redirect to("/students/#{student.studentID}")
end

put '/students/:studentID' do
  student = Student.get(params[:studentID])
  student.update(params[:student])
  redirect to("/students/#{student.studentID}")
end

delete '/students/:studentID' do
  Student.get(params[:studentID]).destroy
  redirect to('/students')
end
