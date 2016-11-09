module MainContent exposing(..)

import ModelUtils exposing(..)
import Models exposing(..)

import Html exposing(..)
import Html.Attributes exposing(..)
import Html.Events exposing(onClick)

import RightBlock exposing(..)

renderMainContent : Model -> Html Msg
renderMainContent model =
   div [class "content"]
     [ div [class "main-content"] 
        [ case model.appState.currentRoute of
             MenuPage -> renderMenuPage model
             HotelPage hotel -> renderHotelPage model hotel
        , renderRightBlock model
        ]
     {-     , renderRightBlock model -}
     ]

renderMenuPage : Model -> Html Msg
renderMenuPage model =
   let currentPage = model.appState.currentPage
   in div [class "menu-page"] 
        ( List.append (
            (renderHeadling model)::
            ( List.map renderMenuPageItem (getHotelsOnCurrentPage model) )
          )
          (if (pagesCount model) == 1 then [] else [div [class "pagination"] 
            [ button [onClick (Pagination (-1)), classList [("hidden", currentPage == 1), ("page-prev", True)]] []
            , span [] [ text ((toString currentPage) ++ " сторінка") ]
            , button [onClick (Pagination 1), classList [("hidden", currentPage == (pagesCount model)), ("page-next", True)]] []        
            ]
          ])
        )


renderHotelPage : Model -> Hotel -> Html Msg
renderHotelPage model hotel =
   div [class "hotel-page"]
      [ renderHeadling model
      , renderMenuPageItem hotel
      , renderHotelPageBody model hotel
      ]

renderHeadling : Model -> Html Msg
renderHeadling model = div [class "headling"] (
   case model.appState.currentRoute of
        MenuPage -> 
           [
               renderPageSortOptions model

           ]
        HotelPage hotel ->
           [
               renderBackButton
           ]
   )

renderBackButton : Html Msg
renderBackButton = a [class "back-button", href "#", onClick (RouteChange MenuPage)] [text "◄ До списку готелів"]    

renderPageSortOptions : Model -> Html Msg
renderPageSortOptions model =
   div [class "sort-options"]
     [ label [] [text "Сортувати за"]
     , div [class "variants"]
         (List.map (renderSortOption model) [Popularity, Stars, Price, Depart])
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
             ,  h5 [class "name"] [ text hotel.name ]
             ,  h6 [class "duration"] [ text (getHotelFormattedDuration hotel)]
             ,  h6 [class "depart"] [ text ("Відправлення: " ++ hotel.depart) ]
             ,  h6 [class "price-from"] [text ("Ціна: від $" ++ (toString(getHotelMinPrice hotel)))]
             ]    
         ]
     ]

renderHotelPageBody : Model -> Hotel -> Html Msg
renderHotelPageBody model hotel =
   div [class "hotel-page-body"]
     [ (case hotel.videoUrl of
           Just url -> iframe [width 420, height 315, src url] []
           Nothing -> text ""
       )
     , p [class "description"] [text hotel.description]
     , ul [class "features"] (List.map (\feature -> li [] [text feature]) hotel.features)
     , aside [class "post-description"] [text hotel.postDescription]
     ]
