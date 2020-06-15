{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty

data User = User {
        userId :: Int,
        userName :: String
    } deriving Show

bob :: User
bob = User { userId = 1, userName = "bob" }

jenny :: User
jenny = User { userId = 2, userName = "jenny" }

allUsers :: [User]
allUsers = [bob, jenny]


routes :: ScottyM ()
routes = do
    get "/hello" hello

hello :: ActionM ()
hello = do
    text "Hello world!"

main :: IO ()
main = do
  putStrLn "Starting Server..."
  scotty 3000 $ do
      routes
