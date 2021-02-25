% To discover what happened to Mr. Zachery Carlisile	,younger brother of Alexa Carlisile, who was found dead inside a closed door room, 
% you need to learn where each person was, what are the means, motives and opportunites of suicide or killing. Alexa had faked her death a day before, 
% no one knew that she was awake until the morning of Zachery death

/* 1. To begin, we need to know the suspects. As per the information given by the buttler all the staff members and security were absent at 22.00, 
leaving behind 6 suspects. They are  
	Gregory Carlisile - oldest child of Alexa
	Edward Carlisile - middle child of Alexa
	Rebecca Carlisile - youngest child of Alexa
	Emma Carlisile - wife of Gregory
	Patrick Carlisile - son of Emmma and Gregory
	Mr. Fernsby - buttler of the estate
*/

male(zachery). male(gregory). male(edward). male(patrick). male(fernsby). male(montgomery).
female(rebecca). female(emma). female(alexa).


victim(zachery).


parent(alexa,gregory). parent(alexa,edward). parent(alexa,rebecca). parent(gregory,patrick). parent(emma,patrick).
spouse(gregory,emma).
sibling(alexa,zachery). sibling(alexa,montgomery). sibling(zachery,montgomery).

mother(X,Y) :-
	female(X), parent(X,Y).
father(X,Y) :-
	male(X), parent(X,Y).
child(X,Y) :-
	parent(Y,X).
wife(X,Y) :-
	female(X), male(Y), (spouse(X,Y) ; spouse(Y,X)). 
husband(X,Y) :-
	male(X), female(Y), (spouse(X,Y) ; spouse(Y,X)).
brother(X,Y) :-
	male(X), (sibling(X,Y) ; sibling(Y,X)).
sister(X,Y) :-
	female(X), (sibling(X,Y) ; sibling(Y,X)).

person(X) :- 
	male(X)
	; female(X).

relation(X,Y) :-
	mother(X,Y), (write(X), write(" is mother of "), write(Y))
	; father(X,Y), (write(X), write(" is father of "), write(Y))
	; child(X,Y), (write(X), write(" is child of "), write(Y))
	; wife(X,Y), (write(X), write(" is wife of "), write(Y))
	; husband(X,Y), (write(X), write(" is husband of "), write(Y))
	; brother(X,Y), (write(X), write(" is brother of "), write(Y))
	; sister(X,Y), (write(X), write(" is sister of "), write(Y)).

suspect(X) :- 
	person(X), \+ X == alexa, \+ X == montgomery
	

writemmo(X,Y,Z):-
	write("Murderer: "), write(X), nl,
	write("Mean: poison"), nl,
	write("Motive: "), write(Y), nl,
	write("Opportunity: "), write(Z), nl.


% 2. Investigation of Zachery Room 
% Clue 1: Door was locked from inside, a laptop, suicide letter and there were throat markings, which would mean a drug was recently taken. 
% Recent history on the laptop indicate Zachery was shopping online not something expected from suicidal. A secret door leading to a hidden path, 
% photo copy of floor plan and mystery switch from outside - would need a key to enter from outside

mean(floor_plan). 


% 3. Inspecting the suspects, we discover that Patrick (who was with Rosie, a maid), Gregory and Edward (they left the manor at half past eight) 
% have alibi, rest do not. Rebecca found butler leave the room early that afternoon (the day of investigation) and seemed a bit startled 
% when he saw Rebecca.

alibi(patrick). alibi(gregory). alibi(edward). 


% 4. We further go on to search the rooms of the suspects, starting with Rebecca.
% Clue 2: Rebecca notes writing do not match with the suicide note and the laptop logs showcase that Rebecca was on call from 9 to midnight 
% which verifies as her alibi. 

alibi(rebecca). 
% ask mam regarding this - adding an option of suicide and https://stackoverflow.com/questions/15138706/cut-and-fail-in-prolog


% 5. Next we investigate Mr. Fernsby office
% Clue 3: Painkillers - enough to kill but not the poison used (enough to make Alexa believe) and Zachery's burnt diary where he 
% confesses that he and Alexa murdered their elder brother 46 years ago and Fernsby made it look like an accident, the diary doesn't 
% match the writing on the suicide note

suicide(X) :- victim(X), !, fail.
means(fernsby, pain_killers).
motive(fernsby, "Not Letting the confession go public").


% 6. Next we investigate Emma and Gregory Room
% Clue 4: Letter from Emmas mother stating Emma is illegitimate child of Alexas brother Montgomery and claims to have witnessed Alexa 
% and Zachary Murder him. Keychain pendant for the greenhouse and the key is missing. A Bulldog Cane - a sort of secret key (check out 
% the library section) where we find out a letter that states Montgomery was ready to willingly let Alexa become the head of the family 

motive(emma, "Revenge on the family").
opportunity(emma, "With Alexa dead, and Zachery death by suicide would put her as the head of the family").


% 7. It is worth investing Greenhouse as the keychain was found in the Emma and Gregory Room
% Clue 5: Broken lab equipment, poison table showing lethal dosages for the poison to kill Zachery. Circle on the table: gender Female, 
% age 65 - 76, 60 - 64 kg 

next_in_line(X):- 
	X = alexa.
means(emma, poison).


% 8. We need to take into consider who do not have an alibi

noalibiCheck(X):-
	suspect(X), \+alibi(X).


% 9. We know that Zachery was killed with poison

murderer(X):-
	noalibiCheck(X),
	means(X,poison),
	motive(X,Y),
	opportunity(X,Z),
	writemmo(X,Y,Z).
	

