{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

module User where

import           GHC.Generics                   ( Generic )
import           Database.PostgreSQL.Simple

data User = User {
  id :: Int,
  firstName :: String,
  lastName :: String,
  nationality :: Maybe String
} deriving (Show, Generic, FromRow, ToRow)
