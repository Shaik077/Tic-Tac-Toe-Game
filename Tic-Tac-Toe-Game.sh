#!/bin/bash -x
NUMBEROFROWS=3
NUMBEROFCOLUMNS=3
PLACES=0
declare -A Board

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
      PlayerSymbol=O
   else
      PlayerSymbol=X
   fi
   echo "PlayerSymbol - $PlayerSymbol"
}
ChecksSymbol

CheckToss()
{
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
      PlayerTurn=1
      echo "PlayerFirstChance"
   else
      PlayerTurn=0
      echo "PlayerSecondChance"
   fi
}
CheckToss

TicTacToeBoard()
{
   for (( row=0; row<NUMBEROFROWS; row++ ))
   do
      for (( column=0; column<NUMBEROFCOLUMNS; column++ ))
      do
         echo -n "  ${board[$row,$column]}  "
      done
         printf "\n"
   done
}
TicTacToeBoard
inputToBoard()
{
  local rowIndex=''
  local columnIndex=''

  for (( row=0; row<$LENGTH; row++))
  do
  TicTacToeBoard
  read PlayerPlace

  if [ $PlayerPlace -gt $LENGTH ]
  then
     echo "Invalid"
     ((row--))
  else
  rowIndex=$(( $PlayerPlace / $NUMBEROFROWS ))
     if [ $(( $PlayerPlace % $NUMBEROFROWS )) -eq 0 ]
     then
        rowIndex=$(( $rowIndex - 1 ))
     fi

  columnIndex=$(( $PlayerPlace %  $NUMBEROFCOLUMNS ))
     if [ $columnIndex -eq 0 ]
     then
        columnIndex=$(( $columnIndex + 2 ))
     else
        columnIndex=$(( $columnIndex - 1 ))
     fi

     if [[ "${Board[$rowIndex,$columnIndex]}" -eq "$PlayerSymbol" ]] || [[ "${Board[$rowIndex,$columnIndex]}" -eq "$computerSymbol" ]]
     then
        echo "Invalid move"
        ((row--))
     fi

		Board[$rowIndex,$columnIndex]=$PlayerSymbol
		if [ $(CheckResult) -eq 1  ]
        then
           echo "You Won"
           return 0
        fi
  fi
  done
	echo "Match Tie"
}

function CheckResult()
{
   if [ $((${Board[0,0]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[0,1]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[0,2]})) -eq $(($PlayerSymbol)) ]
   then
      echo 1
   elif [ $((${Board[1,0]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[1,1]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[1,2]})) -eq $(($PlayerSymbol)) ]
   then
      echo 1
   elif [ $((${Board[2,0]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[2,1]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[2,2]})) -eq $(($PlayerSymbol)) ]
   then
      echo 1
   elif [ $((${Board[0,0]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[1,0]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[2,0]})) -eq $(($PlayerSymbol)) ]
   then
      echo 1
   elif [ $((${Board[0,1]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[1,1]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[2,1]})) -eq $(($PlayerSymbol)) ]
   then
      echo 1
   elif [ $((${Board[0,2]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[1,2]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[2,2]})) -eq $(($PlayerSymbol)) ]
   then
      echo 1
   elif [ $((${Board[0,0]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[1,1]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[2,2]})) -eq $(($PlayerSymbol)) ]
   then
      echo 1
   elif [ $((${Board[2,0]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[1,1]})) -eq $(($PlayerSymbol)) ] && [ $((${Board[0,2]})) -eq $(($PlayerSymbol)) ]
   then
      echo 1
   else
      echo 0
   fi
}  

