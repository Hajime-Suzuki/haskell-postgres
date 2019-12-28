{-# LANGUAGE OverloadedStrings #-}

module PostgresSimple.AddUser where
import           Database.PostgreSQL.Simple
import           DB                             ( getConnection )
import           Data.Text                      ( unpack )
import           Text.StringRandom
import           Database.PostgreSQL.Simple.SqlQQ


addUser = do
  conn              <- getConnection
  randomFirst       <- stringRandomIO "\\w{5}"
  randomLast        <- stringRandomIO "\\w{5}"
  randomNationality <- stringRandomIO "\\w{2}"
  print . ("affected row(s): " ++) . show =<< execute
    conn
    "INSERT INTO users (first_name, last_name, nationality) VALUES (?, ?, ?)"
    ((unpack randomFirst, unpack randomLast, unpack randomNationality) :: ( String
      , String
      , String
      )
    )



