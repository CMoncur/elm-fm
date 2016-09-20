module Model exposing (..)

-- MODEL --
type alias Model =
  { apiKey      : String
  , url         : String
  , user        : String
  , err         : Bool
  , errMsg      : String
  , lastFmData  : Tracks
  }

type alias Tracks = List Items

type alias Items =
  { artist    : String
  , track     : String
  , album     : String
  , albumImg  : List String
  }
