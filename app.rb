require "sinatra"
require "sinatra/reloader"

enable :sessions

get  "/" do
  erb :index, layout: :app_layout
end

post "/" do
  @names = params[:names].split(",").shuffle
  @team_amount = params[:number].to_i
  @total_people = @names.length
  @error_message = nil
  @team_list ={}

  if @team_amount > @total_people
    @error_message = "The number is too high enter a lower number"
  elsif @team_amount <= 0
    @error_message = "The team number can't be less than 1"
  else
    for i in (0...@team_amount)
      @team_list["team #{i+1}"] = []
    end

    @team_count = 1
    for num in (0...@total_people)
      if @team_count< @team_amount
        @team_list["team #{@team_count}"] << @names[num]
        @team_count += 1
      elsif @team_count == @team_amount
        @team_list["team #{@team_count}"] << @names[num]
        @team_count = 1
      else
        @error_message
      end
    end
  end
  erb :index, layout: :app_layout
end
