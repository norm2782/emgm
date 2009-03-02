{-# LANGUAGE TypeOperators          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE OverlappingInstances   #-}
{-# OPTIONS -fno-warn-orphans       #-}

-----------------------------------------------------------------------------
-- |
-- Module      :  Generics.EMGM.Data.Tuple
-- Copyright   :  (c) 2008 Universiteit Utrecht
-- License     :  BSD3
--
-- Maintainer  :  generics@haskell.org
-- Stability   :  experimental
-- Portability :  non-portable
--
-- Summary: Generic representation and instances for tuples of arity 0
-- (''unit'') and 2 to 7.
--
-- The main purpose of this module is to export the instances for the
-- representation dispatchers, 'Rep' and (where appropriate) 'BiFRep2'. For the
-- rare cases in which it is needed, this module also exports the
-- embedding-projection pair and constructor description.
-----------------------------------------------------------------------------

module Generics.EMGM.Data.Tuple (

  -- * Unit: @()@
  epTuple0,
  conTuple0,
  repTuple0,

  -- * Pair: @(a,b)@
  epTuple2,
  conTuple2,
  repTuple2,
  frepTuple2,
  frep2Tuple2,
  frep3Tuple2,
  bifrep2Tuple2,

  -- * Triple: @(a,b,c)@
  epTuple3,
  conTuple3,
  repTuple3,
  frepTuple3,
  frep2Tuple3,
  frep3Tuple3,
  bifrep2Tuple3,

  -- * Quadruple: @(a,b,c,d)@
  epTuple4,
  conTuple4,
  repTuple4,
  frepTuple4,
  frep2Tuple4,
  frep3Tuple4,
  bifrep2Tuple4,

  -- * Quintuple: @(a,b,c,d,e)@
  epTuple5,
  conTuple5,
  repTuple5,
  frepTuple5,
  frep2Tuple5,
  frep3Tuple5,
  bifrep2Tuple5,

  -- * Sextuple: @(a,b,c,d,e,f)@
  epTuple6,
  conTuple6,
  repTuple6,
  frepTuple6,
  frep2Tuple6,
  frep3Tuple6,
  bifrep2Tuple6,

  -- * Septuple: @(a,b,c,d,e,f,h)@
  epTuple7,
  conTuple7,
  repTuple7,
  frepTuple7,
  frep2Tuple7,
  frep3Tuple7,
  bifrep2Tuple7,

) where

import Generics.EMGM.Common
import Generics.EMGM.Functions.Collect
import Generics.EMGM.Functions.Everywhere

-----------------------------------------------------------------------------
-- 0: ()
-----------------------------------------------------------------------------

-- | Embedding-projection pair for @()@
epTuple0 :: EP () Unit
epTuple0 = EP (\() -> Unit)
              (\Unit -> ())

-- | Constructor description for @()@
conTuple0 :: ConDescr
conTuple0 = ConDescr "()" 0 [] Nonfix

-- | Representation for @()@ in 'Generic'
repTuple0 :: (Generic g) => g ()
repTuple0 =
  rtype
    epTuple0 $
    rcon conTuple0 runit

-----------------------------------------------------------------------------
-- 2: (a,b)
-----------------------------------------------------------------------------

-- | Embedding-projection pair for @(a,b)@
epTuple2 :: EP (a,b) (a :*: b)
epTuple2 = EP (\(a,b) -> a :*: b)
              (\(a :*: b) -> (a,b))

-- | Constructor description for @(a,b)@
conTuple2 :: ConDescr
conTuple2 = ConDescr "(,)" 2 [] Nonfix

-- | Representation for @(a,b)@ in 'Generic'
repTuple2 :: (Generic g) => g a -> g b -> g (a,b)
repTuple2 ra rb =
  rtype
    epTuple2 $
    rcon conTuple2 (ra `rprod` rb)

-- | Representation for @(a,b)@ in 'Generic'
frepTuple2 :: (Generic g) => g a -> g b -> g (a,b)
frepTuple2 = repTuple2

-- | Representation for @(,)@ in 'Generic2'
frep2Tuple2 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g (a1,b1) (a2,b2)
frep2Tuple2 ra rb =
  rtype2
    epTuple2 epTuple2 $
    rcon2 conTuple2 (ra `rprod2` rb)

-- | Representation for @(,)@ in 'Generic2'
bifrep2Tuple2 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g (a1,b1) (a2,b2)
bifrep2Tuple2 = frep2Tuple2

-- | Representation for @(,)@ in 'Generic2'
frep3Tuple2 :: (Generic3 g) => g a1 a2 a3 -> g b1 b2 b3 -> g (a1,b1) (a2,b2) (a3,b3)
frep3Tuple2 ra rb =
  rtype3
    epTuple2 epTuple2 epTuple2 $
    rcon3 conTuple2 (ra `rprod3` rb)

-----------------------------------------------------------------------------
-- 3: (a,b,c)
-----------------------------------------------------------------------------

-- | Embedding-projection pair for @(a,b,c)@
epTuple3 :: EP (a,b,c) (a :*: b :*: c)
epTuple3 = EP (\(a,b,c) -> a :*: b :*: c)
              (\(a :*: b :*: c) -> (a,b,c))

-- | Constructor description for @(a,b,c)@
conTuple3 :: ConDescr
conTuple3 = ConDescr "(,,)" 3 [] Nonfix

-- | Representation for @(a,b,c)@ in 'Generic'
repTuple3 :: (Generic g) => g a -> g b -> g c -> g (a,b,c)
repTuple3 ra rb rc =
  rtype
    epTuple3 $
    rcon conTuple3 (ra `rprod` rb `rprod` rc)

-- | Representation for @(a,b,c)@ in 'Generic'
frepTuple3 :: (Generic g) => g a -> g b -> g c -> g (a,b,c)
frepTuple3 = repTuple3

-- | Representation for @(a,b,c)@ in 'Generic'
frep2Tuple3 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g c1 c2 -> g (a1,b1,c1) (a2,b2,c2)
frep2Tuple3 ra rb rc =
  rtype2
    epTuple3 epTuple3 $
    rcon2 conTuple3 (ra `rprod2` rb `rprod2` rc)

-- | Representation for @(a,b,c)@ in 'Generic'
bifrep2Tuple3 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g c1 c2 -> g (a1,b1,c1) (a2,b2,c2)
bifrep2Tuple3 = frep2Tuple3

-- | Representation for @(a,b,c)@ in 'Generic'
frep3Tuple3 :: (Generic3 g) => g a1 a2 a3 -> g b1 b2 b3 -> g c1 c2 c3 -> g (a1,b1,c1) (a2,b2,c2) (a3,b3,c3)
frep3Tuple3 ra rb rc =
  rtype3
    epTuple3 epTuple3 epTuple3 $
    rcon3 conTuple3 (ra `rprod3` rb `rprod3` rc)

-----------------------------------------------------------------------------
-- 4: (a,b,c,d)
-----------------------------------------------------------------------------

-- | Embedding-projection pair for @(a,b,c,d)@
epTuple4 :: EP (a,b,c,d) (a :*: b :*: c :*: d)
epTuple4 = EP (\(a,b,c,d) -> a :*: b :*: c :*: d)
              (\(a :*: b :*: c :*: d) -> (a,b,c,d))

-- | Constructor description for @(a,b,c,d)@
conTuple4 :: ConDescr
conTuple4 = ConDescr "(,,,)" 4 [] Nonfix

-- | Representation for @(a,b,c,d)@ in 'Generic'
repTuple4 :: (Generic g) => g a -> g b -> g c -> g d -> g (a,b,c,d)
repTuple4 ra rb rc rd =
  rtype
    epTuple4 $
    rcon conTuple4 (ra `rprod` rb `rprod` rc `rprod` rd)

-- | Representation for @(a,b,c,d)@ in 'Generic'
frepTuple4 :: (Generic g) => g a -> g b -> g c -> g d -> g (a,b,c,d)
frepTuple4 = repTuple4

-- | Representation for @(a,b,c,d)@ in 'Generic'
frep2Tuple4 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g c1 c2 -> g d1 d2 -> g (a1,b1,c1,d1) (a2,b2,c2,d2)
frep2Tuple4 ra rb rc rd =
  rtype2
    epTuple4 epTuple4 $
    rcon2 conTuple4 (ra `rprod2` rb `rprod2` rc `rprod2` rd)

-- | Representation for @(a,b,c,d)@ in 'Generic'
bifrep2Tuple4 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g c1 c2 -> g d1 d2 -> g (a1,b1,c1,d1) (a2,b2,c2,d2)
bifrep2Tuple4 = frep2Tuple4

-- | Representation for @(a,b,c,d)@ in 'Generic'
frep3Tuple4 :: (Generic3 g) => g a1 a2 a3 -> g b1 b2 b3 -> g c1 c2 c3 -> g d1 d2 d3 -> g (a1,b1,c1,d1) (a2,b2,c2,d2) (a3,b3,c3,d3)
frep3Tuple4 ra rb rc rd =
  rtype3
    epTuple4 epTuple4 epTuple4 $
    rcon3 conTuple4 (ra `rprod3` rb `rprod3` rc `rprod3` rd)

-----------------------------------------------------------------------------
-- 5: (a,b,c,d,e)
-----------------------------------------------------------------------------

-- | Embedding-projection pair for @(a,b,c,d,e)@
epTuple5 :: EP (a,b,c,d,e) (a :*: b :*: c :*: d :*: e)
epTuple5 = EP (\(a,b,c,d,e) -> a :*: b :*: c :*: d :*: e)
              (\(a :*: b :*: c :*: d :*: e) -> (a,b,c,d,e))

-- | Constructor description for @(a,b,c,d,e)@
conTuple5 :: ConDescr
conTuple5 = ConDescr "(,,,,)" 5 [] Nonfix

-- | Representation for @(a,b,c,d,e)@ in 'Generic'
repTuple5 :: (Generic g) => g a -> g b -> g c -> g d -> g e -> g (a,b,c,d,e)
repTuple5 ra rb rc rd re =
  rtype
    epTuple5 $
    rcon conTuple5 (ra `rprod` rb `rprod` rc `rprod` rd `rprod` re)

-- | Representation for @(a,b,c,d,e)@ in 'Generic'
frepTuple5 :: (Generic g) => g a -> g b -> g c -> g d -> g e -> g (a,b,c,d,e)
frepTuple5 = repTuple5

-- | Representation for @(a,b,c,d,e)@ in 'Generic'
frep2Tuple5 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g c1 c2 -> g d1 d2 -> g e1 e2 -> g (a1,b1,c1,d1,e1) (a2,b2,c2,d2,e2)
frep2Tuple5 ra rb rc rd re =
  rtype2
    epTuple5 epTuple5 $
    rcon2 conTuple5 (ra `rprod2` rb `rprod2` rc `rprod2` rd `rprod2` re)

-- | Representation for @(a,b,c,d,e)@ in 'Generic'
bifrep2Tuple5 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g c1 c2 -> g d1 d2 -> g e1 e2 -> g (a1,b1,c1,d1,e1) (a2,b2,c2,d2,e2)
bifrep2Tuple5 = frep2Tuple5

-- | Representation for @(a,b,c,d,e)@ in 'Generic'
frep3Tuple5 :: (Generic3 g) => g a1 a2 a3 -> g b1 b2 b3 -> g c1 c2 c3 -> g d1 d2 d3 -> g e1 e2 e3 -> g (a1,b1,c1,d1,e1) (a2,b2,c2,d2,e2) (a3,b3,c3,d3,e3)
frep3Tuple5 ra rb rc rd re =
  rtype3
    epTuple5 epTuple5 epTuple5 $
    rcon3 conTuple5 (ra `rprod3` rb `rprod3` rc `rprod3` rd `rprod3` re)

-----------------------------------------------------------------------------
-- 6: (a,b,c,d,e,f)
-----------------------------------------------------------------------------

-- | Embedding-projection pair for @(a,b,c,d,e,f)@
epTuple6 :: EP (a,b,c,d,e,f) (a :*: b :*: c :*: d :*: e :*: f)
epTuple6 = EP (\(a,b,c,d,e,f) -> a :*: b :*: c :*: d :*: e :*: f)
              (\(a :*: b :*: c :*: d :*: e :*: f) -> (a,b,c,d,e,f))

-- | Constructor description for @(a,b,c,d,e,f)@
conTuple6 :: ConDescr
conTuple6 = ConDescr "(,,,,,)" 6 [] Nonfix

-- | Representation for @(a,b,c,d,e,f)@ in 'Generic'
repTuple6 :: (Generic g) => g a -> g b -> g c -> g d -> g e -> g f -> g (a,b,c,d,e,f)
repTuple6 ra rb rc rd re rf =
  rtype
    epTuple6 $
    rcon conTuple6 (ra `rprod` rb `rprod` rc `rprod` rd `rprod` re `rprod` rf)

-- | Representation for @(a,b,c,d,e,f)@ in 'Generic'
frepTuple6 :: (Generic g) => g a -> g b -> g c -> g d -> g e -> g f -> g (a,b,c,d,e,f)
frepTuple6 = repTuple6

-- | Representation for @(a,b,c,d,e,f)@ in 'Generic'
frep2Tuple6 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g c1 c2 -> g d1 d2 -> g e1 e2 -> g f1 f2 -> g (a1,b1,c1,d1,e1,f1) (a2,b2,c2,d2,e2,f2)
frep2Tuple6 ra rb rc rd re rf =
  rtype2
    epTuple6 epTuple6 $
    rcon2 conTuple6 (ra `rprod2` rb `rprod2` rc `rprod2` rd `rprod2` re `rprod2` rf)

-- | Representation for @(a,b,c,d,e,f)@ in 'Generic'
bifrep2Tuple6 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g c1 c2 -> g d1 d2 -> g e1 e2 -> g f1 f2 -> g (a1,b1,c1,d1,e1,f1) (a2,b2,c2,d2,e2,f2)
bifrep2Tuple6 = frep2Tuple6

-- | Representation for @(a,b,c,d,e,f)@ in 'Generic'
frep3Tuple6 :: (Generic3 g) => g a1 a2 a3 -> g b1 b2 b3 -> g c1 c2 c3 -> g d1 d2 d3 -> g e1 e2 e3 -> g f1 f2 f3 -> g (a1,b1,c1,d1,e1,f1) (a2,b2,c2,d2,e2,f2) (a3,b3,c3,d3,e3,f3)
frep3Tuple6 ra rb rc rd re rf =
  rtype3
    epTuple6 epTuple6 epTuple6 $
    rcon3 conTuple6 (ra `rprod3` rb `rprod3` rc `rprod3` rd `rprod3` re `rprod3` rf)


-----------------------------------------------------------------------------
-- 7: (a,b,c,d,e,f,h)
-----------------------------------------------------------------------------

-- | Embedding-projection pair for @(a,b,c,d,e,f,h)@
epTuple7 :: EP (a,b,c,d,e,f,h) (a :*: b :*: c :*: d :*: e :*: f :*: h)
epTuple7 = EP (\(a,b,c,d,e,f,h) -> a :*: b :*: c :*: d :*: e :*: f :*: h)
              (\(a :*: b :*: c :*: d :*: e :*: f :*: h) -> (a,b,c,d,e,f,h))

-- | Constructor description for @(a,b,c,d,e,f,h)@
conTuple7 :: ConDescr
conTuple7 = ConDescr "(,,,,,)" 7 [] Nonfix

-- | Representation for @(a,b,c,d,e,f,h)@ in 'Generic'
repTuple7 :: (Generic g) => g a -> g b -> g c -> g d -> g e -> g f -> g h -> g (a,b,c,d,e,f,h)
repTuple7 ra rb rc rd re rf rh =
  rtype
    epTuple7 $
    rcon conTuple7 (ra `rprod` rb `rprod` rc `rprod` rd `rprod` re `rprod` rf `rprod` rh)

-- | Representation for @(a,b,c,d,e,f,h)@ in 'Generic'
frepTuple7 :: (Generic g) => g a -> g b -> g c -> g d -> g e -> g f -> g h -> g (a,b,c,d,e,f,h)
frepTuple7 = repTuple7

-- | Representation for @(a,b,c,d,e,f,h)@ in 'Generic'
frep2Tuple7 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g c1 c2 -> g d1 d2 -> g e1 e2 -> g f1 f2 -> g h1 h2 -> g (a1,b1,c1,d1,e1,f1,h1) (a2,b2,c2,d2,e2,f2,h2)
frep2Tuple7 ra rb rc rd re rf rh =
  rtype2
    epTuple7 epTuple7 $
    rcon2 conTuple7 (ra `rprod2` rb `rprod2` rc `rprod2` rd `rprod2` re `rprod2` rf `rprod2` rh)

-- | Representation for @(a,b,c,d,e,f,h)@ in 'Generic'
bifrep2Tuple7 :: (Generic2 g) => g a1 a2 -> g b1 b2 -> g c1 c2 -> g d1 d2 -> g e1 e2 -> g f1 f2 -> g h1 h2 -> g (a1,b1,c1,d1,e1,f1,h1) (a2,b2,c2,d2,e2,f2,h2)
bifrep2Tuple7 = frep2Tuple7

-- | Representation for @(a,b,c,d,e,f,h)@ in 'Generic'
frep3Tuple7 :: (Generic3 g) => g a1 a2 a3 -> g b1 b2 b3 -> g c1 c2 c3 -> g d1 d2 d3 -> g e1 e2 e3 -> g f1 f2 f3 -> g h1 h2 h3 -> g (a1,b1,c1,d1,e1,f1,h1) (a2,b2,c2,d2,e2,f2,h2) (a3,b3,c3,d3,e3,f3,h3)
frep3Tuple7 ra rb rc rd re rf rh =
  rtype3
    epTuple7 epTuple7 epTuple7 $
    rcon3 conTuple7 (ra `rprod3` rb `rprod3` rc `rprod3` rd `rprod3` re `rprod3` rf `rprod3` rh)

-----------------------------------------------------------------------------
-- Instance declarations
-----------------------------------------------------------------------------

instance (Generic g) => Rep g () where
  rep = repTuple0

instance (Generic g, Rep g a, Rep g b) => Rep g (a,b) where
  rep = repTuple2 rep rep

instance (Generic g, Rep g a, Rep g b, Rep g c) => Rep g (a,b,c) where
  rep = repTuple3 rep rep rep

instance (Generic g, Rep g a, Rep g b, Rep g c, Rep g d) => Rep g (a,b,c,d) where
  rep = repTuple4 rep rep rep rep

instance (Generic g, Rep g a, Rep g b, Rep g c, Rep g d, Rep g e) => Rep g (a,b,c,d,e) where
  rep = repTuple5 rep rep rep rep rep

instance (Generic g, Rep g a, Rep g b, Rep g c, Rep g d, Rep g e, Rep g f) => Rep g (a,b,c,d,e,f) where
  rep = repTuple6 rep rep rep rep rep rep

instance (Generic g, Rep g a, Rep g b, Rep g c, Rep g d, Rep g e, Rep g f, Rep g h) => Rep g (a,b,c,d,e,f,h) where
  rep = repTuple7 rep rep rep rep rep rep rep

instance (Generic2 g) => BiFRep2 g (,) where
  bifrep2 = frep2Tuple2

instance Rep (Collect ()) () where
  rep = Collect (:[])

instance Rep (Collect (a,b)) (a,b) where
  rep = Collect (:[])

instance Rep (Collect (a,b,c)) (a,b,c) where
  rep = Collect (:[])

instance Rep (Collect (a,b,c,d)) (a,b,c,d) where
  rep = Collect (:[])

instance Rep (Collect (a,b,c,d,e)) (a,b,c,d,e) where
  rep = Collect (:[])

instance Rep (Collect (a,b,c,d,e,f)) (a,b,c,d,e,f) where
  rep = Collect (:[])

instance Rep (Collect (a,b,c,d,e,f,h)) (a,b,c,d,e,f,h) where
  rep = Collect (:[])

instance Rep (Everywhere ()) () where
  rep = Everywhere ($)

instance Rep (Everywhere' ()) () where
  rep = Everywhere' ($)

instance Rep (Everywhere (a,b)) (a,b) where
  rep = Everywhere ($)

instance Rep (Everywhere' (a,b)) (a,b) where
  rep = Everywhere' ($)

instance Rep (Everywhere (a,b,c)) (a,b,c) where
  rep = Everywhere ($)

instance Rep (Everywhere' (a,b,c)) (a,b,c) where
  rep = Everywhere' ($)

instance Rep (Everywhere (a,b,c,d)) (a,b,c,d) where
  rep = Everywhere ($)

instance Rep (Everywhere' (a,b,c,d)) (a,b,c,d) where
  rep = Everywhere' ($)

instance Rep (Everywhere (a,b,c,d,e)) (a,b,c,d,e) where
  rep = Everywhere ($)

instance Rep (Everywhere' (a,b,c,d,e)) (a,b,c,d,e) where
  rep = Everywhere' ($)

instance Rep (Everywhere (a,b,c,d,e,f)) (a,b,c,d,e,f) where
  rep = Everywhere ($)

instance Rep (Everywhere' (a,b,c,d,e,f)) (a,b,c,d,e,f) where
  rep = Everywhere' ($)

instance Rep (Everywhere (a,b,c,d,e,f,h)) (a,b,c,d,e,f,h) where
  rep = Everywhere ($)

instance Rep (Everywhere' (a,b,c,d,e,f,h)) (a,b,c,d,e,f,h) where
  rep = Everywhere' ($)

