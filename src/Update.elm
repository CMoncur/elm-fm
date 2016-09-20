module Update exposing (..)

import Http
import Json.Decode as Json exposing (..)
import Json.Decode.Extra exposing (..)
import Model exposing (..)
import Task exposing (..)
import Time exposing (..)

-- UPDATE --
type Msg
  = GetFail String
  | GetSucceed String
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
    GetSucceed rawJson ->
      ( model
          |> updateErr False
          |> updateErrMsg ""
          |> putTrackInfo rawJson
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
decode : Decoder LastFmData

getUserInfo : String -> Cmd Msg
getUserInfo url =
  Http.get decode url
    |> Task.mapError toString
    |> Task.perform GetFail GetSucceed

putTrackInfo : String -> Model -> Model
putTrackInfo rawJson model = model

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
