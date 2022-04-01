-- ########################################################################################################
--                                    Importing required libraries.
-- ########################################################################################################

import Data.Char
import Data.List
import System.Random 

-- ########################################################################################################
--                                       Creating input from user.
-- ########################################################################################################

enteredWord :: IO (String)
enteredWord = do
        putStr "enter a word in which you seek wisdom about: "
        enteredWord <- getLine
        return (enteredWord)

-- ########################################################################################################
--                                 Recursive function that prints quotes.
-- ########################################################################################################                        

respond :: [String] -> IO ()
respond listToRemoveFrom = do
        -- getting index of random qoute
        generator <- getStdGen
        let randomQuoteGenerator = take 1 (randomRs (0,length  listToRemoveFrom - 1) generator)
        putStrLn $ getRandomQuote listToRemoveFrom randomQuoteGenerator
        putStr "Would you like to seek more wisdom if availible if so type y: "
        response <- getLine
        if remove (getRandomQuote listToRemoveFrom randomQuoteGenerator) listToRemoveFrom == [] 
                 then print $ "All the wisdom has been departed"
                 else 
                     if response == "y" 
                           then 
                               do 
                                  respond (remove (getRandomQuote listToRemoveFrom randomQuoteGenerator) listToRemoveFrom)
                           else 
                               do  
                                  print $ "Ok then have a good day bye."
                                    
-- ########################################################################################################
--                              Main function where everything takes place.
-- ########################################################################################################

main :: IO ()
main = do 

     userWord <- enteredWord
     contents <- readFile "WiseSayings.txt" 
     let quoteList = makeQuotes contents
     let relevantQuotes = identifyQuotes quoteList userWord
     putStrLn $ qouteAvalible relevantQuotes   
     respond relevantQuotes

-- ########################################################################################################
--                                        Making quoted list.
-- ########################################################################################################   

-- removing \r from string
removeRs :: [Char] -> [Char]
removeRs listToBeRemovedFrom = filter (/= '\r') listToBeRemovedFrom

-- filtering based on condition and seprating to a list based on condition.
wordsWhen     :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

-- Removing null or empty list elements if present.
removeNullValues :: Foldable t => [t a] -> [t a]
removeNullValues listToBeRemoveNullFrom = filter (not . null) listToBeRemoveNullFrom

-- Makes quoted list.
makeQuotes :: [Char] -> [[Char]]
makeQuotes quoteListNewLine = removeNullValues $ wordsWhen (=='\n') $ removeRs quoteListNewLine

-- ########################################################################################################
--                                         Dealing with ascii.
--                    This pocess is done here as to avoide replacing the real quotes.
--   unicode:       \8217        \8220     \8221        \8212     \299    \363   \225   \232      \257 
--   ascii:           ’            “         ”            —         ī       ū      á      è         ā
-- replaced by:     empty        empty      empty       space      
-- ī       ū      á      è         ā   were left as is as they can be a persons names real spellings.
--                 Other punctuations will not be removed as dentifyQuotes can include them.
-- ########################################################################################################

-- removing ’ “ ”  punctuations.
removePun :: [[Char]] -> [[Char]]
removePun listToBeRemovedPunFrom = map (filter (/= '’')) listToBeRemovedPunFrom

removePun2 :: [[Char]] -> [[Char]]
removePun2 listToBeRemovedPunFrom2 = map (filter (/= '“')) listToBeRemovedPunFrom2

removePun3 :: [[Char]] -> [[Char]]
removePun3 listToBeRemovedPunFrom3 = map (filter (/= '”')) listToBeRemovedPunFrom3

-- replacing — with a space.
replaceSymbolWithSpace :: [Char] -> [Char]
replaceSymbolWithSpace   [] = []
replaceSymbolWithSpace   (h:t) =
    if h == '—'
      then " " ++ replaceSymbolWithSpace  t
      else h : replaceSymbolWithSpace  t

-- combining the above two.
dealPun :: [[Char]] -> [[Char]]
dealPun listToBeDealtWith = map replaceSymbolWithSpace (removePun3 $ removePun2 $ removePun listToBeDealtWith)

-- ########################################################################################################
--                              Getting if entered word is present in a list.
-- ########################################################################################################

-- converting letters to lower case
convertToLower :: [Char] -> [Char]
convertToLower letter = map toLower letter
-- searcing the elements of a list by index. eg input [abc def wordtoget'indexof!] output [abc cde wordtogetindexof]
search :: [Int] -> [a] -> [a]
search indexes list = [list!!x | x <- indexes]
-- get if value is present(bool) in a list [abc def wordtogetindexof] output [abc cde wordtogetindexof]
checkElement :: Eq a => [[a]] -> [a] -> [Bool]
checkElement userlist element = map (isInfixOf element) userlist
-- turns that into a coresponding index [abc def wordtogetindexof] -> [0 1 2] -> 2
checkIndex :: Eq a => [[a]] -> [a] -> [Int]
checkIndex userlistindex elementindex = elemIndices True (checkElement userlistindex elementindex) 
-- lower case index check applies the above functions to check the index in a lowercase string.
lowerIndexCheck :: [[Char]] -> [Char] -> [Int]
lowerIndexCheck listofwords = checkIndex (map (map toLower) listofwords)

-- Getting lists of codes required.
-- getting if entered word is present in a list.
-- uses the abvove functions to get a quote from the required list.
identifyQuotes :: [[Char]] -> [Char] -> [[Char]]
identifyQuotes quoteList userWord = search (lowerIndexCheck (dealPun quoteList) (convertToLower userWord)) quoteList

-- checking if quote is availible
qouteAvalible :: Eq a => [a] -> [Char]
qouteAvalible availible = if availible == []
                        then "No quote availible on the selected item."  
                        else show (length availible) ++ " qoutes avalible on the selected string"

-- ########################################################################################################
--                                      Generates a quote on random
-- ########################################################################################################

-- removing element from a list
remove :: Eq a => a -> [a] -> [a]
remove element list = filter (\e -> e/=element) list
-- Picking a random quote using index 
getRandomQuote :: [a] -> [Int] -> a
getRandomQuote listToGetQuoteFrom indexPicked = listToGetQuoteFrom!!getindex indexPicked
getindex :: [a] -> a
getindex numToGetIndexFrom = numToGetIndexFrom!!0
-- getting a list of index of quotes availible
ranQuoteGenfun :: Foldable t1 => ((Int, Int) -> t2 -> [a1]) -> t1 a2 -> t2 -> [a1]
ranQuoteGenfun ranfun qLen gen' = take (length  qLen) (ranfun ((length  qLen - 1) - (length  qLen - 1),(length  qLen - 1)) gen') 

-- ########################################################################################################
--                                               The end
-- ########################################################################################################