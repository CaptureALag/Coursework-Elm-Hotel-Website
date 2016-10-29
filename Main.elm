import Html exposing (Html, node, div, button, text, nav, a)
import Html.Attributes exposing (class, classList, href, rel)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import Dict exposing (Dict)
import ContentLayout exposing (renderLayout)
import Models exposing (..)

import Debug

main =
  beginnerProgram { model = 
    { appState =
        { selectedNavIcon = 
            "icon-navigation"

        , currentRoute = MenuPage

        , currentSortOption = Popularity
        , currentSortOrder = Desc
        , currentPage = 1
        , currentFilterByCountry = Nothing
        }
    , appContent =         
        { countries = 
            [ { id = "cyprus"
              , name = "Кіпр"
              , nameLocativeCase = "Кіпр" 
              },
              { id = "ibiza"
              , name = "Ібіца"
              , nameLocativeCase = "Ібіцу" 
              },
              { id = "malta"
              , name = "Мальта"
              , nameLocativeCase = "Мальту" 
              },
              { id = "crit"
              , name = "Крит"
              , nameLocativeCase = "Крит" 
              }
            ]
        , hotels =
            [
              { id = "cassandra-mare"
              , name = "Cassandra Mare"
              , popularity = 1
              , countryId = "malta"
              , stars = 5
              , bgPhotoUrl = "bg_1.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 400
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 550
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 600 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 1000
                    }
                  ]   
              , duration = 6
              , depart = "14.08.2017"
              },  
              { id = "akrathos-hotel"
              , name = "Akrathos Hotel"
              , popularity = 2
              , countryId = "ibiza"
              , stars = 4
              , bgPhotoUrl = "bg_2.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 200
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 800
                    }
                  ]
              , duration = 5    
              , depart = "18.08.2017"
              },
              { id = "alara-hotel"
              , name = "Alara Hotel"
              , popularity = 3
              , countryId = "cyprus"
              , stars = 3
              , bgPhotoUrl = "bg_3.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 150
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 600
                    }
                  ]  
              , duration = 4
              , depart = "24.08.2017"
              },
              { id = "boumerang"
              , name = "Boumerang"
              , popularity = 4
              , countryId = "crit"
              , stars = 4
              , bgPhotoUrl = "bg_4.jpg"
              , photoUrls = []
              , priceOptions = 
                  [ 
                    { name = "OB"
                    , personCapacity = 1
                    , price = 200
                    },
                    { name = "BB"
                    , personCapacity = 1
                    , price = 250
                    },
                    { name = "OB"
                    , personCapacity = 2
                    , price = 300 
                    }, 
                    { name = "ALL"
                    , personCapacity = 2
                    , price = 800
                    }
                  ] 
            , duration = 5
            , depart = "21.08.2017"
            }
            ]
        }
    }
    , view = view, update = update }

{- countriesToLinks : List Country -> List (Html msg) 
countriesToLinks = List.map (\country -> a [href ("/"++country.id)] [text ("Тури на " ++ country.nameLocativeCase)])


viewRightBlock : Model -> Html Msg
viewRightBlock model = 
  nav []
     (countriesToLinks model.countries)        
-}

view : Model -> Html Msg
view model =
  div []
    [(renderLayout (\x -> text "") model)]

updateAppState : (AppState -> AppState) -> Model -> Model
updateAppState f model =
  let appState = model.appState
  in {model | appState = f appState}


update : Msg -> Model -> Model
update msg =
  case msg of
    (Models.NavIconClick iconClass) ->
      updateAppState (\st -> { st | selectedNavIcon = iconClass } )
    (SortOptionSelect opt ord) ->
      updateAppState (\st -> { st | currentSortOption = opt , currentSortOrder = ord})
    (RouteChange route) ->
      updateAppState (\st -> { st | currentRoute = route})
    LogoClick ->
      updateAppState (\st -> { st | currentRoute = MenuPage })
    SetFilterByCountry country ->
      updateAppState (\st -> { st | currentFilterByCountry = country})
