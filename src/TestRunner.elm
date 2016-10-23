module Main exposing (..)

import ElmTest exposing (..)
import Tests


tests : Test
tests =
    Tests.rules


main : Program Never
main =
    runSuite tests
