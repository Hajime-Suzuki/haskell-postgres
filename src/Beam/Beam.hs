{-# LANGUAGE DeriveGeneric, OverloadedStrings, FlexibleContexts, FlexibleInstances, TypeFamilies, TypeApplications, DeriveAnyClass,StandaloneDeriving,TypeSynonymInstances #-}

module Beam.Beam
    ( someFunc
    )
where

import           Database.Beam
import           Database.Beam.Postgres
import           Data.Text                      ( Text )
import qualified Database.PostgreSQL.Simple    as PG
import           DB                             ( getConnection )

data UserT f = User {
    _userEmail :: Columnar f Text,
    _userFirstName :: Columnar f Text,
    _userLastName :: Columnar f Text,
    _userPassword :: Columnar f Text
} deriving (Generic)
instance Beamable UserT

type User = UserT Identity
type UserId = PrimaryKey UserT Identity
deriving instance Show User
deriving instance Eq User

instance Table UserT where
    data PrimaryKey UserT f = UserId (Columnar f Text) deriving (Generic, Beamable)
    primaryKey = UserId . _userEmail


data ShoppingCartDb f = ShoppingCartDb  {
    _shoppingCartUsers :: f (TableEntity UserT)
} deriving(Generic, Database be)

shoppingCartDb :: DatabaseSettings be ShoppingCartDb
shoppingCartDb = defaultDbSettings


insertUser conn =
    runBeamPostgresDebug putStrLn conn
        $ runInsert
        $ insert (_shoppingCartUsers shoppingCartDb)
        $ insertValues [User "james+@example.com" "a" "b" "c"]

-- allUsers' :: Q Postgres ShoppingCartDb s (UserT (QExpr Postgres s))
-- allUsers' = all_ (_shoppingCartUsers shoppingCartDb)

getAllUsers conn = runBeamPostgresDebug putStrLn conn $ do
    users <- runSelectReturningList $ select allUsers
    -- mapM_ (liftIO . putStrLn . show) users
    return users
    where allUsers = all_ (_shoppingCartUsers shoppingCartDb)

someFunc = do
    conn          <- getConnection
    [PG.Only num] <- PG.query_ conn "select 2 + 2" :: IO [PG.Only Int]
    print num
    users <- getAllUsers conn
    print . _userEmail . head $ users
    -- print (User "email" "first" "last" "pass" :: User)
    -- print (User @Identity "email" "first" "last" "pass") -- can be written like this.

