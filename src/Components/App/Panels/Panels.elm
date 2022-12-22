module Components.App.Panels.Panels exposing (panels)

import Components.App.Panels.PatternPanel exposing (patternPanel)
import Components.App.Panels.StackPanel exposing (stackPanel)

import Html exposing (..)
import Html.Attributes exposing (class, id)


panels : model -> Html msg
panels model =
    div [ id "panels" ]
        [ patternPanel model 
        , stackPanel model
        ]
