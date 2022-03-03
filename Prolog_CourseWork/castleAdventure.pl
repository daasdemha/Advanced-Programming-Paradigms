/*#######################################################################################################*/
/*                                     Take backs or exchanges.                                          */
/*#######################################################################################################*/

:- retractall(pickup(_, _)), retractall(at(_)), retractall(workingOrder(_)).

/*#######################################################################################################*/
/*                                         starting point                                                */
/*#######################################################################################################*/

at(entrance). 

/*#######################################################################################################*/
/*                                   connections between places.                                         */
/*#######################################################################################################*/

connection(entrance, left, atrium).

connection(atrium, right, entrance).
connection(atrium, left, greatHall).
connection(atrium, down, staircase).
connection(atrium, bottom, dungeon) :-
        write('The dragon kills you. You Lose.\n'), nl,
        endgame.

connection(greatHall, right, atrium).
connection(greatHall, left, anotherhiddenroom) :- pickup(key, pickedup).
connection(greatHall, left, anotherhiddenroom) :-
        write('The door is locked you cant go there.'), nl,
        !, fail.

connection(anotherhiddenroom, right, greatHall).
connection(anotherhiddenroom, left, statue).

connection(statue, right, anotherhiddenroom).

connection(staircase, up, atrium).
connection(staircase, right, masterBedroom).
connection(staircase, bottom, dungeon) :- pickup(amulet, pickedup).
connection(staircase, bottom, dungeon) :-
        write('You Can only go to the dungeon with the amulet in hand.'), nl,
        !, fail.

connection(masterBedroom, left, staircase).
connection(masterBedroom, right, treasureChest).

connection(treasureChest, left, masterBedroom).

connection(dungeon, up, staircase).
connection(dungeon, right, atrium) :-
        write('The door is locked you cant go there.'), nl,
        !, fail.

/*#######################################################################################################*/
/*                                   Objects present in the game.                                        */
/*#######################################################################################################*/

pickup(sword, greatHall).
pickup(amulet, masterBedroom).
pickup(key, treasureChest).
/*#######################################################################################################*/
/*                                       picking up an object                                            */ 
/*#######################################################################################################*/

pickup(X) :-
        pickup(X, pickedup),
        write('You already have the item your looking for.'),
        nl.

pickup(X) :-
        at(Place),
        pickup(X, Place),
        retract(pickup(X, Place)),
        assert(pickup(X, pickedup)),
        write('You have picked up '), write(X), write(' item.'),
        nl, !.

pickup(_) :-
        write('The item is not present here'),
        nl.

/*#######################################################################################################*/
/*                                           Boss Monster                                                */
/*#######################################################################################################*/

workingOrder(statue).

/*#######################################################################################################*/
/*                                      attacking boss monster                                           */
/*                                               and                                                     */
/*                                 attacking without anyone present.                                     */
/*#######################################################################################################*/

attack  :-
        at(staircase),
        write('You die by falling down.'), nl, 
        write('You were so young.'), nl, 
        endgame.

attack :-
        at(staircase),
        pickup(sword, pickedup),
        write('You die by falling down the stairs being stabbed with your own sword.'), nl,
        write('You were so young.'), nl, 
        endgame.



attack  :-
        at(statue),
        pickup(sword, pickedup),
        retract(workingOrder(statue)),
        write('Suddenly the statue begins to move its comming at you.'),  nl,
        write('It attacks you.'), nl,
        write('You attack back with your sword and destory the statue.'), nl,
        nl, !.


attack  :-
        at(statue),
        write('Suddenly the statue begins to move its comming at you.'),  nl,
        write('It attacks you.'), nl,
        write('You fight back but to no avail.'), nl,
        write('You died.'), nl, 
        endgame.

attack  :-
        write('There is nothing here to attack.'), nl.

/*#######################################################################################################*/
/*                                   directions player can go to.                                        */
/*#######################################################################################################*/

left :- go(left).
right :- go(right).
up :- go(up).
bottom :- go(bottom).
down :- go(down).

/*#######################################################################################################*/
/*                                 Moving from one Place to another.                                     */
/*#######################################################################################################*/

go(Direction) :-
        at(Here),
        connection(Here, Direction, There),
        retract(at(Here)),
        assert(at(There)),
        lookAround, !.

go(_) :-
        write('Going there is not possible').

/*#######################################################################################################*/
/*                                 Looking at things around you.                                         */
/*#######################################################################################################*/

lookAround :-
        at(Place),
        whereAmI(Place),
        nl,
        itemspresent(Place),
        nl.

/*#######################################################################################################*/
/*                                   picking up items if present.                                        */
/*#######################################################################################################*/

