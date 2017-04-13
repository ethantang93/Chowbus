class Api::ApiController < ApplicationController
  def find_meal
    rest_id = []
    dict = {"1" => "Mon", "2" => "Tue", "3" => "Wed", "4" => "Thur", "5" => "Fri"}
    date = dict[params[:date]]

    schedules = Schedule.where(day:date)
    schedules.each do |sch|
      rest_id.push(sch.Rest_id)
    end
    @meals = Meal.where(Rest_id:rest_id)
    render :json => @meals
  end
end
