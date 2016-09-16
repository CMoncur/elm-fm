module Main exposing (..)

import Html.App as App
import Model exposing (..)
import Time exposing (Time, minute)
import Update exposing (..)
import View exposing (..)

-- INIT --
init : ( Model, Cmd Msg )
init =
  ( { counter = 0
    }
  , Cmd.none
  )

-- SUBSCRIPTIONS --
subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every minute Username

-- APP (MAIN) --
main : Program Never
main =
  App.program
    { init          = init
    , view          = view
    , update        = update
    , subscriptions = subscriptions
    }
