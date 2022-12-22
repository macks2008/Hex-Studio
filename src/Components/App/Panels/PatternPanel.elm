module Components.App.Panels.PatternPanel exposing (patternPanel)

import Components.Icon.ParagraphDropdown exposing (paragraphDropdown)
import FontAwesome as Icon exposing (Icon)
import FontAwesome.Attributes as Icon
import FontAwesome.Brands as Icon
import FontAwesome.Layering as Icon
import FontAwesome.Solid as Icon
import FontAwesome.Styles as Icon
import Html exposing (..)
import Html.Attributes exposing (attribute, class, id, placeholder)


patternPanel : model -> Html msg
patternPanel model =
    div [ id "pattern_panel", class "panel" ]
        [ h1
            [ class "panel_title"
            ]
            [ text "Pattern Order ∨" ]
        , div
            [ id "pattern_draggable_container"
            ]
            []
        , div
            [ id "add_pattern"
            , class "outer_box"
            ]
            [ div
                [ class "inner_box"
                ]
                [ paragraphDropdown
                , input
                    [ id "add_pattern_input"
                    , placeholder "Add a pattern"
                    , attribute "autocomplete" "off"
                    ]
                    []
                , div
                    [ id "add_pattern_button"
                    , class "add_button"
                    ]
                    [ Icon.css
                    , Icon.plus |> Icon.styled [ Icon.sm ] |> Icon.view
                    ]
                ]
            ]
        ]