itemspresent(Place) :-
        pickup(X, Place),
        write('The '), write(X), write(' item is present here.'), nl,
        fail.

itemspresent(_).

/*#######################################################################################################*/
/*                                         if game ends                                                  */
/*                                          win or lose                                                  */
/*#######################################################################################################*/

endgame :-
        nl,
        write('The game has eneded.\n\n'),
        halt.

/*#######################################################################################################*/
/*                            Prints the Instructions for the game.                                      */
/*#######################################################################################################*/

instructions :-
        nl,
        write('Play the game by entering commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('intro.                              ###      to start the game.      ###'), nl,
        write('whereAmI.                           ### tells your current location. ###'), nl,
        write('left.                               ###        to go to left.        ###'), nl,
        write('right.                              ###        to go to right.       ###'), nl,
        write('up.                                 ###         to go to up.         ###'), nl,
        write('down.                               ###        to go to down.        ###'), nl,
        write('bottom.                             ###     to go to the dungeon.    ###'), nl,
        write('pickup(item).                       ###        to pick up item.      ###'), nl,
        write('attack.                             ###           to attack.         ###'), nl, 
        write('whereAmI.                           ###      to look around you.     ###'), nl,
        write('pickup(X).then;(repeatedly)         ###     to at items you have     ###'), nl,
        write('instructions.                       ###   to see this message again. ###'), nl,
        write('endGame.                            ### to end the game at any time. ###'), nl,
        nl.

/*#######################################################################################################*/
/*                                        magic happens here                                             */
/*                                             prompts                                                   */
/*                                   Information about the users                                         */
/*                                  Information about the location                                       */
/*                                    Information about the boss                                         */
/*#######################################################################################################*/      

whereAmI :- lookAround.
whereAmI(dungeon) :-
        pickup(sword, pickedup),
        write('Congratulations You are in the dungeon with the sword you win!'), nl,
        write('You can go beyond now and face greater challanges.'), nl,
        write('You can finally learn about the alchemist find some answers.'),nl,
        write('All of that in our 2nd game with better graphics'), nl, 
        write('Untill then good bye and good day.'),
        endgame.

whereAmI(dungeon) :-
        write('You are at the dungeon.'), nl,
        write('Above you is the staircase.'), nl, 
        write('On your right side there is a locked metalic door.'), nl,
        write('You can see a small fire coming from its corners.'), nl,
        write('You need the sword to go through the dungeon'), nl, !. 
        
whereAmI(entrance) :-
        write('You are at the entrance.'), nl,
        write('To your left is the atrium.'), nl.

whereAmI(atrium) :-
        write('You are at the atrium.'), nl,
        write('To your right is the entrance.'), nl,
        write('Below you is the starecase.'), nl,
        write('To your left is the greatHall.'), nl,
        write('There is a path leading to the dungeon but it has a dragon present.'), nl.

whereAmI(greatHall) :-
        write('You are at the greatHall.'), nl,
        write('To your right is the atrium.'), nl,
        write('On your left there is a small key hole in the wall.'), nl.

whereAmI(staircase) :-
        write('You are at the staircase'), nl,
        write('Above you is the atrium.'), nl,
        write('On your right side is the masterBedroom.'), nl,
        write('There is a secrete path here going down.'), nl.

whereAmI(masterBedroom) :-
        write('You are at the masterBedroom'), nl,
        write('On your left side is the staircase.'), nl,
        write('On your right side is a tresure chest.'), nl.

whereAmI(treasureChest) :-
        write('On your left side is the masterBedroom.'), nl,
        write('You have opened the Treasure chest.'), nl.

whereAmI(anotherhiddenroom):-
        write('Your inside the most hidden part of the infrastructure'), nl,
        write('The room is barley lit and there is a bad odur that fills the room'),  nl,
        write('On your right there is the greatHall'),  nl,
        write('On your left there is a huge statue.'),  nl.


whereAmI(statue) :-
        workingOrder(statue),
        write('On your right is the hidden room'), nl,
        write('The statue is in the centre of the room the room is covered in blood.'), nl,
        write('Is this the work of the alchemist outside the dungeon? you ponder.'), nl.

whereAmI(statue) :-
        write('On your right is the hidden room'), nl,
        write('There is a broken statue here.'), nl,
        write('Dont attack again or it might comeback to life. equal exchange of energy'), nl.

/*#######################################################################################################*/
/*                                   Starts game automatically.                                          */
/*#######################################################################################################*/

intro :-
       instructions, % gives user instructions to the game.
       lookAround.  % tells user what other locations + items are avalible.
:- intro.

/*#######################################################################################################*/
/*                                           The end                                                     */
/*#######################################################################################################*/