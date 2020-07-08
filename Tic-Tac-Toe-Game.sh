#!/bin/bash -x
NUMBEROFROWS=3
NUMBEROFCOLUMNS=3
PLACES=0
declare -A GameBoard

ResetBoard()
{

   for ((row=0; row<NUMBEROFROWS; row++))
   do
      for ((column=0; column<NUMBER_OF_COLUMNS; column++))
      do
         GameBoard[$row,$column]=$PLACES
                 ((PLACES++))  
      done
   done
}
ResetBoard

ChecksSymbol()
{
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
      PLAYERSYMBOL=X
   else
      PLAYERSYMBOL=O
   fi
   echo "PlayerSymbol - $PLAYERSYMBOL"
}
ChecksSymbol
