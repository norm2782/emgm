{-# LANGUAGE CPP                    #-}
{-# LANGUAGE TemplateHaskell        #-}
{-# LANGUAGE TypeOperators          #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FlexibleContexts       #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE OverlappingInstances   #-}
{-# LANGUAGE UndecidableInstances   #-}
{-# OPTIONS -fno-warn-orphans       #-}
{-  OPTIONS -ddump-splices           -}

-----------------------------------------------------------------------------
-- |
-- Module      :  Generics.EMGM.Data.TH
-- Copyright   :  (c) 2008 Universiteit Utrecht
-- License     :  BSD3
--
-- Maintainer  :  generics@haskell.org
-- Stability   :  experimental
-- Portability :  non-portable
--
-- Summary: Generic representation and instances for Template Haskell types.
--
-- The main purpose of this module is to export the instances for the
-- representation dispatcher 'Rep'. For the rare cases in which it is needed,
-- this module also exports the embedding-projection pair and constructor
-- description.
--
-- /NOTE/: The exported values are not explicitly documented, because there is a
-- large number and they are all generated with Template Haskell expressions.
-- For a detailed look, use the @:browse@ command in GHCi.
-----------------------------------------------------------------------------

module Generics.EMGM.Data.TH where

import Generics.EMGM.Common hiding (Fixity, ConDescr(..))
import Language.Haskell.TH

#ifndef __HADDOCK__

$(deriveAllRep ''Name)
$(deriveAllRep ''Dec)
$(deriveAllRep ''Exp)
$(deriveAllRep ''Con)
$(deriveAllRep ''Type)
$(deriveAllRep ''Match)
$(deriveAllRep ''Clause)
$(deriveAllRep ''Body)
$(deriveAllRep ''Guard)
$(deriveAllRep ''Stmt)
$(deriveAllRep ''Range)
$(deriveAllRep ''Lit)
$(deriveAllRep ''Pat)
$(deriveAllRep ''Strict)
$(deriveAllRep ''Foreign)
$(deriveAllRep ''Callconv)
$(deriveAllRep ''Safety)
$(deriveAllRep ''FunDep)
$(deriveAllRep ''Info)

#ifdef TH_LOC_DERIVEREP
-- This type is only provided in template-haskell-2.3 (included with GHC 6.10)
-- and up.
$(deriveAllRep ''Loc)
#endif

$(deriveAllRep ''Fixity)
$(deriveAllRep ''FixityDirection)

#endif

