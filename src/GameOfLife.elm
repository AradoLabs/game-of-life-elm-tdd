module GameOfLife exposing (..)

import List.Extra


type alias Cell =
    ( Int, Int )


cellIsAlive : Cell -> List Cell -> Bool
cellIsAlive cell cells =
    List.member cell cells


cellShouldNotDie : Cell -> List Cell -> Bool
cellShouldNotDie cell cells =
    case (countOfAliveNeighbors cell cells) of
        2 ->
            True

        _ ->
            False


cellShouldBecomeAlive : Cell -> List Cell -> Bool
cellShouldBecomeAlive cell aliveCells =
    case (countOfAliveNeighbors cell aliveCells) of
        3 ->
            True

        _ ->
            False


cellsThatShouldStayAlive : List Cell -> List Cell
cellsThatShouldStayAlive aliveCells =
    List.filter (\c -> cellShouldNotDie c aliveCells) aliveCells


cellsThatShouldBecomeAlive : List Cell -> List Cell
cellsThatShouldBecomeAlive aliveCells =
    List.filter
        (\c -> cellShouldBecomeAlive c aliveCells)
        (potentialNeighbors aliveCells)


potentialNeighbors : List Cell -> List Cell
potentialNeighbors aliveCells =
    List.Extra.unique
        (List.concatMap neighboursForCell aliveCells)


neighboursForCell : Cell -> List Cell
neighboursForCell cell =
    case cell of
        ( x, y ) ->
            [ ( x - 1, y - 1 )
            , ( x, y - 1 )
            , ( x + 1, y - 1 )
            , ( x + 1, y )
            , ( x + 1, y + 1 )
            , ( x, y + 1 )
            , ( x - 1, y + 1 )
            , ( x - 1, y )
            ]


countOfAliveNeighbors : Cell -> List Cell -> Int
countOfAliveNeighbors cell aliveCells =
    List.length
        (List.filter
            (\c -> List.member c aliveCells)
            (neighboursForCell cell)
        )


tick : List Cell -> List Cell
tick aliveCells =
    List.Extra.unique
        (List.append
            (cellsThatShouldStayAlive aliveCells)
            (cellsThatShouldBecomeAlive aliveCells)
        )
