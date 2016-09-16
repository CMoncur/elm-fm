module Main exposing (..)

import Html.App as App
import Model exposing (..)
import Time exposing (Time, minute)
import Update exposing (..)
import View exposing (..)

-- INIT --
init : ( Model, Cmd Msg )
init =
  ( { apiKey    = "2565f3575fabaf43ac6b3261980907d5"
    , url       = "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=Cmoncur&api_key=2565f3575fabaf43ac6b3261980907d5&format=json&limit=5"
    , user      = "CMoncur"
    , artist    = ""
    , track     = ""
    , imgUrl    = ""
    , getError  = ""
    }
  , Cmd.none
  )

-- SUBSCRIPTIONS --
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- APP (MAIN) --
main : Program Never
main =
  App.program
    { init          = init
    , view          = view
    , update        = update
    , subscriptions = subscriptions
    }
