module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import Update exposing (..)

-- VIEW --
view : Model -> Html Msg
view model =
  div []
    [ p [] [ text <| toString model.apiKey ]
    , p [] [ text <| toString model.url ]
    , p [] [ text <| toString model.err]
    , p [] [ text <| toString model.errMsg]
    , input [ onInput NewUsername, placeholder "What is your Last.fm username?", type' "text" ] []
    , button [ onClick GetUserInfo ] [ text "Search Last.fm" ]
    ]
