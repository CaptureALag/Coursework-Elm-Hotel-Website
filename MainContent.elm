module MainContent exposing(..)

import ModelUtils exposing(..)
import Models exposing(..)

import Html exposing(..)
import Html.Attributes exposing(..)
import Html.Events exposing(onClick)

renderMainContent : Model -> Html Msg
renderMainContent model =
   div [class "main-content"]
     [
       case model.appState.currentRoute of
          MenuPage -> renderMenuPage model
          HotelPage hotel -> renderHotelPage model hotel
     ]

renderMenuPage : Model -> Html Msg
renderMenuPage model =
   div [class "menu-page"] ((renderPageSortOptions model)::( List.map renderMenuPageItem (getHotelsOnCurrentPage model) ))


renderHotelPage : Model -> Hotel -> Html Msg
renderHotelPage model hotel =
   div [class "hotel-page"]
      [ renderMenuPageItem hotel
               
      ]


renderPageSortOptions : Model -> Html Msg
renderPageSortOptions model =
   div [class "sort-options"]
     [ label [] [text "Сортувати за"]
     , div [class "variants"]
         (List.map (renderSortOption model) [Popularity, Stars, Price])
     ]

renderSortOption : Model -> SortOption -> Html Msg
renderSortOption model option =
     let isSelected = (option == model.appState.currentSortOption)
         currentOrd = model.appState.currentSortOrder
         in a 
              [ href "#" 
              , classList[("selected", isSelected)] 
              , onClick (SortOptionSelect option (if isSelected then (negateSortOrder currentOrd) else Desc))] 
              [text (sortingOptionLabel option), text (if isSelected then sortingOrderLabel (currentOrd) else "")]

renderMenuPageItem : Hotel -> Html Msg
renderMenuPageItem hotel =
   figure [class "menu-item", onClick (RouteChange (HotelPage hotel))] 
     [ img [src ("img/" ++ hotel.bgPhotoUrl)] []
     , figcaption [] 
         [ div [class "country-name"]
             [ 
                 text hotel.countryId
             ]
         , div [class "hotel-info"]
             [ 
                div [class ("stars-"++(toString hotel.stars))]
                   (
                       List.repeat (hotel.stars) (div [class "star"] [])
                   )
             ,  h5 [] [ text hotel.name ]
             ]    
         ]
     ]
