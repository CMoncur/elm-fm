module Update exposing (..)

import Model exposing (..)
import Time exposing (Time)

-- UPDATE --
type Msg = Username Time
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Username _ ->
          ( model
              |> changeNumber
          , Cmd.none
          )

-- UPDATE SUPPORTING FUNCTIONS
changeNumber : Model -> Model
changeNumber model =
  { model | counter = model.counter + 1 }
