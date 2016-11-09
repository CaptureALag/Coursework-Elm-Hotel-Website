module ContentLayout exposing (..)

import Html exposing(..)
import Html.Attributes exposing(href, class, classList, rel, type', name, placeholder, value, style, src)
import Html.Events exposing (onClick)
import Models exposing (..)
import List exposing (append)

import MainContent exposing(renderMainContent)
import RightBlock exposing(renderTopMostNavIcons)

renderLayout : (Model -> Html Msg) -> Model -> Html Msg
renderLayout renderContent model =
   div [class "container"]
     (renderMetadata 
     ::(renderHeader model)
     ::(renderMainContent model)
     ::renderFooter
     ::[])
 
renderMetadata : Html Msg
renderMetadata =
   div [] 
   [ node "link" [rel "stylesheet/less", href "less/style.less"] []
   , node "link" [rel "stylesheet", href "https://fonts.googleapis.com/css?family=Amatica+SC:400,700|Cairo:200,300,400,600,700,900|Oranienbaum|Rubik:300,300i,400,400i,500,500i,700,700i,900,900i&amp;subset=cyrillic"] []
   , node "script" [src "https://cdnjs.cloudflare.com/ajax/libs/less.js/2.7.1/less.min.js"] []
   ]

renderHeader : Model -> Html Msg
renderHeader model =
   header [] [
     div [class "logo", onClick LogoClick] []        
   , renderTopMostNavIcons model.appState
   ]

renderFooter : Html Msg
renderFooter =
   footer [] [ h5 [] [ text "Зв'яжіться з нами:" ]      
   , div [class "numbers-container"] 
       [ span [] [text "+38 (044) 123 45 67"]
       , span [] [text "+38 (044) 123 45 68"] 
       , span [] [text "+38 (044) 123 45 69"] 
       , span [] [text "+38 (044) 123 45 70"] 
       ]
   , div [class "copyright"] [text "Returnal Inc. © All rights reserved"]
   ]
