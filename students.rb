
require 'dm-core'
require 'dm-migrations'

enable :sessions

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

enable :sessions

get '/students' do
  @students = Student.all
  erb :students
end

get '/students/new' do
  if session[:admin]
    @students = Student.new
    erb :new_student
  else
    session[:message] = "/students/new"
    erb :login
  end
end


get '/students/:studentID' do
  @student = Student.get(params[:studentID])
  erb :show_student
end

get '/students/:studentID/edit' do
  if session[:admin]
    @student = Student.get(params[:studentID])
    erb :edit_student
  else
    session[:message] = "/students/#{params[:studentID]}/edit"
    redirect to("/login")
  end
end

post '/students' do
  # check if current ID is already exist or not
  if Student.get(params[:student][:studentID]).nil?
    # check if user try to input empty content
    if params[:student][:firstname].gsub!(/\W+/, '').eql?('') || params[:student][:lastname].gsub!(/\W+/, '').eql?('')
      erb :wrong_date
    else
      begin
        Date.strptime(params[:student][:birthday], "%m/%d/%Y")
        student = Student.create(params[:student])
        redirect to("/students/#{student.studentID}")
      rescue ArgumentError
        erb :wrong_date
      end
    end
  else
    erb :wrong_date
  end
end

put '/students/:studentID' do
  if Student.get(params[:student][:studentID]).nil? || params[:student][:studentID].eql?(params[:studentID])
    if params[:student][:firstname].gsub!(/\W+/, '').eql?('') || params[:student][:lastname].gsub!(/\W+/, '').eql?('')
      @cur_student = params[:studentID]
      erb :wrong_date
    else
      student = Student.get(params[:studentID])
      student.update(params[:student])
      puts 'db_log: hitting put method'
      puts student.studentID
      redirect to("/students/#{student.studentID}")
    end
  else
    erb :wrong_date
  end
end

delete '/students/:studentID' do
  if session[:admin]
    Student.get(params[:studentID]).destroy
    redirect to('/students')
  else
    session[:message] = "/students/#{params[:studentID]}"
    redirect to("/login")
  end
end
