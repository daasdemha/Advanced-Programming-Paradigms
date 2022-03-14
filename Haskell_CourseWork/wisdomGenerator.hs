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
removeRs listToBeRemovedFrom = filter (/= '\r') listToBeRemovedFrom

-- filtering based on condition and seprating to a list based on condition.
wordsWhen     :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

-- Removing null or empty list elements if present.
removeNullValues listToBeRemoveNullFrom = filter (not . null) listToBeRemoveNullFrom

-- Makes quoted list.
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
removePun listToBeRemovedPunFrom = map (filter (/= '’')) listToBeRemovedPunFrom
removePun2 listToBeRemovedPunFrom2 = map (filter (/= '“')) listToBeRemovedPunFrom2
removePun3 listToBeRemovedPunFrom3 = map (filter (/= '”')) listToBeRemovedPunFrom3

-- replacing — with a space.
replaceSymbolWithSpace :: [Char] -> [Char]
replaceSymbolWithSpace   [] = []
replaceSymbolWithSpace   (h:t) =
    if h == '—'
      then " " ++ replaceSymbolWithSpace  t
      else h : replaceSymbolWithSpace  t

-- combining the above two.
dealPun listToBeDealtWith = map replaceSymbolWithSpace (removePun3 $ removePun2 $ removePun listToBeDealtWith)

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
identifyQuotes quoteList userWord = search (lowerIndexCheck (dealPun quoteList) (convertToLower userWord)) quoteList

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
