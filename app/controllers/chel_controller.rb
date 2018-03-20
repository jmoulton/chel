class ChelController < ApplicationController

  def new_match
    player = ":#{params[:user_name]}:"
    match = Match.create(players: [player], max_players: 4)
    actions = players(3, match.id)
    header = random_quote
    text = 'Who wants to play some chel?'
    render_json(header, text, actions)
  end

  def random_quote
    if rand > 0.2222
      ":docemrick: \"#{EMRICK_QUOTES.sample(1).first}\""
    else
      ":eddie: '#{EDDIE_QUOTES.sample(1).first}'"
    end
  end

  def button
    prms = JSON.parse(params[:payload]).symbolize_keys
    match = Match.find(prms[:actions].first['name'])
    return lets_play(match) if prms[:actions].first['value'] == "set_players"
    msg = "Challengers await!"
    challenger = prms[:user]['name']
    match.players << ":#{challenger}:"
    match.save
    if match.players.count == match.max_players
      lets_play(match)
    else
      header = 'Two teams come together!'
      text = "#{match.players.join(' ')} is in! Who else?"
      actions = players(match.max_players - match.players.count, match.id)
      render_json(header, text, actions)
    end
  end

  def lets_play(match)
    text = "Here are your contenders #{match.players.join(' ')}"
    render_json(random_quote, text, [])
  end

  def players(num, match_id)
   actions = [].tap do |action|
     num.times do |index|
       action << {
          name: match_id,
          text: "Join!",
          type: "button",
          value: "player_#{index}"
       }
     end
   end

   actions << {
    name: match_id,
    text: "Set Players",
    value: "set_players",
    type: "button"
   }
  end

  def render_json(header, text, actions)
    render :json => {
      text: header,
      response_type: "in_channel",
      attachments: [
        {
          text: text,
          callback_id: 'chel_game',
          actions: actions,
        }
      ]
    }
  end
end
