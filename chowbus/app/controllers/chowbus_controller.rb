class ChowbusController < ApplicationController
  def index
  end

  def login_auth
    email = params[:email]
    password = params[:password]
    if email == "admin@chowbus.com"
      if password == "admin"
        redirect_to '/admin'
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
    days.each do |day_loop|
      data = Schedule.find_by(day:day_loop,rest_id:params[:rest_id])
      if data.blank?
        Schedule.create(day:day_loop,Rest_id:params[:rest_id],Zone_id:params[day_loop])
      else
        data.Zone_id = params[day_loop]
        data.save
      end
    end
    # monday = Schedule.find_by(day:"Mon",rest_id:params[:rest_id])
    # if monday.blank?
    #   Schedule.create(day:"Mon",Rest_id:params[:rest_id],Zone_id:params[:"Mon"])
    # else
    #   monday.Zone_id = params[:"Mon"]
    #   monday.save
    # end
    #
    # tuesday = Schedule.find_by(day:"Tue",rest_id:params[:rest_id])
    # if tuesday.blank?
    #   Schedule.create(day:"Tue",Rest_id:params[:rest_id],Zone_id:params[:"Tue"])
    # else
    #   tuesday.Zone_id = params[:"Tue"]
    #   tuesday.save
    # end
    #
    # wednesday = Schedule.find_by(day:"Wed",rest_id:params[:rest_id])
    # if wednesday.blank?
    #   Schedule.create(day:"Wed",Rest_id:params[:rest_id],Zone_id:params[:"Wed"])
    # else
    #   wednesday.Zone_id = params[:"Wed"]
    #   wednesday.save
    # end
    #
    # thursday = Schedule.find_by(day:"Thur",rest_id:params[:rest_id])
    # if thursday.blank?
    #   Schedule.create(day:"Thur",Rest_id:params[:rest_id],Zone_id:params[:"Thur"])
    # else
    #   thursday.Zone_id = params[:"Thur"]
    #   thursday.save
    # end
    #
    # friday = Schedule.find_by(day:"Fri",rest_id:params[:rest_id])
    # if friday.blank?
    #   Schedule.create(day:"Fri",Rest_id:params[:rest_id],Zone_id:params[:"Fri"])
    # else
    #   friday.Zone_id = params[:"Fri"]
    #   friday.save
    # end
    flash[:success]="Update Success"
    redirect_to :back
  end

  def allmeal
    if params[:date].blank?
      @meals = Meal.all
    else
      rest_id = []
      schedules = Schedule.where(day:session[:weekday])

      schedules.each do |sch|
        rest_id.push(sch.Rest_id)
      end
    #  @meals here is used for rendering in html page
    @meals = Meal.where(Rest_id:rest_id)
    #  convert to json
    return @meals.as_json(root: true)
    end
  end

  def restaurant
    @meals = Meal.where(Rest_id:session[:rest_user])
  end
  def delete_meal
    Meal.find(params[:id]).destroy
    redirect_to :back
  end
  def logout
    session[:rest_user]=nil
    redirect_to '/'
  end
end
