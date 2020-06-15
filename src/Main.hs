{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty

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
