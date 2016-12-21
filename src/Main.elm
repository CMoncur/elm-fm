module Main exposing (..)

import Html.App as App
import Model exposing (..)
import Time exposing (Time, every, second)
import Update exposing (..)
import View exposing (..)

-- INIT --
init : String -> ( Model, Cmd Msg )
init url =
  ( { apiKey      = "2565f3575fabaf43ac6b3261980907d5"
    , url         = "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=Cmoncur&api_key=2565f3575fabaf43ac6b3261980907d5&format=json&limit=25"
    , user        = "CMoncur"
    , err         = False
    , errMsg      = ""
    , lastFmData  = []
    -- , time        = 1481397021311
    }
  , getUserInfo url
  )

-- SUBSCRIPTIONS --
subscriptions : Model -> Sub Msg
subscriptions model =
  every second GetNewTime

-- APP (MAIN) --
main : Program Never
main =
  App.program
    { init          = init "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=Cmoncur&api_key=2565f3575fabaf43ac6b3261980907d5&format=json&limit=25"
    , view          = view
    , update        = update
    , subscriptions = subscriptions
    }
