class LogsController < ApplicationController
  def create
    @log = Log.new(user_id: current_user.id, date: Date.today)
    @log.mood = params[:log][:mood]

    # These code snippets use an open-source library.
      # These code snippets use an open-source library. http://unirest.io/ruby
      response = Unirest.post "https://twinword-sentiment-analysis.p.mashape.com/analyze/",
        headers:{
          "X-Mashape-Key" => "GCJFhTmVFdmshOwuMVwcE9v7EIzUp1LM2YGjsnAcTBOfV8Q0tn",
          "Content-Type" => "application/x-www-form-urlencoded",
          "Accept" => "application/json"
        },
        parameters:{
          "text" => "great value in its price range!"
        }
    puts "testjalkfjweklfjawlkfjwlkafjawlkefj   "
    puts response
    puts response.label
    puts "end"


    if params[:log][:factor_logs] != nil
      for factor_id, score in params[:log][:factor_logs]
        factor_log = @log.factor_logs.build(factor_id: factor_id)
        factor_log.score = score
        factor_log.save
      end
    end
    @log.save
    redirect_to root_url
  end

  def update
    @log = current_user.logs.where(date: Date.today)[0]
    @log.mood = params[:log][:mood]

    # These code snippets use an open-source library. http://unirest.io/ruby
    response = Unirest.post "https://twinword-sentiment-analysis.p.mashape.com/analyze/",
      headers:{
        "X-Mashape-Key" => "GCJFhTmVFdmshOwuMVwcE9v7EIzUp1LM2YGjsnAcTBOfV8Q0tn",
        "Content-Type" => "application/x-www-form-urlencoded",
        "Accept" => "application/json"
      },
      parameters:{
        "text" => "great value in its price range!"
      }
    puts "testjalkfjweklfjawlkfjwlkafjawlkefj   "
    puts response
    puts response.body
    puts "end"

    if params[:log][:factor_logs] != nil
      for factor_id, score in params[:log][:factor_logs]
        factor_log = @log.factor_logs.where(factor_id: factor_id)[0]
        if factor_log == nil
          factor_log = @log.factor_logs.build(factor_id: factor_id)
        end
        factor_log.score = score
        factor_log.save
      end
    end
    @log.save

    redirect_to root_url
  end
end
