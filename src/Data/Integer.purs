module Data.Integer where

import Prelude

import Data.Maybe (Maybe (..))

foreign import data Integer :: Type

foreign import fromInt :: Int -> Integer
foreign import inferior :: Integer -> Integer -> Boolean
foreign import superior :: Integer -> Integer -> Boolean
foreign import eqImpl :: Integer -> Integer -> Boolean
foreign import addImpl :: Integer -> Integer -> Integer
foreign import mulImpl :: Integer -> Integer -> Integer
foreign import subImpl :: Integer -> Integer -> Integer
foreign import divImpl :: Integer -> Integer -> Integer
foreign import modImpl :: Integer -> Integer -> Integer
foreign import degreeImpl :: Integer -> Int
foreign import showImpl :: Integer -> String

foreign import fromStringAsImpl
  :: (forall a. a -> Maybe a)
  -> (forall a. Maybe a)
  -> Radix
  -> String
  -> Maybe Integer

foreign import toStringAs :: Radix -> Integer -> String

-- | The number of unique digits (including zero) used to represent integers in
-- | a specific base.
newtype Radix = Radix Int

-- | The base-2 system.
binary :: Radix
binary = Radix 2

-- | The base-10 system.
decimal :: Radix
decimal = Radix 10

-- | The base-16 system.
hexadecimal :: Radix
hexadecimal = Radix 16

-- | Create a `Radix` from a number between 2 and 36.
radix :: Int -> Maybe Radix
radix n | n >= 2 && n <= 36 = Just (Radix n)
        | otherwise         = Nothing

fromStringAs :: Radix -> String -> Maybe Integer
fromStringAs = fromStringAsImpl Just Nothing

instance Ord Integer where
    compare n m
        | n `inferior` m = LT
        | n `superior` m = GT
        | otherwise = EQ

instance Eq Integer where
    eq = eqImpl

instance EuclideanRing Integer where
    div = divImpl
    mod = modImpl
    degree = degreeImpl

instance Semiring Integer where
    add = addImpl
    mul = mulImpl
    one = fromInt 1
    zero = fromInt 0
    
instance Ring Integer where
    sub = subImpl

instance CommutativeRing Integer

instance Show Integer where
    show = showImpl
