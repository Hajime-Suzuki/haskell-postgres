module DB
  ( getConnection
  )
where
import           Data.ByteString.UTF8
import           Database.PostgreSQL.Simple
import           System.Environment

getConnection = do
  connection <- lookupEnv "PG_CONNECTION_STRING"
  case connection of
    Just str -> connectPostgreSQL . fromString $ str
    Nothing  -> error "No connection string provided"
