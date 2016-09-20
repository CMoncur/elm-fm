module Model exposing (..)

-- MODEL --
type alias Model =
  { apiKey    : String
  , url       : String
  , user      : String
  , err       : Bool
  , errMsg    : String
  }

type alias LastFmData =
  { track : List }
