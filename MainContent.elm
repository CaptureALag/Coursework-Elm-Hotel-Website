module MainContent exposing(..)

import ModelUtils exposing(..)
import Models exposing(..)

import Html exposing(..)
import Html.Attributes exposing(..)


renderMainContent : Model -> Html Msg
renderMainContent model =
   renderCurrentPage model


renderCurrentPage : Model -> Html Msg
renderCurrentPage model =
   div [class "current-page"] ((renderPageSortOptions model)::( List.map renderPageItem (getHotelsOnCurrentPage model) ))


renderPageSortOptions : Model -> Html Msg
renderPageSortOptions model =
   div [class "sort-options"]
     [ label [] [text "Сортувати за"]
     , div [class "variants"]
         (List.map (renderSortOption model) [Popularity, Stars, Price])
     ]

renderSortOption : Model -> SortOption -> Html Msg
renderSortOption model option =
     text (sortingOptionLabel option)

renderPageItem : Hotel -> Html Msg
renderPageItem hotel =
   figure [class "page-item"] 
     [ img [src ("img/" ++ hotel.bgPhotoUrl)] []
     , figcaption [] 
         [ div [class "country-name"]
             [
                 text hotel.countryId
             ]
         , div [class "hotel-info"]
             [
                 text hotel.name
             ]    
         ]
     ]
