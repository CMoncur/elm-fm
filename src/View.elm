module View exposing (..)

import Array exposing ( get, fromList )
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
    , showAlbum 0 model.lastFmData
    , showAlbum 1 model.lastFmData
    , showAlbum 2 model.lastFmData
    , showAlbum 3 model.lastFmData
    , showAlbum 4 model.lastFmData
    , input [ onInput NewUsername, placeholder "What is your Last.fm username?", type' "text" ] []
    , button [ onClick GetUserInfo ] [ text "Search Last.fm" ]
    ]


showAlbum : Int -> ( List Items ) -> Html Msg
showAlbum index list =
  let item =
    get index (fromList list)
  in
    case item of
      Nothing   -> div [] [ text "Empty list" ]
      Just item ->
        div []
          [ h5 [] [ text item.artist ]
          , h5 [] [ text item.track ]
          , h5 [] [ text item.album ]
          , img [ src <| showAlbumArt item.albumImg ] []
          ]

showAlbumArt : ( List String ) -> String
showAlbumArt imgs =
  let img =
    get 3 (fromList imgs)
  in
    case img of
      Nothing   -> ""
      Just img  -> img
