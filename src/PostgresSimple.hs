{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

module PostgresSimple where

import           GHC.Generics                   ( Generic )
import           Database.PostgreSQL.Simple
import           Database.PostgreSQL.Simple.FromRow

getConnection =
  connectPostgreSQL "postgres://postgres:secret@localhost:5432/postgres"

data Book = Book {
    userEmail :: String,
    userFirstName :: String,
    userLastName :: String,
    userPassword :: String
} deriving (Show, Generic, FromRow)

postgresSimple :: IO Int
postgresSimple = do
  conn       <- getConnection
  [Only num] <- query_ conn "select 2 + 2"
  print num
  return num

selectItems = do
  conn <- getConnection
  mapM_ print =<< (query_ conn "SELECT * FROM cart_users" :: IO [Book] )
