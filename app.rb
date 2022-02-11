require "sinatra"
require "bcdice"
require "bcdice/game_system"
require 'dotenv/load'

get '/roll' do
  if request.get_header('HTTP_X_COROBOT_TOKEN') != ENV['X-COROBOT-TOKEN']
    return status 403
  end

  text = params[:text]
  text ||= "1d100"
  cthulhu = BCDice.game_system_class("Cthulhu")
  result = cthulhu.eval(text)

  [200, nil, { result: result.text }.to_json]
end
