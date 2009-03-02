{-# LANGUAGE TypeOperators              #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverlappingInstances       #-}

--------------------------------------------------------------------------------
-- |
-- Module      :  Generics.EMGM.Functions.Everywhere
-- Copyright   :  (c) 2008 Universiteit Utrecht
-- License     :  BSD3
--
-- Maintainer  :  generics@haskell.org
-- Stability   :  experimental
-- Portability :  non-portable
--
-- Summary: Generic functions that apply a transformation at every location of
-- one type in a value of a possibly different type.
--------------------------------------------------------------------------------

module Generics.EMGM.Functions.Everywhere (
  Everywhere(..),
  everywhere,
  Everywhere'(..),
  everywhere',
) where

import Generics.EMGM.Common.Base
import Generics.EMGM.Common.Representation

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

-- | The type of a generic function that takes a function of one type, a value
-- of another type, and returns a value of the value type.
--
-- For datatypes to work with Everywhere, a special instance must be given. This
-- instance is trivial to write. For a non-recursive type, the instance is the
-- same as described for 'Everywhere\''. For a recursive type @T@, the 'Rep'
-- instance looks like this:
--
-- >   {-# LANGUAGE OverlappingInstances #-}
--
-- @
--   data T a = Val a | Rec T
-- @
--
-- @
--   instance 'Rep' (Everywhere T) T where
--     'rep' = Everywhere app
--       where
--         app f (Rec t) = f (Rec (selEverywhere 'rep' f t))
--         app f other   = f other
-- @
--
-- (Note the requirement of overlapping instances.) This instance is triggered
-- when the function type (the first @T@) matches some value type (the second
-- @T@) contained within the argument to 'everywhere'.
newtype Everywhere a b = Everywhere { selEverywhere :: (a -> a) -> b -> b }

--------------------------------------------------------------------------------
-- Generic instance declaration
--------------------------------------------------------------------------------

rconstantEverywhere :: (a -> a) -> b -> b
rconstantEverywhere _ = id

rsumEverywhere :: Everywhere a b1 -> Everywhere a b2 -> (a -> a) -> (b1 :+: b2) -> b1 :+: b2
rsumEverywhere ra _  f (L a) = L (selEverywhere ra f a)
rsumEverywhere _  rb f (R b) = R (selEverywhere rb f b)

rprodEverywhere :: Everywhere a b1 -> Everywhere a b2 -> (a -> a) -> (b1 :*: b2) -> b1 :*: b2
rprodEverywhere ra rb f (a :*: b) = selEverywhere ra f a :*: selEverywhere rb f b

rtypeEverywhere :: EP d b -> Everywhere a b -> (a -> a) -> d -> d
rtypeEverywhere ep ra f = to ep . selEverywhere ra f . from ep

instance Generic (Everywhere a) where
  rconstant      = Everywhere rconstantEverywhere
  rsum     ra rb = Everywhere (rsumEverywhere ra rb)
  rprod    ra rb = Everywhere (rprodEverywhere ra rb)
  rtype ep ra    = Everywhere (rtypeEverywhere ep ra)

--------------------------------------------------------------------------------
-- Rep instance declarations
--------------------------------------------------------------------------------

instance Rep (Everywhere Int) Int where
  rep = Everywhere ($)

instance Rep (Everywhere Integer) Integer where
  rep = Everywhere ($)

instance Rep (Everywhere Double) Double where
  rep = Everywhere ($)

instance Rep (Everywhere Float) Float where
  rep = Everywhere ($)

instance Rep (Everywhere Char) Char where
  rep = Everywhere ($)

--------------------------------------------------------------------------------
-- Exported functions
--------------------------------------------------------------------------------

-- | Apply a transformation @a -> a@ to values of type @a@ within the argument
-- of type @b@ in a bottom-up manner. Values that dhave type match @a@ are
-- passed through 'id'.
--
-- @everywhere@ works by searching the datatype @b@ for values that are the same
-- type as the function argument type @a@. Here are some examples using the
-- datatype declared in the documentation for 'Everywhere'. 

--
-- @
--   ghci> let f t = case t of { Val i -> Val (i+(1::'Int')); other -> other }
--   ghci> everywhere f (Val (1::'Int'))
--   Val 2
--   ghci> everywhere f (Rec (Rec (Val (1::'Int'))))
--   Rec (Rec (Val 2))
-- @
--
-- @
--   ghci> let x = ['Left' 1, 'Right' \'a\', 'Left' 2] :: ['Either' 'Int' 'Char']
--   ghci> everywhere (*(3::'Int')) x
--   ['Left' 3,'Right' \'a\','Left' 6]
--   ghci> everywhere (\\x -> x :: 'Float') x == x
--   'True'
-- @
--
-- Note the type annotations. Since numerical constants have the type @'Num' a
-- => a@, you may need to give explicit types. Also, the function @\x -> x@ has
-- type @a -> a@, but we need to give it some non-polymorphic type here. By
-- design, there is no connection that can be inferred between the value type
-- and the function type.
--
-- @everywhere@ only works if there is an instance for the return type as
-- described in the @newtype 'Everywhere'@.
everywhere :: (Rep (Everywhere a) b) => (a -> a) -> b -> b
everywhere f = selEverywhere rep f


--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

-- | This type servers the same purpose as 'Everywhere', except that 'Rep'
-- instances are designed to be top-down instead of bottom-up. That means, given
-- any type @U@ (recursive or not), the 'Rep' instance looks like this:
--
-- >   {-# LANGUAGE OverlappingInstances #-}
--
-- @
--   data U = ...
-- @
--
-- @
--   instance 'Rep' (Everywhere' U) U where
--     'rep' = Everywhere' ($)
-- @
newtype Everywhere' a b = Everywhere' { selEverywhere' :: (a -> a) -> b -> b }

--------------------------------------------------------------------------------
-- Generic instance declaration
--------------------------------------------------------------------------------

rconstantEverywhere' :: (a -> a) -> b -> b
rconstantEverywhere' _ = id

rsumEverywhere' :: Everywhere' a b1 -> Everywhere' a b2 -> (a -> a) -> (b1 :+: b2) -> b1 :+: b2
rsumEverywhere' ra _  f (L a) = L (selEverywhere' ra f a)
rsumEverywhere' _  rb f (R b) = R (selEverywhere' rb f b)

rprodEverywhere' :: Everywhere' a b1 -> Everywhere' a b2 -> (a -> a) -> (b1 :*: b2) -> b1 :*: b2
rprodEverywhere' ra rb f (a :*: b) = selEverywhere' ra f a :*: selEverywhere' rb f b

rtypeEverywhere' :: EP d b -> Everywhere' a b -> (a -> a) -> d -> d
rtypeEverywhere' ep ra f = to ep . selEverywhere' ra f . from ep

instance Generic (Everywhere' a) where
  rconstant      = Everywhere' rconstantEverywhere'
  rsum     ra rb = Everywhere' (rsumEverywhere' ra rb)
  rprod    ra rb = Everywhere' (rprodEverywhere' ra rb)
  rtype ep ra    = Everywhere' (rtypeEverywhere' ep ra)

--------------------------------------------------------------------------------
-- Rep instance declarations
--------------------------------------------------------------------------------

instance Rep (Everywhere' Int) Int where
  rep = Everywhere' ($)

instance Rep (Everywhere' Integer) Integer where
  rep = Everywhere' ($)

instance Rep (Everywhere' Double) Double where
  rep = Everywhere' ($)

instance Rep (Everywhere' Float) Float where
  rep = Everywhere' ($)

instance Rep (Everywhere' Char) Char where
  rep = Everywhere' ($)

--------------------------------------------------------------------------------
-- Exported functions
--------------------------------------------------------------------------------

-- | Apply a transformation @a -> a@ to values of type @a@ within the argument
-- of type @b@ in a top-down manner. Values that do not have type @a@ are passed
-- through 'id'.
--
-- @everywhere'@ is the same as 'everywhere' with the exception of recursive
-- datatypes. For example, here is the same example used in the documentation
-- for 'everywhere'.
--
-- @
--   ghci> let f t = case t of { Val i -> Val (i+(1::'Int')); other -> other }
--   ghci> everywhere' f (Val (1::'Int'))
--   Val 2
--   ghci> everywhere' f (Rec (Rec (Val (1::'Int'))))
--   Rec (Rec (Val 1))
-- @
--
-- @everywhere'@ only works if there is an instance for the return type as
-- described in the @newtype 'Everywhere''@.
everywhere' :: (Rep (Everywhere' a) b) => (a -> a) -> b -> b
everywhere' f = selEverywhere' rep f
