class ChelController < ApplicationController

  EMRICK_QUOTES = %W(
    What\ magic\ to\ even\ get\ the\ shot\ away
    Gaining\ space...maybe\ time.
    Drilled\ into\ the\ turnbuckle
    A\ lightening\ like\ glove
    Got\ that\ in\ the\ trapper!
    The\ draw,\ the\ tie-up,\ and\ his\ team\ prevails
    Two\ guys\ together\ with\ force...BIG\ force
    The\ stick\ can\ break\ up\ a\ play...and\ it\ just\ DID!
    Forcing\ attention\ in\ deep
    WAFFLEBOARDED!
    He\ got\ REEFED!
    A\ HAMMER\ SHOT!
    That\ shot\ HIT\ A\ MAN!
    What\ a\ RIPPER!
    Big\ sweeping\ save!
    Will\ this\ be\ icing?\ Aaaand\ it\ will\ be!\ on\ the\ defense\ arriving\ first
    oh\ he’ll\ pay\ for\ that\ one!
    My\ goodness!
    No\ team\ worth\ its\ name\ will\ stand\ for\ this
    THAT\ WAS\ DEFENSE!!
    Moving\ to\ the\ shadow\ of\ the\ boards
  )

  def new_match
    player = ":#{params[:user_name]}:"
    match = Match.create(players: [player], max_players: 4)
    actions = players(3, match.id)
    header = random_quote
    text = 'Who wants to play some chel?'
    render_json(header, text, actions)
  end

  def random_quote
    ":docemrick: '#{EMRICK_QUOTES.sample(1).first}'"
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
