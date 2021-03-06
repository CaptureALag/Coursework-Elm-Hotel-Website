module Models exposing(..)

import Dict exposing (Dict)


type Msg = 
    NavIconClick String 
  | SortOptionSelect SortOption SortOrder
  | RouteChange Route
  | LogoClick
  | SetFilterByCountry (Maybe Country)
  | Pagination Int
  | FormPhoneChange String
  | FormSubmit
  | ToggleBlogEntrySelected Int

type alias Model =
    { appState : AppState
    , appContent : AppContent
    
    }

type alias AppState =
    { selectedNavIcon : String

    , currentRoute : Route

    , currentSortOption : SortOption
    , currentSortOrder : SortOrder
    , currentPage : Int
    , currentFilterByCountry : Maybe Country

    , formSubmitted : Bool
    , formPhone : String
    , formFailureMessage : String

    , selectedBlogEntryId : Maybe Int
    }

type Route = MenuPage | HotelPage Hotel
type SortOption = Popularity | Stars | Price | Depart
type SortOrder = Asc | Desc

type alias AppContent = 
    { countries : List Country
    , hotels : List Hotel
    , blog : List BlogEntry
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
    , priceOptions : List PriceOption
    , duration : Int
    , depart : String

    , photoUrls : List String
    , videoUrl : Maybe String
    , description : String
    , features : List String
    , postDescription : String
    }

type alias BlogEntry = 
    { id : Int
    , timePosted : String
    , header : String
    , fullText : String
    }


type alias PriceOption =
    { name : String
    , personCapacity : Int
    , price : Int
    }
