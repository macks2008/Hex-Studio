module Logic.App.Patterns.ReadWrite exposing (..)

import Array exposing (Array)
import Logic.App.Patterns.OperatorUtils exposing (action1Input, actionNoInput, getAny)
import Logic.App.Types exposing (ActionResult, CastingContext, EntityType(..), HeldItem(..), Iota(..), Mishap(..))


read : Array Iota -> CastingContext -> ActionResult
read stack ctx =
    let
        action context =
            ( case context.heldItem of
                NoItem ->
                    Array.empty

                Trinket ->
                    Array.empty

                Cypher ->
                    Array.empty

                Artifact ->
                    Array.empty

                Focus ->
                    Array.fromList [ Maybe.withDefault Null context.heldItemContent ]

                Spellbook ->
                    Array.fromList [ Maybe.withDefault Null context.heldItemContent ]

                Pie ->
                    Array.fromList [ Number pi ]
            , context
            )
    in
    actionNoInput stack ctx action


write : Array Iota -> CastingContext -> ActionResult
write stack ctx =
    let
        action iota context =
            case context.heldItem of
                NoItem ->
                    ( Array.fromList [ iota ], context )

                Trinket ->
                    ( Array.fromList [ iota ], context )

                Cypher ->
                    ( Array.fromList [ iota ], context )

                Artifact ->
                    ( Array.fromList [ iota ], context )

                Focus ->
                    ( Array.empty, { context | heldItemContent = Just iota } )

                Spellbook ->
                    ( Array.empty, { context | heldItemContent = Just iota } )

                Pie ->
                    ( Array.fromList [ iota ], context )
    in
    action1Input stack ctx getAny action


readable : Array Iota -> CastingContext -> ActionResult
readable stack ctx =
    let
        action context =
            case context.heldItem of
                NoItem ->
                    ( Array.repeat 1 (Boolean False), context )

                Trinket ->
                    ( Array.repeat 1 (Boolean False), context )

                Cypher ->
                    ( Array.repeat 1 (Boolean False), context )

                Artifact ->
                    ( Array.repeat 1 (Boolean False), context )

                Focus ->
                    ( Array.repeat 1 (Boolean True), context )

                Spellbook ->
                    ( Array.repeat 1 (Boolean True), context )

                Pie ->
                    ( Array.repeat 1 (Boolean True), context )
    in
    actionNoInput stack ctx action


writable : Array Iota -> CastingContext -> ActionResult
writable stack ctx =
    let
        action context =
            case context.heldItem of
                NoItem ->
                    ( Array.repeat 1 (Boolean False), context )

                Trinket ->
                    ( Array.repeat 1 (Boolean False), context )

                Cypher ->
                    ( Array.repeat 1 (Boolean False), context )

                Artifact ->
                    ( Array.repeat 1 (Boolean False), context )

                Focus ->
                    ( Array.repeat 1 (Boolean True), context )

                Spellbook ->
                    ( Array.repeat 1 (Boolean True), context )

                Pie ->
                    ( Array.repeat 1 (Boolean False), context )
    in
    actionNoInput stack ctx action