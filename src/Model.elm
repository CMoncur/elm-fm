module Model exposing (..)

import Time exposing (..)

-- MODEL --
type alias Model =
  { apiKey      : String
  , url         : String
  , user        : String
  , err         : Bool
  , errMsg      : String
  , lastFmData  : Tracks
  -- , time        : Time
  }

type alias Tracks = List Items

type alias Items =
  { artist    : String
  , track     : String
  , album     : String
  , albumImg  : List String
  -- , listened  : String
  }
