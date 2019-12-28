{-# LANGUAGE OverloadedStrings #-}

module PostgresSimple.DeleteUser where

import           DB                             ( getConnection )
import           Database.PostgreSQL.Simple

deleteUser id = do
  conn     <- getConnection
  affected <- execute conn "DELETE FROM users WHERE id = ?" [id :: Int]
  case affected of
    0 -> print "use not found"
    _ -> print $ "user " ++ show id ++ " has been deleted"
