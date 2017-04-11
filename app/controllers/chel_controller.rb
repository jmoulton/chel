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
end
