module Update exposing (..)

import Http
import Json.Decode as Json exposing (..)
import Model exposing (..)
import Task exposing (..)
import Time exposing (..)

-- UPDATE --
type Msg
  = GetFail String
  | GetSucceed ( List Items )
  | GetUserInfo
  | NewUsername String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    GetFail errMsg ->
      ( model
          |> updateErr True
          |> updateErrMsg errMsg
      , Cmd.none
      )
    GetSucceed items ->
      ( model
          |> updateErr False
          |> updateErrMsg ""
          |> putTrackInfo items
      , Cmd.none
      )
    GetUserInfo ->
      ( model
      , getUserInfo model.url
      )
    NewUsername newName ->
      ( model
          |> updateUsername newName
      , Cmd.none
      )

-- UPDATE SUPPORTING FUNCTIONS
decodeData : Decoder Tracks
decodeData =
  Json.object1 identity
    ( Json.at [ "recenttracks", "track" ] <| Json.list decodeTracks )

decodeTracks : Decoder Items
decodeTracks =
  Json.object4 Items
    ( Json.at [ "artist", "#text" ] Json.string ) -- Artist Name
    ( "name" := Json.string ) -- Track Name
    ( Json.at [ "album", "#text" ] Json.string ) -- Album Name
    ( "image" := Json.list ( "#text" := Json.string ) ) -- Album Image URL

getUserInfo : String -> Cmd Msg
getUserInfo url =
  Http.get decodeData url
    |> Task.mapError toString
    |> Task.perform GetFail GetSucceed

putTrackInfo : ( List Items ) -> Model -> Model
putTrackInfo list model =
  { model | lastFmData = list }

updateErr : Bool -> Model -> Model
updateErr errExists model =
  { model | err = errExists }

updateErrMsg : String -> Model -> Model
updateErrMsg msg model =
  { model | errMsg = msg }

updateUsername : String -> Model -> Model
updateUsername newName model =
  { model |
      user = newName,
      url = "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user="
            ++ newName ++ "&api_key="
            ++ model.apiKey ++ "&format=json&limit=5"
  }
