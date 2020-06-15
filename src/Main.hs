{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}
module Main where

import Web.Scotty
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics


data User = User {
        userId :: String,
        userName :: String
    } deriving (Show, Generic)

instance ToJSON User
instance FromJSON User

bob :: User
bob = User { userId = "1", userName = "bob" }

jenny :: User
jenny = User { userId = "2", userName = "jenny" }

allUsers :: [User]
allUsers = [bob, jenny]

matchesId :: String -> User -> Bool
matchesId id user =
    userId user == id 


routes :: ScottyM ()
routes = do
    get "/hello" hello
    get "/users" listUsers
    get "/users/:id" $ do
        id <- param "id"
        json $ findUser id
    post "/users" $ do
        user <- jsonData
        json (user :: User)

hello :: ActionM ()
hello = do
    text "Hello world!"

listUsers :: ActionM ()
listUsers = do
    json allUsers

findUser :: String -> User
findUser id =
    head $ filter (matchesId id) allUsers

main :: IO ()
main = do
  putStrLn "Starting Server..."
  scotty 3000 $ do
      routes
