module Test.Main where

import Prelude (Unit, ($), (==), discard, (<$>), mod)

import Data.Integer

import Data.Maybe (Maybe (..))
import Data.Monoid (power)
import Data.Monoid.Multiplicative (Multiplicative (..))
import Data.Traversable (sequence)
import Effect (Effect)
import Test.Assert (assert')

main :: Effect Unit
main = do
  assert' "Integer construction" $ 
    Just (power (Multiplicative $ fromInt 2) 123) == 
      sequence (
        Multiplicative (
          fromStringAs decimal "10633823966279326983230456482242756608"))
  assert' "Integer stringification" $ 
    (toStringAs binary <$> fromStringAs binary "0011100") ==
      Just "11100"
  assert' "Integer arithmetics" $
    (fromInt 654 `mod` fromInt 321) == fromInt 12
