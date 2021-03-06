{-# LANGUAGE FlexibleContexts #-}

-----------------------------------------------------------------------------
-- |
-- Module      :  Enum
-- Copyright   :  (c) 2008, 2009 Universiteit Utrecht
-- License     :  BSD3
--
-- Maintainer  :  generics@haskell.org
-----------------------------------------------------------------------------

module Enum (tests) where

import Prelude hiding (Show, Enum)
import qualified Prelude as P (Show)
import Data.Generics (Data)
import Test.HUnit

import Base
import Generics.EMGM
import Generics.EMGM.Functions.Enum

-----------------------------------------------------------------------------
-- Utility functions
-----------------------------------------------------------------------------

n100 :: Num a => [a]
n100 =
  [0,-1,1,-2,2,-3,3,-4,4,-5,5,-6,6,-7,7,-8,8,-9,9,-10,10,-11,11,-12,12
  ,-13,13,-14,14,-15,15,-16,16,-17,17,-18,18,-19,19,-20,20,-21,21,-22
  ,22,-23,23,-24,24,-25,25,-26,26,-27,27,-28,28,-29,29,-30,30,-31,31,-32
  ,32,-33,33,-34,34,-35,35,-36,36,-37,37,-38,38,-39,39,-40,40,-41,41,-42
  ,42,-43,43,-44,44,-45,45,-46,46,-47,47,-48,48,-49,49,-50
  ]

test_num_100 :: (Data a, Rep Enum a, Eq a, P.Show a) => [a] -> Test
test_num_100 ns = "enum :: " ++ typeNameOf ns ~: enumN (100::Int) ~?= ns

l50 :: [[Int]]
l50 =
  [[],[0],[0,0],[-1],[0,0,0],[-1,0],[1],[0,-1],[-1,0,0],[1,0],[-2]
  ,[0,0,0,0],[-1,-1],[1,0,0],[-2,0],[2],[0,-1,0],[-1,0,0,0],[1,-1]
  ,[-2,0,0],[2,0],[-3],[0,1],[-1,-1,0],[1,0,0,0],[-2,-1],[2,0,0],[-3,0]
  ,[3],[0,0,-1],[-1,1],[1,-1,0],[-2,0,0,0],[2,-1],[-3,0,0],[3,0],[-4]
  ,[0,-1,0,0],[-1,0,-1],[1,1],[-2,-1,0],[2,0,0,0],[-3,-1],[3,0,0],[-4,0]
  ,[4],[0,1,0],[-1,-1,0,0],[1,0,-1],[-2,1]
  ]

test_empty x = "empty :: " ++ typeNameOf x ~: empty ~?= x

-----------------------------------------------------------------------------
-- Test functions
-----------------------------------------------------------------------------

test_length_char = "enum :: [Char]" ~: length (enum :: [Char]) ~?= 1114112

test_int_100 = test_num_100 (n100 :: [Int])
test_integer_100 = test_num_100 (n100 :: [Integer])
test_float_100 = test_num_100 (n100 :: [Float])
test_double_100 = test_num_100 (n100 :: [Double])

test_list_50 = "enum :: [[Int]]" ~: enumN (50::Int) ~?= l50

-----------------------------------------------------------------------------
-- Test collection
-----------------------------------------------------------------------------

tests = "Enum" ~:
          [ test_length_char
          , test_int_100
          , test_integer_100
          , test_float_100
          , test_double_100
          , test_list_50
          , test_empty ([] :: [Char])
          , test_empty '\NUL'
          , test_empty (Nothing :: Maybe [Double])
          , test_empty ((0,0,0,0) :: (Int,Integer,Float,Double))
          ]

