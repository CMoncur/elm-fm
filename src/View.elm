module View exposing (..)

import Array exposing ( get, fromList )
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)
import String exposing ( length )
import Update exposing (..)
import Time as Time exposing ( Time )
import Task as Task

-- VIEW --
view : Model -> Html Msg
view model =
  let items =
    List.take 21 model.lastFmData
      |> List.map ( showAlbum model.time )
  in
    div [ class "cont" ]
      [ div [ class "top clear" ]
          [ h1 [] [ text "elm-fm" ]
          , input
              [ onInput NewUsername
              , placeholder "last.fm handle"
              , type' "text" ]
              []
          , button [ onClick GetUserInfo ] []
          ]
      , div [ class "cont_track-horizontal clear" ]
          [ h2 [] [ text ( model.user ++ "'s recently scrobbled" ) ]
          , div [ class "clear" ] items
          ]
      ]


showAlbum : Items -> Html Msg
showAlbum item =
-- showAlbum : Time -> Items -> Html Msg
-- showAlbum time item =
  div [ class "track clear" ]
    [ img [ class "track_cover", src <| showAlbumArt item.albumImg ] []
    , div [ class "track_overlay" ]
        [ div [ class "text-cont" ]
          [ h5 [] [ text item.artist ]
          , h6 [] [ text item.track ]
          , h6 [] [ text item.album ]
          -- , h6 [] [ text item.listened ]
          -- , h6 [] [ text <| toString time ]
          ]
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
