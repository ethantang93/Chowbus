class ChowbusController < ApplicationController
  def index
  end

  def login_auth
    email = params[:email]
    password = params[:password]
    if email == "admin@chowbus.com"
      if password == "admin"
        redirect_to '/admin'
      else
        flash[:error]="wrong email/password combination"
        redirect_to :back
      end
    else
      if Rest.find_by_email(email).try(:authenticate, password)
        user = Rest.find_by_email(email)
        session[:rest_user]=user.id
        redirect_to '/restaurant'
      else
        flash[:error] ="wrong email/password combination"
        redirect_to :back
      end
    end
  end

  def admin
    @rests = Rest.all
    @schedules = Schedule.all
    @zones = Zone.all
    @days = ["Mon","Tue","Wed","Thur","Fri"]
  end

  def update_schedule
    days = ["Mon","Tue","Wed","Thur","Fri"]
    ###   loop through five columns of data
    days.each do |day_loop|
      data = Schedule.find_by(day:day_loop,rest_id:params[:rest_id])
      ###   check if there are any existing data. if not, then create the data
      if data.blank?
        Schedule.create(day:day_loop,Rest_id:params[:rest_id],Zone_id:params[day_loop])
      ###   if data already exist then update the Zone_id column
      else
        data.Zone_id = params[day_loop]
        data.save
      end
    end
    flash[:success]="Update Success"
    redirect_to :back
  end

  def allmeal
    ###   if the first time visit this page params[:date] will be empty
    ###   Thus first time opening this page, it will be displaying all the avaliable meals
    if params[:date].blank?
      @meals = Meal.all
    else
      # if day of the week is specified then find the meals avaliable by finding what Restaurant is deliverying on that date
      rest_id = []
      schedules = Schedule.where(day:session[:weekday])
      schedules.each do |sch|
        rest_id.push(sch.Rest_id)
      end
    ###   get rest_id which is the array of ids of the restaurants that's devlierying on that date
    ###   after getting the ids of restaurants then we can find the meals by doing this query
    ###   rendering in html page
    @meals = Meal.where(Rest_id:rest_id)
    ###  convert to json
    return @meals.as_json(root: true)
    end
  end

  def restaurant
    @meals = Meal.where(Rest_id:session[:rest_user])
  end

  def delete_meal
    ###  find the id of the meal and then delete this data
    Meal.find(params[:id]).destroy
    redirect_to :back
  end

  def logout
    session[:rest_user]=nil
    redirect_to '/'
  end
end
