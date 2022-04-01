/*#######################################################################################################*/
/*                                               Refrences                                               */
/*                                               Art used                                                */
/*                                        https://ascii.co.uk/art                                        */
/*                                        https://www.asciiart.eu                                        */
/*#######################################################################################################*/


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
        write('
                                                   _
                       /                            )
                      (                             |\\
                     /|                              \\\\
                    //                                \\\\
                   ///                                 \\|
                  /( \\                                  )\\
                  \\\\  \\_                               //)
                   \\\\  :\\__                           ///
                    \\\\     )                         // \\
                     \\\\:  /                         // |/
                      \\\\ / \\                       //  \\
                       /)   \\     ___..-’         ((  \\_|
                      //     /  .’  _.’           \\ \\  \\
                     /|       \\(  _\\_____          \\ | /
                    (| _ _  __/          ’-.       ) /.’
                     \\\\ .  ’-.__ \\          \\_    / / \\
                      \\\\_’.     > ’-._   ’.   \\  / / /
                       \\ \\      \\     \\    \\   .’ /.’
                        \\ \\  ’._ /     \\  /   / .’ |
                         \\ \\_     \\_   |    .’_/ __/
                          \\  \\      \\_ |   / /  _/ \\_
                           \\  \\       / _.’ /  /     \\
                           \\   |     /.’   / .’       ’-,_
                            \\   \\  .’   _.’_/             \\
               /\\    /\\      ) ___(    /_.’           \\    |
              | _\\__// \\    (.’      _/               |    |
              \\/_  __  /--’`    ,                   __/    /
              (_ ) /b)  \\  ’.   :            \\___.-:_/ \\__/
              /:/:  ,     ) :        (      /_.’_/-’ |_ _ /
             /:/: __/\\ >  __,_.----.__\\    /        (/(/(/
            (_(,_/V .’/--’    _/  __/ |   /
             VvvV  //`    _.-’ _.’     \\   \\
               n_n//     (((/->/        |   /
               ’--’         ~=’          \\  |
                                          | |_,,,
                                          \\  \\  /
                                           ’.__)        
        
        '), nl,

        endgame.

connection(greatHall, right, atrium).
connection(greatHall, left, anotherhiddenroom) :- pickup(key, pickedup).
connection(greatHall, left, anotherhiddenroom) :-
        write('The door is locked you cant go there.'), nl,
        write('
                             .--------.
                            / .------. \\
                           / /        \\ \\
                           | |        | |
                          _| |________| |_
                        .’ |_|        |_| ’.
                        ’._____ ____ _____.’
                        |     .’____’.     |
                        ’.__.’.’    ’.’.__.’
                        ’.__  | LOCK |  __.’
                        |   ’.’.____.’.’   |
                        ’.____’.____.’____.’
                        ’.________________.’        
        '), nl,
        !, fail.

connection(anotherhiddenroom, right, greatHall).
connection(anotherhiddenroom, left, statue).

connection(statue, right, anotherhiddenroom).

connection(staircase, up, atrium).
connection(staircase, right, masterBedroom).
connection(staircase, bottom, dungeon) :- pickup(amulet, pickedup).
connection(staircase, bottom, dungeon) :-
        write('You Cannot go through walls.'), nl,
        write('
                             .--------.
                            / .------. \\
                           / /        \\ \\
                           | |        | |
                          _| |________| |_
                        .’ |_|        |_| ’.
                        ’._____ ____ _____.’
                        |     .’____’.     |
                        ’.__.’.’    ’.’.__.’
                        ’.__  | LOCK |  __.’
                        |   ’.’.____.’.’   |
                        ’.____’.____.’____.’
                        ’.________________.’        
        '), nl,
        !, fail.

connection(masterBedroom, left, staircase).
connection(masterBedroom, right, treasureChest).

connection(treasureChest, left, masterBedroom).

connection(dungeon, up, staircase).
connection(dungeon, right, atrium) :-
        write('The door is locked you cant go there.'), nl,
        write('
                             .--------.
                            / .------. \\
                           / /        \\ \\
                           | |        | |
                          _| |________| |_
                        .’ |_|        |_| ’.
                        ’._____ ____ _____.’
                        |     .’____’.     |
                        ’.__.’.’    ’.’.__.’
                        ’.__  | LOCK |  __.’
                        |   ’.’.____.’.’   |
                        ’.____’.____.’____.’
                        ’.________________.’        
        '), nl,
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


whereAmI :- 
         at(Place),
         howIsThePlace(Place).

/*#######################################################################################################*/
/*                                 Looking at things around you.                                         */
/*#######################################################################################################*/

lookAround :-
        at(Place),
        whereAmI,
        locationDetailedDescription(Place),
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
        write('*****************************************************************************************************************************'), nl,
                                                                                                                                                nl,
        write('                                           Welcome to Castle Adventure!                                                      '), nl,
        write('                                                Rules are simple.                                                            '), nl,
        write('                                  Find the secrete amulet to enter the dungeon.                                              '), nl,
        write('           Once you have and amulet collect the sword of the avenger to win the game and chase the alchemist.                '), nl,
                                                                                                                                                nl,
        write('*****************************************************************************************************************************'), nl,
                                                                                                                                                nl,
        write('Play the game by entering commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('intro.                              ###  to start the game.                                                        ###'), nl,
        write('whereAmI.                           ###  tells your current location.                                              ###'), nl,
        write('lookAround.                         ###  to check your location, connected locations and if items are present.     ###'), nl,
        write('left.                               ###  to go to left.                                                            ###'), nl,
        write('right.                              ###  to go to right.                                                           ###'), nl,
        write('up.                                 ###  to go to up.                                                              ###'), nl,
        write('down.                               ###  to go to down.                                                            ###'), nl,
        write('bottom.                             ###  to go to the dungeon.                                                     ###'), nl,
        write('pickup(item).                       ###  to pick up item.                                                          ###'), nl,
        write('attack.                             ###  to attack.                                                                ###'), nl, 
        write('pickup(X).then type ; (repeatedly)  ###  to view items you have.                                                   ###'), nl,
        write('instructions.                       ###  to see this message again.                                                ###'), nl,
        write('endGame.                            ###  to end the game at any time.                                              ###'), nl,
                                                                                                                                         nl,
        write('#############################################################################################################################'), nl,
        nl.

/*#######################################################################################################*/
/*                                 Tell you at which place you are at.                                   */
/*#######################################################################################################*/  


howIsThePlace(dungeon) :-
        pickup(sword, pickedup),
        write('You are in the dungeon with the sword.'), nl,
        write('Congratulations You are in the dungeon with the sword you win!'), nl,
        write('You can go beyond now and face greater challanges.'), nl,
        write('You can finally learn about the alchemist find some answers.'),nl,
        write('All of that in our 2nd game with better graphics'), nl, 
        write('Untill then good bye and good day.'),
        endgame.

howIsThePlace(dungeon) :-
        write('You are at the dungeon.'), nl,
        write('You need the sword to go through the dungeon'), nl, !. 
        
howIsThePlace(entrance) :-
        write('You are at the entrance.'), 
        write('
                                       )\\         O_._._._A_._._._O         /(
                                        \\`--.___,’=================`.___,--’/
                                         \\`--._.__                 __._,--’/
                                           \\  ,. l`~~~~~~~~~~~~~~~’l ,.  /
                               __            \\||(_)!_!_!_.-._!_!_!(_)||/            __
                               \\\\`-.__        ||_|____!!_|;|_!!____|_||        __,-’//
                                \\\\    `==---=’-----------’=’-----------`=---==’    //
                                | `--.                                         ,--’ |
                                 \\  ,.`~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~’,.  /
                                   \\||  ____,-------._,-------._,-------.____  ||/
                                    ||\\|___!`======="!`======="!`======="!___|/||
                                    || |---||--------||-| | |-!!--------||---| ||
                          __O_____O_ll_lO_____O_____O|| |’|’| ||O_____O_____Ol_ll_O_____O__
                          o H o o H o o H o o H o o |-----------| o o H o o H o o H o o H o
                         ___H_____H_____H_____H____O =========== O____H_____H_____H_____H___
                          /|=============|\\
                        ()______()______()______() ’==== +-+ ====’ ()______()______()______()
                        ||{_}{_}||{_}{_}||{_}{_}/| ===== |_| ===== |\\{_}{_}||{_}{_}||{_}{_}||
                        ||      ||      ||     / |==== s(   )s ====| \\     ||      ||      ||
                        ======================()  =================  ()======================
                        ----------------------/| ------------------- |\\----------------------
                                             / |---------------------| \\
                        -’--’--’           ()  ’---------------------’  ()
                                           /| ------------------------- |\\    --’--’--’
                               --’--’     / |---------------------------| \\    ’--’
                                        ()  |___________________________|  ()           ’--’-
                          --’-          /| _______________________________  |\\
                         --’           / |__________________________________| \\
        '), nl.

howIsThePlace(atrium) :-
        write('You are at the atrium.'), nl,
        write('
           
                         ____________________________________________________________________________
                        |: : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : |
                        | : : : : : : :_______________________________: : : : : : : : : : : : : : : :|
                        |: : : : : : :|!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!|: : : : : : : : : : : : : : : |
                        | : : : : : : |.-=^=-.-=^=-.-=^=-.-=^=-.-=^=-.| : : : : : : : : : : : : : : :|
                        |: : : : : : :’|    _’     ’     ’     ’     |’: : : : : : : : : ____: : : : |
                        | : : : : : : :|   (  ) _                    |: : : : : : : : : /    \\: : : :|
                        |: : : : : : : |  ( _)__ )_)                 | : : : : : : : : |//    |: : : |
                        | : : : : : : :|                   \\_/       |: : : : : : : : :|      | : : :|
                        |==_===========|                 --(_)--     |==================\\____/=======|
                        | / \\          |                   / \\       |              ,    ,;;,    ,   |
                        |/___\\         |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|             _d___;(;;);___b_  |
                        |  |’          |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|            =======`;;`======= |
                        |  |      ||   ==============(_)==============   ||         /""""""""""""\\   |
                        |  |      ||        _________~|~_________        ||         |     `(,    |   |
                        |  |      \\\\_____  (_____________________)  _____//         |  O  )   O  |   |
                        |  |       |_____)          )   (          (_____|          |  | (@@) |  |   |
                        |__|_______||___||__________(   )__________||___||__________|_/!\\@@@@/!\\_|__lc
                          _|_    .;|’;;;’|;;;;;;;;;;_) (_;;;;;;;;;;|’;;;’|;.       ================
                                :;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:
                               :;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:
                                 ’:::::::::::::::::::::::::::::::::::::::::’
             
 
                        ~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.<>.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~        
        
        '), 
        nl.

howIsThePlace(greatHall) :-
        write('You are at the greatHall.'), nl.

howIsThePlace(staircase) :-
        write('You are at the staircase'), nl,
        write('
                         -     -                 .      :
                         -     -     -                  |          -
                   -           -     -    .      .      |    -     -     -
                         -     -     -    |      .      |    -     -     -
                   -     -     -     -    |      :      |    -     -     -
                   -     -     -     -   .|     _|_     |.         -     -
                   -     -     -       ._-|             |-_.       -     -
                   -     -     -     ._-  |     .       |  -_.     -     -
                -.--.--.--.--.--. _ _-_ _ |   E-1-2-3   | _ _-_ _ .--.--.--.--.--.-
                 |  |  |  |  |  |`.| | | ||   _______   || | | |.’|  |  |  |  |  |
                8888888888888888L_|`.88888|  |   |   |  |88888.’|_J8888888888888888
                       |:     `888L_|`.|  |  |   |   |  | :|.’|_J888’    :|
                       |:       `888L_|`. |  |   |   |: | .’|_J888’      :|
                       |:        |`888L_|`.  |   |   |  .’|_J888’        :|
                _______<:________|:_`888L_|) |   |   | (|_J888’:|________:|________
                       |:        |:   `888L. |___|___| .J888’  :|        :|
                       |:        |:     `88|/_________\\|88’    :|        :|
                 __..--       _.-’        ,|L_________J|.      `-._      ``--..__
                ’         _.-’            |/___________\\|          `-._          ``
                                        .c|L___________J|c.            `-.
                                      .’ |/_____________\\| `.
                                    .’|  |L_____________J|  |`.
                                  .’  | _/               \\_ |  `.
                                .’|   _//                 \\\\_   |`.
                             .’  | _///                   \\\\\\_ |  `.
                          _______________________________________________
                        .’                                               `.
                      .’                                                   `.
                    .’                                                       `.
        '), 
        nl.

howIsThePlace(masterBedroom) :-
        write('You are at the masterBedroom'),  nl,
        write('
~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.<>.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~

o(=(=(=(=)=)=)=)o
 !!!!!!}!{!!!!!!                                                ___ 
 !!!!!} | {!!!!!                                               /   \\
 !!!!}  |  {!!!!     _!_     ()              ()     _!_       | //  |
 !!!'   |   '!!!    |~@~|    ||______________||    |~@~|      |     |
 ~@~----+----~@~    |___|    |                |    |___|       \\___/
 !!!    |    !!!      |      |      ~@@~      |      |       _________
 !!!    |    !!!     ( )     |_______  _______|     ( )     |____-____|
 !!!____|____!!!  __(___)__  {__~@~__}{__~@~__}  __(___)__  |____-____|
 !!!=========!!!   |__-__|   %%%%%%%%%%%%%%%%%%   |__-__|   |____-____|
_!!!_________!!!___|_____|_ %%%%%%%%%%%%%%%%%%%% _|_____|___|____-____|_
                   |     | %%%%%%%%%%%%%%%%%%%%%% |     |   |/       \\|
                          %%%%%%%%%%%%%%%%%%%%%%%%
                         %%%%%%%%%%%%%%%%%%%%%%%%%%
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       /!!!!!!!!!!!!!!!!!!!!!!!!!!!!\\
                       !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
                       !!!!!!!!!!!!!!!!!!!!!!!!!!lc!!
                       `======~@~==========~@~======`
                      `==============================`
                     `====~@~==================~@~====`
                    `==================================`
                   `==~@~==========================~@~==`

~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.<>.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~.:.~
        '),  
        nl.

howIsThePlace(treasureChest) :-
        write('You are next a tresure chest.'), nl,
        write('
                    ____...------------...____
               _.-"` /o/__ ____ __ __  __ \\o\\_`"-._
             .’     / /                    \\ \\     ’.
             |=====/o/======================\\o\\=====|
             |____/_/________..____..________\\_\\____|
             /   _/ \\_     <_o#\\__/#o_>     _/ \\_   \\
             \\_________\\####/_________/
              |===\\!/========================\\!/===|
              |   |=|          .---.         |=|   |
              |===|o|=========/     \\========|o|===|
              |   | |         \\() ()/        | |   |
              |===|o|======{’-.) A (.-’}=====|o|===|
              | __/ \\__     ’-.\\uuu/.-’    __/ \\__ |
              |==== .’.’^’.’.====|
              |  _\\o/   __  {.’ __  ’.} _   _\\o/  _|
              `""""-""""""""""""""""""""""""""-""""`
        '),
        nl.

howIsThePlace(anotherhiddenroom):-
        write('Your inside the most hidden part of the infrastructure'), nl.


howIsThePlace(statue) :-
        workingOrder(statue),
        write('you are in a room with a statue centre of the room the room is covered in blood.'), 
                write('
                           ,--.
                          {    }
                          K,   }
                         /  `Y`
                    _   /   /
                   {_’-K.__/
                     `/-.__L._
                     /  ’ /`\\_}
                    /  ’ /     
            ____   /  ’ /
     ,-’~~~~    ~~/  ’ /_
   ,’             ``~~~%%’,
  (                     %  Y
 {                      %% I
{      -                 %  `.
|       ’,                %  )
|        |   ,..__      __. Y
|    .,_./  Y ’ / ^Y   J   )|
\\           |’ /   |   |   ||
 \\          L_/    . _ (_,.’(
  \\,   ,      ^^""’ / |      )
    \\_  \\          /,L]     /
      ’-_`-,       ` `   ./`
         `-(_            )
             ^^\\..___,.--`
        
        '),
        nl.

howIsThePlace(statue) :-
        write('You are next to a broken statue.'), nl,
        write('
                           ,--.
                          {    }
                          K,   }
                         /  `Y`
                    _   /   /
                   {_’-K.__/
                     `/-.__L._
                     /  ’ /`\\_}
                    /  ’ /     
            ____   /  ’ /
     ,-’~~~~    ~~/  ’ /_
   ,’             ``~~~%%’,
  (                     %  Y
 {                      %% I
{      -                 %  `.
|       ’,                %  )
|        |   ,..__      __. Y
|    .,_./  Y ’ / ^Y   J   )|
\\           |’ /   |   |   ||
 \\          L_/    . _ (_,.’(
  \\,   ,      ^^""’ / |      )
    \\_  \\          /,L]     /
      ’-_`-,       ` `   ./`
         `-(_            )
             ^^\\..___,.--`
        
        '), nl.


/*#######################################################################################################*/
/*                                        magic happens here                                             */
/*                                             prompts                                                   */
/*                                   Information about the users                                         */
/*                                  Information about the location                                       */
/*                                    Information about the boss                                         */
/*#######################################################################################################*/      

locationDetailedDescription(dungeon) :-
        pickup(sword, pickedup),
        write('
                           _________________________________________________________
                         /|     -_-                                             _-  |\\
                        / |_-_- _                                         -_- _-   -| \\   
                          |                            _-  _--                      | 
                          |                            ,                            |
                          |      .-’````````’.        ’(`        .-’```````’-.      |
                          |    .` |           `.      `)’      .` |           `.    |          
                          |   /   |   ()        \\      U      /   |    ()       \\   |
                          |  |    |    ;         | o   T   o |    |    ;         |  |
                          |  |    |     ;        |  .  |  .  |    |    ;         |  |
                          |  |    |     ;        |   . | .   |    |    ;         |  |
                          |  |    |     ;        |    .|.    |    |    ;         |  |
                          |  |    |____;_________|     |     |    |____;_________|  |  
                          |  |   /  __ ;   -     |     !     |   /     `’() _ -  |  |
                          |  |  / __  ()        -|        -  |  /  __--      -   |  |
                          |  | /        __-- _   |   _- _ -  | /        __--_    |  |
                          |__|/__________________|___________|/__________________|__|
                         /                                             _ -        lc \\
                        /   -_- _ -             _- _---                       -_-  -_ \\
        '), nl,
        write('Congratulations you win!'), nl,
        write('You can go beyond now and face greater challanges.'), nl,
        write('You can finally learn about the alchemist find some answers.'),nl,
        write('All of that in our 2nd game with better graphics'), nl, 
        write('Untill then good bye and good day.'),
        endgame.

locationDetailedDescription(dungeon) :-
        write('Above you is the staircase.'), nl, 
        write('On your right side there is a locked metalic door.'), nl,
        write('You can see a small fire coming from its corners.'), nl,
        write('You need the sword to go through the dungeon'), nl, !. 
        
locationDetailedDescription(entrance) :-
        write('To your left is the atrium.'), nl.

locationDetailedDescription(atrium) :-
        write('To your right is the entrance.'), nl,
        write('Below you is the starecase.'), nl,
        write('To your left is the greatHall.'), nl,
        write('There is a path leading to the dungeon but it has a dragon present.'), nl.

locationDetailedDescription(greatHall) :-
        write('To your right is the atrium.'), nl,
        write('On your left there is a small key hole in the wall.'),
        write('
                        IIIIIIIIIIIII| |IIIIIIIIIIIIIIIII| |IIIIIIIIIIIII
                        |_|___|___|__| |__|___|___|___|__| |__|___|___|_|
                        |___|___|___|| ||___|___|___|___|| ||___|___|___|
                        |_|       |__| |__|           |__| |__|       |_|
                        |_|_______|_|| ||_|___________|_|| ||_|_______|_|
                        |_|___|___|__| |__|___|___|___|__| |__|___|___|_|
                        |___|___|___|| ||___|___|___|___|| ||___|___|___|
                        |_|___|___|__| |_The Great Hall__| |__|___|___|_|
                        |___|___|___|| ||___|___|___|___|| ||___|___|___|
                        |_|       |__| |__|___|___|___|__| |__|  ScS  |_|
                        |_|_______|_|| ||___|   |   |___|| ||_|_______|_|
                        |_|___|___|__| |__@ |   |   |_@__| |__|___|___|_|
                        |___|_/^\\___|| ||___|  揉`  |___|| ||___/^\\_|___|
                        |_|__<===>|__|_|__|_|   |   |_|__|_|__|<===>__|_|
                           ][o][  |_______|___|___|_______|  ][o][
                        <===>          |       |          <===>
                        ______\\T/________,_,|,_,o,_,|,_,________\\T/______
                        |L_L_L_L_L_L_L_L_|"|"|"|y|"|"|"|_L_L_L_L_L_L_L_L|
                        |_L_L_L_L_L_L_L_L| | | |y| | | |L_L_L_L_L_L_L_L_|
                        |L_L_L_L_L_L_L_L_|_|_|_|y|_|_|_|_L_L_L_L_L_L_L_L|       
        '),
         nl.

locationDetailedDescription(staircase) :- pickup(amulet, pickedup),
        write('Above you is the atrium.'), nl,
        write('On your right side is the masterBedroom.'), nl,
        write('The amulet lights up. The wall below you slides open and there is a dark path going towrds the doungeon.'), nl.
        
locationDetailedDescription(staircase) :-
        write('Above you is the atrium.'), nl,
        write('On your right side is the masterBedroom.'), nl,
        write('There a wall below you.'), nl.



locationDetailedDescription(masterBedroom) :-
        write('On your left side is the staircase.'), nl,
        write('On your right side is a tresure chest.'), nl.

locationDetailedDescription(treasureChest) :-
        write('On your left side is the masterBedroom.'), nl,
        write('You have opened the Treasure chest.'), nl,
         write('
                                                     _.--.
                                                _.-’_:-’||
                                            _.-’_.-::::’||
                                       _.-:’_.-::::::’  ||
                                     .’`-.-:::::::’     ||
                                    /.’`;|:::::::’      ||_
                                   ||   ||::::::’     _.;._’-._
                                   ||   ||:::::’  _.-!oo @.!-._’-.
                                   \\’.  ||:::::.-!()oo @!()@.-’_.|
                                    ’.’-;|:.-’.&$@.& ()$%-’o.’\\U||
                                      `>’-.!@%()@’@_%-’_.-o _.|’||
                                       ||-._’-.@.-’_.-’ _.-o  |’||
                                       ||=[ ’-._.-\\U/.-’    o |’||
                                       || ’-.]=|| |’|      o  |’||
                                       ||      || |’|        _| ’;
                                       ||      || |’|    _.-’_.-’
                                       |’-._   || |’|_.-’_.-’
                                        ’-._’-.|| |’ `_.-’
                                            ’-.||_/.-’

         
         '), nl.


locationDetailedDescription(anotherhiddenroom):-
        write('The room is barley lit and there is a bad odur that fills the room'),  nl,
        write('On your right there is the greatHall'),  nl,
        write('On your left there is a huge statue.'),
        write('
   ,     .
        /(     )\\               A
   .--.( `.___.’ ).--.         /_\\
   `._ `%_&%#%$_ ’ _.’     /| <___> |\\
      `|(@\\*%%/@)|’       / (  |L|  ) \\
       |  |%%#|  |       J d8bo|=|od8b L
        \\ \\$#%/ /        | 8888|=|8888 |
        |\\|%%#|/|        J Y8P"|=|"Y8P F
        | (.".)%|         \\ (  |L|  ) /
    ___.’  `-’  `.___      \\|  |L|  |/
  .’#*#`-       -’$#*`.       / )|
 /#%^#%*_ *%^%_  #  %$%\\    .J (__)
 #&  . %%%#% ###%*.   *%\\.-’&# (__)
 %*  J %.%#_|_#$.\\J* \\ %’#%*^  (__)
 *#% J %$%%#|#$#$ J\\%   *   .--|(_)
 |%  J\\ `%%#|#%%’ / `.   _.’   |L|
 |#$%||` %%%$### ’|   `-’      |L|
 (#%%||` #$#$%%% ’|            |L|
 | ##||  $%%.%$%  |            |L|
 |$%^||   $%#$%   |            |L|
 |&^ ||  #%#$%#%  |            |L|
 |#$*|| #$%$$#%%$ |\\\\           |L|
 ||||||  %%(@)$#  |\\\\          |L|
 `|||||  #$$|%#%  | L|         |L|
      |  #$%|$%%  | ||l        |L|
      |  ##$H$%%  | |\\\\        |L|
      |  #%%H%##  | |\\\\|       |L|
      |  ##% $%#  | Y|||       |L|
      J $$#* *%#% L  |E/
      (__ $F J$ __)  F/
      J#%$ | |%%#%L
      |$$%#& & %%#|
      J##$ J % %%$F
       %$# * * %#&
       %#$ | |%#$%
       *#$%| | #$*
      /$#’ ) ( `%%\\
     /#$# /   \\ %$%\\
    ooooO’     `Ooooo
        
        '),    
        nl.


locationDetailedDescription(statue) :-
        workingOrder(statue),
        write('On your right is the hidden room'), nl,
        write('Is this the work of the alchemist outside the dungeon? you ponder.'), nl.

locationDetailedDescription(statue) :-
        write('On your right is the hidden room'), nl,
        write('Dont attack again or it might comeback to life. equal exchange of energy'), nl.

/*#######################################################################################################*/
/*                                   Starts game automatically.                                          */
/*#######################################################################################################*/

intro :-
       write('

                                            |>>>                        |>>>
                                            |                           |
                                        _  _|_  _                   _  _|_  _
                                       | |_| |_| |                 | |_| |_| |
                                       \\  .      /     Castle      \\ .    .  /
                                       \\    ,  /     Adventure    \\    .  /
                                         | .   |_   _   _   _   _   _| ,   |
                                         |    .| |_| |_| |_| |_| |_| |  .  |
                                         | ,   | .    .     .      . |    .|
                                         |   . |  .     . .   .  ,   |.    |
                             ___----_____| .   |.   ,  _______   .   |   , |---~_____
                        _---~            |     |  .   /+++++++\\    . | .   |         ~---_
                                         |.    | .    |+++++++| .    |   . |              ~-_
                                      __ |   . |   ,  |+++++++|.  . _|__   |                 ~-_
                             ____--`~    ’--~~__ .    |++++ __|----~    ~`---,              ___^~-__
                        -~--~                   ~---__|,--~’                  ~~----_____-~’   `~----~
'), nl,
       instructions, % gives user instructions to the game.
       lookAround.  % tells user what other locations + items are avalible.
:- intro.

/*#######################################################################################################*/
/*                                           The end                                                     */
/*#######################################################################################################*/