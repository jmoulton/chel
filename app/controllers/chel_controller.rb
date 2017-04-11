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
  )

  def new_match
    render :json => {
      text: ":docemrick: '#{EMRICK_QUOTES.sample(1).first}'",
      attachments: [
        {
          text: "Who wants to play some chel?",
          callback_id: 'chel_game',
          actions: [
            {
              name: "match_type",
              text: "1v1",
              type: "button",
              value: "1v1",
            },
            {
              name: "match_type",
              text: "2v1",
              type: "button",
              value: "2v1",
            },
            {
              name: "match_type",
              text: "2v2",
              type: "button",
              value: "2v2",
            }
          ]
        }
      ]
    }
  end

  def button
    case params[:callback_id]
    when 'chel_game'
      case params[:value]
      when '1v1'
        render_players(2)
      when '2v1'
        render_players(3)
      when '2v2'
        render_players(4)
      end
    end
  end

  def render_players(num)
   actions = [].tap do |action|
     num.times do |index|
       action << {
          name: "Player_#{index}",
          text: "Join!",
          type: "button",
          value: "player_#{index}"
       }
     end
   end

   render :json => {
      text: ":docemrick: 'Two Teams Collide!'",
      attachments: [
        {
          text: "Callengers await!",
          callback_id: 'chel_challenge',
          actions: actions
        }
      ]
    }
  end
end
