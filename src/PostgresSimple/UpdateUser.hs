{-# LANGUAGE OverloadedStrings #-}

module PostgresSimple.UpdateUser where

import           Database.PostgreSQL.Simple
import           DB                             ( getConnection )
import           Text.StringRandom

updateUser id = do
  conn <- getConnection
  print . ("affeted: " ++) . show =<< execute
    conn
    "UPDATE users set first_name = ? where id = ?"
    ("updated!!" :: String, id :: Int)





