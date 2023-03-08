module Logic.App.Patterns.MetaActions exposing (..)

import Array
import Array.Extra as Array
import Components.App.Grid exposing (updateGridPoints)
import Logic.App.Model exposing (Model)
import Logic.App.PatternList.PatternArray exposing (applyColorToPatternFromResult, updateDrawingColors)
import Logic.App.Patterns.PatternRegistry exposing (getPatternFromName)
import Logic.App.Stack.Stack exposing (applyPatternsToStack)
import Logic.App.Types exposing (Iota(..), MetaActionMsg(..))
import Logic.App.Utils.Utils exposing (unshift)


applyMetaAction : Model -> MetaActionMsg -> Model
applyMetaAction model metaActionMsg =
    let
        grid =
            model.grid

        settings =
            model.settings

        castingContext =
            model.castingContext
    in
    case metaActionMsg of
        None ->
            model

        Reset ->
            { model
                | patternArray = Array.empty
                , grid = { grid | points = updateGridPoints grid.width grid.height Array.empty [] settings.gridScale }
                , stack = Array.empty
                , castingContext = { castingContext | heldItemContent = Nothing }
            }

        ClearPatterns ->
            { model
                | patternArray = Array.empty
                , grid = { grid | points = updateGridPoints grid.width grid.height Array.empty [] settings.gridScale }
                , stack = Array.empty
            }

        Undo ->
            let
                newUncoloredPatternArray =
                    Array.removeAt 0 model.patternArray
                        |> Array.removeAt 0

                stackResult =
                    applyPatternsToStack Array.empty castingContext (List.reverse <| Tuple.first <| List.unzip <| Array.toList newUncoloredPatternArray)

                newStack =
                    stackResult.stack

                resultArray =
                    stackResult.resultArray

                newPatternArray =
                    Array.map2
                        (\patternTuple result ->
                            updateDrawingColors ( applyColorToPatternFromResult (Tuple.first patternTuple) result, Tuple.second patternTuple )
                        )
                        newUncoloredPatternArray
                        resultArray
            in
            { model
                | patternArray = newPatternArray
                , grid = { grid | points = updateGridPoints grid.width grid.height newPatternArray [] settings.gridScale }
                , stack = newStack
                , castingContext = stackResult.ctx
            }

        Wrap ->
            let
                newUncoloredPatternArray =
                    model.patternArray
                        |> Array.removeAt 0
                        |> Array.push ( Tuple.first (getPatternFromName "open_paren"), [] )
                        |> unshift ( Tuple.first (getPatternFromName "close_paren"), [] )

                stackResult =
                    applyPatternsToStack Array.empty castingContext (List.reverse <| Tuple.first <| List.unzip <| Array.toList newUncoloredPatternArray)

                newStack =
                    stackResult.stack

                resultArray =
                    stackResult.resultArray

                newPatternArray =
                    Array.map2
                        (\patternTuple result ->
                            updateDrawingColors ( applyColorToPatternFromResult (Tuple.first patternTuple) result, Tuple.second patternTuple )
                        )
                        newUncoloredPatternArray
                        resultArray
            in
            { model
                | patternArray = newPatternArray
                , grid = { grid | points = updateGridPoints grid.width grid.height newPatternArray [] settings.gridScale }
                , stack = newStack
                , castingContext = stackResult.ctx
            }
