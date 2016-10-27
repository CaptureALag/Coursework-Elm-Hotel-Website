module Models exposing(..)

import Dict exposing (Dict)


type Msg = 
    NavIconClick String 
  | SortOptionSelect SortOption SortOrder

type alias Model =
    { appState : AppState
    , appContent : AppContent
    
    }

type alias AppState =
    { selectedNavIcon : String

    , currentSortOption : SortOption
    , currentSortOrder : SortOrder
    , currentPage : Int
    }

type SortOption = Popularity | Stars | Price
type SortOrder = Asc | Desc

type alias AppContent = 
    { countries : List Country
    , hotels : List Hotel
    }

type alias Country =
    { id : String
    , name : String
    , nameLocativeCase : String
    }

type alias Hotel = 
    { id : String
    , name : String
    , popularity : Int
    , countryId : String
    , stars : Int
    , bgPhotoUrl : String
    , photoUrls : List String
    , rooms : List Room    
    }

type alias Room = 
    { id : Int
    , hotelId : String
    , personCapacity : Int
    , priceOptions : List PriceOption
    }

type alias PriceOption =
    { optionName : String
    , price : Int
    }
