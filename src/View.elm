module View exposing (..)

import Array exposing ( get, fromList )
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import String exposing ( length )
import Update exposing (..)

-- VIEW --
view : Model -> Html Msg
view model =
  div []
    [ showAlbum 0 "image_header" model.lastFmData
    , showAlbum 1 "image_secondary" model.lastFmData
    , showAlbum 2 "image_tertiary" model.lastFmData
    , showAlbum 3 "image_tertiary" model.lastFmData
    , showAlbum 4 "image_tertiary" model.lastFmData
    , showAlbum 5 "image_tertiary" model.lastFmData
    , input [ onInput NewUsername, placeholder "Last.fm username", type' "text" ] []
    , button [ onClick GetUserInfo ] [ text "Search" ]
    ]


showAlbum : Int -> String -> ( List Items ) -> Html Msg
showAlbum index imgType list =
  let item =
    get index (fromList list)
  in
    case item of
      Nothing   -> div [] [ text "Empty list" ]
      Just item ->
        div [ class imgType ]
          [ img [ src <| showAlbumArt item.albumImg ] [] ]

showAlbumArt : ( List String ) -> String
showAlbumArt imgs =
  let img =
    get 3 (fromList imgs)
  in
    case img of
      Nothing   -> "No image"
      Just img  ->
        case length img of
          0 -> "No image"
          _ -> img
