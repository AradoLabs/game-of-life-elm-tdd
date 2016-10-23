module Tests exposing (..)

import ElmTest exposing (..)
import GameOfLife exposing (..)


rules : Test
rules =
    suite "Game of Life Test Suite"
        [ test "test cell at position is alive"
            (assertEqual True
                (cellIsAlive ( 2, 2 ) [ ( 2, 2 ) ])
            )
        , test "test cell at position is dead"
            (assertEqual False
                (cellIsAlive ( 2, 2 ) [ ( 3, 3 ) ])
            )
        , test "cell with 2 neighbors should count 2"
            (assertEqual 2
                (countOfAliveNeighbors ( 2, 2 ) [ ( 1, 2 ), ( 2, 2 ), ( 2, 3 ) ])
            )
        , test "cell with 3 neighbours should count 3"
            (assertEqual 3
                (countOfAliveNeighbors ( 2, 2 ) [ ( 1, 2 ), ( 2, 2 ), ( 2, 3 ), ( 3, 2 ) ])
            )
        , test "cell with 3 neighbours should count 3"
            (assertEqual [ ( 1, 1 ), ( 2, 1 ), ( 3, 1 ), ( 3, 2 ), ( 3, 3 ), ( 2, 3 ), ( 1, 3 ), ( 1, 2 ) ]
                (neighboursForCell ( 2, 2 ))
            )
        , test "a live cell having 3 neighbors lives"
            (assertEqual True
                (cellIsAlive ( 1, 1 ) (tick [ ( 1, 0 ), ( 1, 1 ), ( 1, 2 ), ( 1, 2 ) ]))
            )
        , test "a live cell having 2 neighbors lives"
            (assertEqual True
                (cellIsAlive ( 1, 1 ) (tick [ ( 1, 0 ), ( 1, 1 ), ( 1, 2 ) ]))
            )
        , test "a live cell having 0 neighbors dies"
            (assertEqual []
                (tick [ ( 1, 1 ) ])
            )
        , test "cells having 1 neighbor die"
            (assertEqual []
                (tick [ ( 1, 1 ), ( 2, 1 ) ])
            )
        , test "a live cell having more 3 live neighbors dies"
            (assertEqual False
                (cellIsAlive ( 1, 1 ) (tick [ ( 0, 1 ), ( 1, 1 ), ( 2, 1 ), ( 1, 2 ), ( 2, 2 ) ]))
            )
        , test "a dead cell having 3 neighbors becomes alive"
            (assertEqual True
                (cellIsAlive ( 1, 1 ) (tick [ ( 0, 1 ), ( 2, 1 ), ( 1, 2 ) ]))
            )
        ]
