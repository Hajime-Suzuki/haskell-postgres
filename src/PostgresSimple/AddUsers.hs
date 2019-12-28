{-# LANGUAGE OverloadedStrings #-}

module PostgresSimple.AddUsers where

import           Database.PostgreSQL.Simple
import           DB                             ( getConnection )
import           Text.StringRandom

addUsers = do
  conn <- getConnection
  print . ("affected: " ++) . show =<< executeMany
    conn
    "INSERT INTO users (first_name,last_name) VALUES (?,?)"
    ([("I am", "Test"), ("John", "Doe")] :: [(String, String)])
