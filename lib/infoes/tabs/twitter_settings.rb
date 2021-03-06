module Infoes
  class TwitterSettings < SideTab

    TWITTER_SIGNUP = "https://twitter.com/signup"

    def content
      if TwitterConnection.already_authenticated?
        tweets_to_load_option
      else
        connect_to_twitter_button
        para @slot.app.link "Sign up at Twitter" do
          Launchy.open(TWITTER_SIGNUP)
        end
      end
    end

    private

    def connect_to_twitter_button
      button "Connect infoes with twitter" do
        authorization_url = TwitterConnection.get_request_token
        Launchy.open(authorization_url)
        pincode = ask "A page should have been opened in your web browser. " +
                      "Please authorize this app and then enter the " +
                      "pincode displayed to you there here."

        TwitterConnection.complete_authentication(pincode)
        alert "Succesfully registered with Twitter!"
        reset
      end
    end

    def tweets_to_load_option
      flow do
        para "Number of tweets to load:"
        to_load_edit = edit_line TwitterConnection.tweets_to_load
        button "Change" do
          TwitterConnection.tweets_to_load = to_load_edit.text
          alert "You successfully changed the number of tweets to load!"
        end
      end
    end

  end
end

