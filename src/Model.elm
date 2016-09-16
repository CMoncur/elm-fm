module Model exposing (..)

-- MODEL --
type alias Model =
  { apiKey    : String
  , url       : String
  , user      : String
  , artist    : String
  , track     : String
  , imgUrl    : String
  , getError  : String
  }
