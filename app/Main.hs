module Main where

-- import           Lib
import           PostgresSimple
import           LoadEnv                        ( loadEnvFrom )

main = do
  loadEnvFrom ".env"
  postgresSimple
  selectItems
