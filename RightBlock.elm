module RightBlock exposing (renderRightBlock)

import Html exposing(Html, node, header, div, a, nav, form, text, input, h4, button)
import Html.Attributes exposing(href, class, classList, rel, type', name, placeholder, value, style, src)
import Html.Events exposing (onClick)
import Models exposing (..)
import ModelUtils exposing(getHotelsOnCurrentPage)
import List exposing (append)
   
renderRightBlock : Model -> Html Msg
renderRightBlock model =
   div [class "right-block"] 
      [ renderTopMostNavIcons model.appState
      , renderRightBlockNavigation model.appState model.appContent
      , renderRightBlockCallback model.appState
      , renderRightBlockReviews model.appState
      ] 

renderTopMostNavIcons : AppState -> Html Msg
renderTopMostNavIcons appState =
   div [class "nav-icons"]
     (List.map 
       (\cls -> 
          a [ href "#"
            , style [("background-image", "url(img/"++cls++".png)")]
            , classList [("nav-icon", True), (cls, True), ("selected", appState.selectedNavIcon == cls)]
            , onClick (Models.NavIconClick cls) 
            ] [])
       [ "icon-navigation"
       , "icon-callback"
       , "icon-reviews"   
       ]
     )

renderRightBlockNavigation : AppState -> AppContent -> Html Msg
renderRightBlockNavigation appState appContent = nav [classList[("hidden", appState.selectedNavIcon /= "icon-navigation")]]
   ( 
     (a [class "link-country", onClick (SetFilterByCountry Nothing), classList [("selected", appState.currentFilterByCountry == Nothing)]][text "Всі тури"])::
       ( List.map (\cntry -> 
          a 
            [ class "link-country", 
              onClick (SetFilterByCountry (Just cntry)),
              classList [("selected", (Just cntry) == appState.currentFilterByCountry)]
            ] [text ("Тури на " ++ cntry.nameLocativeCase)]
        ) appContent.countries      
       )
   )

renderRightBlockCallback : AppState -> Html Msg
renderRightBlockCallback appState = 
   form [classList[("callback-form", True),("hidden", appState.selectedNavIcon /= "icon-callback")]]
      [ h4 [] [text "Замовлення дзвінка"]
      , input [type' "text", name "name", placeholder "Ім'я"] []
      , input [type' "text", name "phone", placeholder "Телефон"] []
      , input [type' "text", name "comment", placeholder "Коментар"] []
      , button [type' "button"] [text "OK"]
      ]

renderRightBlockReviews : AppState -> Html Msg
renderRightBlockReviews appState =
   div [classList[("reviews", True), ("hidden", appState.selectedNavIcon /= "icon-reviews")]]  
      [
             text "Тут будуть відгуки" 
      ]
