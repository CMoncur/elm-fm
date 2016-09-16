module Update exposing (..)

import Http
import Json.Decode as Json
import Model exposing (..)
import Task exposing (..)
import Time exposing (Time)

-- UPDATE --
type Msg
  = GetFail Http.Error
  | GetSucceed String
  | GetUserInfo
  | NewUsername String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    GetFail err ->
      ( model
          |> putError err
      , Cmd.none
      )
    GetSucceed rawJson ->
      ( model
          |> putTrackInfo rawJson
      , Cmd.none
      )
    GetUserInfo ->
      ( model
          |> makeUrl
      , getUserInfo model.url
      )
    NewUsername newName ->
      ( model
          |> updateUsername newName
      , Cmd.none
      )

-- UPDATE SUPPORTING FUNCTIONS
decodeJson : Json.Decoder String
decodeJson =
  Json.at ["data", "image_url"] Json.string

getUserInfo : String -> Cmd Msg
getUserInfo givenUrl =
  let url = givenUrl
  in Task.perform GetFail GetSucceed (Http.get decodeJson url)

makeUrl : Model -> Model
makeUrl model =
  { model | url =
    "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user="
    ++ model.user ++ "&api_key="
    ++ model.apiKey ++ "&format=json&limit=5"
  }

putError : Http.Error -> Model -> Model
putError err model =
  { model | getError = toString err }

putTrackInfo : String -> Model -> Model
putTrackInfo rawJson model =
  { model | artist = rawJson }

updateUsername : String -> Model -> Model
updateUsername newName model =
  { model | user = newName }
