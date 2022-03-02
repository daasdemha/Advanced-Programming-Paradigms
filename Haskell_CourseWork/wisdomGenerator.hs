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

respond listToRemoveFrom = do
        -- getting index of random qoute
        generator <- getStdGen
        let randomQuoteGenerator = take 1 (randomRs (0,length  listToRemoveFrom - 1) generator)
        print $ getRandomQuote listToRemoveFrom randomQuoteGenerator
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

main = do 
     userWord <- enteredWord
     contents <- readFile "WiseSayings.txt" 
     let quoteList = makeQuotes contents
     let relevantQuotes = identifyQuotes quoteList userWord
     print $ qouteAvalible relevantQuotes
     
     respond relevantQuotes

-- ########################################################################################################
--                                        Making quoted list.
-- ########################################################################################################   

-- removing \r from string
removeRs listToBeRemovedFrom = filter (/= '\r') listToBeRemovedFrom

-- filtering based on condition and seprating to a list based on condition.
wordsWhen     :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

-- Makes quoted list.
makeQuotes quoteListNewLine = wordsWhen (=='\n') $ removeRs quoteListNewLine

-- ########################################################################################################
--                              Getting if entered word is present in a list.
-- ########################################################################################################

-- converting letters to lower case
convertToLower letter = map toLower letter
-- searcing the elements of a list by index.
search indexes list = [list!!x | x <- indexes]
-- get if value is present(bool) in a list
checkElement userlist element = map (isInfixOf element) userlist
-- turns that into a coresponding index
checkIndex userlistindex elementindex = elemIndices True (checkElement userlistindex elementindex) 
-- lower case index check 
lowerIndexCheck listofwords = checkIndex (map (map toLower) listofwords)

-- Getting lists of codes required.
-- getting if entered word is present in a list
identifyQuotes quoteList userWord = search (lowerIndexCheck quoteList (convertToLower userWord)) quoteList

-- checking if quote is availible
qouteAvalible availible = if availible == []
                        then "No quote availible on the selected item."  
                        else show (length availible) ++ " qoutes avalible on the selected string"

-- ########################################################################################################
--                                      Generates a quote on random
-- ########################################################################################################

-- removing element from a list
remove element list = filter (\e -> e/=element) list
-- Picking a random quote using index 
getRandomQuote listToGetQuoteFrom indexPicked = listToGetQuoteFrom!!getindex indexPicked
getindex numToGetIndexFrom = numToGetIndexFrom!!0
-- getting a list of index of quotes availible
ranQuoteGenfun ranfun qLen gen' = take (length  qLen) (ranfun ((length  qLen - 1) - (length  qLen - 1),(length  qLen - 1)) gen') 

-- ########################################################################################################
--                                               The end
-- ########################################################################################################