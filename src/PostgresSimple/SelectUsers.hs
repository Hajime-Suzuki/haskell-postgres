{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}
{-# LANGUAGE QuasiQuotes #-}

module PostgresSimple.SelectUsers where
import           DB
import           User

import           Text.Show.Pretty               ( pPrint )
import           Text.StringRandom
import           Database.PostgreSQL.Simple
import           Database.PostgreSQL.Simple.SqlQQ

selectUsers = do
  conn <- getConnection

  pPrint =<< (query_ conn "SELECT * FROM users" :: IO [User])

  pPrint
    =<< (query conn
               "SELECT * FROM users WHERE first_name = ? and last_name = ?"
               ("first" :: String, "last" :: String) :: IO [User]
        ) -- for more than 2 params, use tuple

  pPrint
    =<< (query conn "SELECT * FROM users WHERE id = ?" [1 :: Int] :: IO [User]) -- for single params, use singleton list

  pPrint
    =<< (query
          conn
          [sql| 
      select * from users where id = ? 
    |]
          [1 :: Int] :: IO [User]
        ) -- [sql| ...sql query... |] can also be used
