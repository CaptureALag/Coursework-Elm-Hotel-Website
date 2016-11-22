module RightBlock exposing (renderRightBlock, renderTopMostNavIcons)

import Html exposing(..)
import Html.Attributes exposing(href, class, classList, rel, type', name, placeholder, value, style, src)
import Html.Events exposing (onClick, onInput)
import Models exposing (..)
import ModelUtils exposing(getHotelsOnCurrentPage)
import List exposing (append)
   
renderRightBlock : Model -> Html Msg
renderRightBlock model =
   div [class "right-block"] 
      [ renderRightBlockNavigation model.appState model.appContent
      , renderRightBlockCallback model.appState
      , renderRightBlockReviews model.appState
      , renderBlog model
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
      ((h4 [] [text "Замовлення дзвінка"]) ::
      (if appState.formSubmitted then
        [ h5 [class "success-msg"] [text ("Ви замовили дзвінок на телефон " ++ appState.formPhone)]
        , h5 [class "success-msg"] [text "Ми зателефонуємо протягом 5 хвилин"]
        ]
        else 
        [ input [type' "text", name "name", placeholder "Ім'я"] []
        , input [type' "text", name "phone", placeholder "Телефон", onInput FormPhoneChange] []
        , input [type' "text", name "comment", placeholder "Коментар"] []
        , button [type' "button", onClick FormSubmit] [text "OK"]
        , div [class "fail-msg"] [text appState.formFailureMessage]
        ]
      ))

renderRightBlockReviews : AppState -> Html Msg
renderRightBlockReviews appState =
   div [classList[("reviews", True), ("hidden", appState.selectedNavIcon /= "icon-reviews")]]  
      [
             text "Тут будуть відгуки" 
      ]

renderBlog : Model -> Html Msg
renderBlog model =
   div [class "blog"]
      (List.map (\entry -> 
           div [class "entry"] 
             [ div [class "time"] [text entry.timePosted]
             , div [class "preview"] [text entry.header]
             , a [href "#", class "read-more"] [text "Читати далі"]         
             ]     
         ) model.appContent.blog
      )
