module ContentLayout exposing (..)

import Html exposing(Html, node, header, div, a, nav, form, text, input, h4, button)
import Html.Attributes exposing(href, class, classList, rel, type', name, placeholder, value, style, src)
import Html.Events exposing (onClick)
import Models exposing (Model, AppState, AppContent, Msg)
import List exposing (append)

import RightBlock exposing(renderRightBlock)
import MainContent exposing(renderMainContent)

renderLayout : (Model -> Html Msg) -> Model -> Html Msg
renderLayout renderContent model =
   div [class "container"]
     (renderMetadata 
     ::renderHeader
     ::(renderRightBlock model)
     ::(renderMainContent model)
     ::(div [class "kek2"] [])
     ::[])
 
renderMetadata : Html Msg
renderMetadata =
   div [] 
   [ node "link" [rel "stylesheet/less", href "less/style.less"] []
   , node "script" [src "https://cdnjs.cloudflare.com/ajax/libs/less.js/2.7.1/less.min.js"] []
   ]

renderHeader : Html Msg
renderHeader =
   header [] [
     div [class "logo"] []        
   ]
