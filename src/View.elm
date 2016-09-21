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
  let items =
    List.map showAlbum model.lastFmData
  in
    div [ class "cont" ]
      [ div [ class "top clear" ]
          [ h1 [] [ text "elm-fm" ]
          , input [ onInput NewUsername, placeholder "last.fm handle", type' "text" ] []
          , button [ onClick GetUserInfo ] []
          ]
      , div [ class "cont_track-horizontal clear" ]
          [ h2 [] [ text ( model.user ++ "'s recently scrobbled" ) ]
          , div [ class "clear" ] items
          ]
      ]

showAlbum : Items -> Html Msg
showAlbum item =
  div [ class "track clear" ]
    [ img [ class "track_cover", src <| showAlbumArt item.albumImg ] []
    , div [ class "track_overlay" ]
        [ h5 [] [ text item.artist ]
        , h5 [] [ text item.track ]
        , h5 [] [ text item.album ]
        ]
    ]

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
