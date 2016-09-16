module View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Update exposing (..)

-- VIEW --
view : Model -> Html Msg
view model =
  div []
    [ p [] [ text <| toString model ]
    , button [] [ text "Do Things" ]
    ]
