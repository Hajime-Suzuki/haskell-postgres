module Main where

import           PostgresSimple.SelectUsers
import           PostgresSimple.AddUser
import           PostgresSimple.AddUsers
import           PostgresSimple.UpdateUser
import           PostgresSimple.DeleteUser
import           LoadEnv                        ( loadEnvFrom )

main = do
  loadEnvFrom ".env"
  putStrLn "=== select users ===\n"
  selectUsers
  putStrLn $ '\n' : replicate 30 '='
  putStrLn "=== add user ===\n"
  addUser
  putStrLn $ '\n' : replicate 30 '='
  putStrLn "=== add users ===\n"
  addUsers
  putStrLn "=== update user ===\n"
  updateUser 10
  putStrLn "=== delete user ===\n"
  deleteUser 100
