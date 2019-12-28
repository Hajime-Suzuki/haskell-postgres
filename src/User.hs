{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

module User where

import           GHC.Generics                   ( Generic )
import           Database.PostgreSQL.Simple
import           Data.Time.LocalTime


data User = User {
  id :: Int,
  firstName :: String,
  lastName :: String,
  nationality :: Maybe String,
  createdAt :: LocalTime
} deriving (Show, Generic, FromRow, ToRow)
