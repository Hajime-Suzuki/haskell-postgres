{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

module PostgresSimple where

import           GHC.Generics                   ( Generic )
import           Database.PostgreSQL.Simple
import           Database.PostgreSQL.Simple.FromRow
import           System.Environment             ( lookupEnv )
import           LoadEnv                        ( loadEnvFrom )
import           Data.ByteString.UTF8          as BU
import           DB                             ( getConnection )


data User = User {
    email :: String,
    firstName :: String,
    lastName :: String,
    password :: String
} deriving (Show, Generic, FromRow)

postgresSimple :: IO Int
postgresSimple = do
  conn       <- getConnection
  [Only num] <- query_ conn "select 2 + 2"
  print num
  return num

selectItems = do
  conn <- getConnection
  mapM_ print
    =<< (query_ conn "SELECT * FROM cart_users WHERE first_name = 'first'" :: IO
            [User]
        )
  mapM_ print
    =<< (query
          conn
          "SELECT * FROM cart_users WHERE first_name = ? and last_name = ?"
          (["fisrt", "last"] :: [String]) :: IO [User]
        )
  mapM_ print
    =<< (query conn
               "SELECT * FROM cart_users WHERE first_name = ?"
               ["first" :: String] :: IO [User]
        )


