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
        , currentSortOption = Popularity
        , currentSortOrder = Desc
        , currentPage = 1
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
              , rooms = []    
              },  
              { id = "akrathos-hotel"
              , name = "Akrathos Hotel"
              , popularity = 2
              , countryId = "ibiza"
              , stars = 4
              , bgPhotoUrl = "bg_2.jpg"
              , photoUrls = []
              , rooms = []    
              },
              { id = "alara-hotel"
              , name = "Alara Hotel"
              , popularity = 3
              , countryId = "cyprus"
              , stars = 3
              , bgPhotoUrl = "bg_3.jpg"
              , photoUrls = []
              , rooms = []    
              },
              { id = "boumerang"
              , name = "Boumerang"
              , popularity = 4
              , countryId = "crit"
              , stars = 4
              , bgPhotoUrl = "bg_4.jpg"
              , photoUrls = []
              , rooms = []    
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

update : Msg -> Model -> Model
update msg model =
  case msg of
    (Models.NavIconClick iconClass) ->
      let appState = model.appState
      in { model | appState = { appState | selectedNavIcon = iconClass } }
    (SortOptionSelect opt ord) ->
      let appState = model.appState
      in {model | appState = { appState | currentSortOption = opt , currentSortOrder = ord}}
