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
          Board[$row,$column]=$PLACES
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
      ComputerSymbol=X
   else
      PlayerSymbol=X
      ComputerSymbol=O
   fi
   echo "PlayerSymbol - $PlayerSymbol"  "ComputerSymbol"- $ComputerSymbol
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
      echo "ComputerSecondChance"
   fi
}
CheckToss


TicTacToeBoard()
{
   for (( row=0; row<NUMBEROFROWS; row++ ))
   do
      for (( column=0; column<NUMBEROFCOLUMNS; column++ ))
      do
         echo -n "  ${Board[$row,$column]}  "
      done
         printf "\n"
   done
}
TicTacToeBoard


InputToBoard()
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

     if [[ "${Board[$rowIndex,$columnIndex]}" -eq "$PlayerSymbol" ]] || [[ "${Board[$rowIndex,$columnIndex]}" -eq "$ComputerSymbol" ]]
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


CheckResult()
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

 
ComputerTurn(){
#for Rows
   for ((row=0; row<NUMBEROFROWS; row++))
   do 
      if [ ${Board[$row,$column]} == $PlayerSymbol ] && [ ${Board[$(($row)),$(($column+1))]} == $PlayerSymbol ]
      then
          if [ ${Board[$row,$(($column+2))]} != $ComputerSymbol ]
          then
             Board[$row,$(($column+2))]=$ComputerSymbol
             break
          fi
      elif [ ${Board[$row,$(($column+1))]} == $PlayerSymbol ] && [ ${Board[$row,$(($column+2))]} == $PlayerSymbol ]
      then
          if [ ${Board[$row,$column]} != $ComputerSymbol ]
          then
             Board[$row,$column]=$ComputerSymbol
             break
          fi
      elif [ ${Board[$row,$column]} == $PlayerSymbol ] && [ ${Board[$row,$(($column+2))]} == $PlayerSymbol ]
      then
          if [ ${Board[$row,$(($column+1))]} != $ComputerSymbol ]
          then
             Board[$row,$(($column+1))]=$ComputerSymbol
             break
          fi
      fi
   done


#For Columns
   for ((column=0; column<NUM_OF_COLUMNS; column++))
   do
      if [ ${Board[$row,$column]} == $PlayerSymbol ] &&  [ ${Board[$(($row+1)),$column]} == $PlayerSymbol ]
      then
         if [ ${Board[$(($row+2)),$column]} != $ComputerSymbol ]
         then
            Board[$(($row+2)),$column]=$ComputerSymbol
            break
         fi
      elif [ ${Board[$(($row+1)),$column]} == $PlayerSymbol ] && [ ${Board[$(($row+2)),$column]} == $PlayerSymbol ]
      then
         if [ ${Board[$row,$column]} != $ComputerSymbol ]
         then
            Board[$row,$column]=$ComputerSymbol
            break
          fi
      elif [ ${Board[$row,$column]} == $PlayerSymbol ] && [ ${Board[$(($row+2)),$column]} == $PlayerSymbol ]
      then
         if [ ${Board[$(($row+1)),$column]} != $ComputerSymbol ]
         then
            Board[$(($row+1)),$column]=$ComputerSymbol
            break
         fi
      fi
   done


#For Diagonal
      if [ ${Board[$row,$column]} == $PlayerSymbol ] &&  [ ${Board[$(($row+1)),$(($column+1))]} == $PlayerSymbol ]
      then
         if [ ${Board[$(($row+2)),$(($column+2))]} != $ComputerSymbol ]
         then
            Board[$(($row+2)),$(($column+2))]=$ComputerSymbol
            return
         fi
      elif [ ${Board[$(($row+1)),$(($column+1))]} == $PlayerSymbol ] && [ ${Board[$(($row+2)),$(($column+2))]} == $PlayerSymbol ]
      then
         if [ ${Board[$row,$column]} != $ComputerSymbol ]
         then
            Board[$row,$column]=$ComputerSymbol
            return
          fi
      elif [ ${Board[$row,$column]} == $PlayerSymbol ] && [ ${Board[$(($row+2)),$(($column+2))]} == $PlayerSymbol ]
      then
         if [ ${Board[$(($row+1)),$(($column+1))]} != $ComputerSymbol ]
         then
            Board[$(($row+1)),$(($column+1))]=$ComputerSymbol
            return
          fi
      elif [ ${Board[$(($row+2)),$column]} == $PlayerSymbol ] &&  [ ${Board[$(($row+1)),$(($column+1))]} == $PlayerSymbol ]
      then
         if [ ${Board[$row,$(($column+2))]} != $ComputerSymbol ]
         then
            Board[$row,$(($column+2))]=$ComputerSymbol
            return
          fi
      elif [ ${Board[$(($row+1)),$(($column+1))]} == $PlayerSymbol ] && [ ${Board[$row,$(($column+2))]} == $PlayerSymbol ]
      then
         if [ ${Board[$(($row+2)),$column]} != $ComputerSymbol ]
         then
            Board[$(($row+2)),$column]=$ComputerSymbol
            return
          fi
      elif [ ${Board[$(($row+2)),$column]} == $PlayerSymbol ] && [ ${Board[$row,$(($column+2))]} == $PlayerSymbol ]
      then
         if [ ${Board[$(($row+1)),$(($column+1))]} != $ComputerSymbol ]
         then
            Board[$(($row+1)),$(($column+1))]=$ComputerSymbol
            return
          fi
      else
         while [ true ]
         do
            local row=$(( RANDOM % $NUMBEROFROWS ))
            local column=$(( RANDOM % $NUM_OF_COLUMNS ))

            if [ ${Board[$row,$column]} == $PlayerSymbol ] | [ ${Board[$row,$column]} == $ComputerSymbol ]
            then
               continue
            else
               Board[$row,$column]=$ComputerSymbol
               break
            fi
         done
      fi
}

CheckForComputerWin()
{

   for ((row=0; row<NUMBEROFROWS; row++))
   do
      if [ ${Board[$row,$column]} == $ComputerSymbol ] && [ ${Board[$(($row)),$(($column+1))]} == $ComputerSymbol ]
      then
         if [ ${Board[$row,$(($column+2))]} != $PlayerSymbol ]
          then
             Board[$row,$(($column+2))]=$ComputerSymbol
             break
          fi
      elif [ ${Board[$row,$(($column+1))]} == $ComputerSymbol ] && [ ${Board[$row,$(($column+2))]} == $ComputerSymbol ]
      then
          if [ ${Board[$row,$column]} != $PlayerSymbol ]
          then
             Board[$row,$column]=$ComputerSymbol
             break
          fi
      elif [ ${Board[$row,$column]} == $ComputerSymbol ] && [ ${Board[$row,$(($column+2))]} == $ComputerSymbol ]
      then
          if [ ${Board[$row,$(($column+1))]} != $PlayerSymbol ]
          then
             Board[$row,$(($column+1))]=$ComputerSymbol
             break
          fi
      fi
   done

   for ((column=0; column<NUMBEROFCOLUMNS; column++))
   do
      if [ ${Board[$row,$column]} == $ComputerSymbol ] &&  [ ${Board[$(($row+1)),$column]} == $ComputerSymbol ]
      then
         if [ ${Board[$(($row+2)),$column]} != $PlayerSymbol ]
         then
            Board[$(($row+2)),$column]=$ComputerSymbol
            break
         fi
      elif [ ${Board[$(($row+1)),$column]} == $ComputerSymbol ] && [ ${Board[$(($row+2)),$column]} == $ComputerSymbol ]
      then
         if [ ${Board[$row,$column]} != $PlayerSymbol ]
         then
            Board[$row,$column]=$ComputerSymbol
            break
          fi
      elif [ ${Board[$row,$column]} == $ComputerSymbol ] && [ ${Board[$(($row+2)),$column]} == $ComputerSymbol ]
      then
         if [ ${Board[$(($row+1)),$column]} != $PlayerSymbol ]
         then
            Board[$(($row+1)),$column]=$ComputerSymbol
            break
         fi
      fi
   done

      if [ ${Board[$row,$column]} == $ComputerSymbol ] &&  [ ${Board[$(($row+1)),$(($column+1))]} == $ComputerSymbol ]
      then
         if [ ${Board[$(($row+2)),$(($column+2))]} != $PlayerSymbol ]
         then
            Board[$(($row+2)),$(($column+2))]=$ComputerSymbol
            return
         fi
      elif [ ${Board[$(($row+1)),$(($column+1))]} == $ComputerSymbol ] && [ ${Board[$(($row+2)),$(($column+2))]} == $ComputerSymbol ]
      then
         if [ ${Board[$row,$column]} != $PlayerSymbol ]
         then
            Board[$row,$column]=$ComputerSymbol
            return
          fi
      elif [ ${Board[$row,$column]} == $ComputerSymbol ] && [ ${Board[$(($row+2)),$(($column+2))]} == $ComputerSymbol ]
      then
         if [ ${Board[$(($row+1)),$(($column+1))]} != $PlayerSymbol ]
         then
            Board[$(($row+1)),$(($column+1))]=$ComputerSymbol
            return
          fi
      elif [ ${Board[$(($row+2)),$column]} == $ComputerSymbol ] &&  [ ${Board[$(($row+1)),$(($column+1))]} == $ComputerSymbol ]
      then
         if [ ${Board[$row,$(($column+2))]} != $PlayerSymbol ]
         then
            Board[$row,$(($column+2))]=$ComputerSymbol
            return
          fi
      elif [ ${Board[$(($row+1)),$(($column+1))]} == $ComputerSymbol ] && [ ${Board[$row,$(($column+2))]} == $ComputerSymbol ]
      then
         if [ ${Board[$(($row+2)),$column]} != $PlayerSymbol ]
         then
            Board[$(($row+2)),$column]=$ComputerSymbol
            return
          fi
      elif [ ${Board[$(($row+2)),$column]} == $ComputerSymbol ] && [ ${Board[$row,$(($column+2))]} == $ComputerSymbol ]
      then
         if [ ${Board[$(($row+1)),$(($column+1))]} != $PlayerSymbol ]
         then
            Board[$(($row+1)),$(($column+1))]=$ComputerSymbol
            return
          fi
      else
         return
      fi
}
CheckCorners()
{
      if [ ${Board[0,0]} != $PlayerSymbol ] && [ ${Board[0,0]} != $ComputerSymbol ]
      then
         Board[0,0]=$ComputerSymbol
         return
      elif [ ${Board[0,2]} != $PlayerSymbol ] && [ ${Board[0,2]} != $ComputerSymbol ]
      then
         Board[0,2]=$ComputerSymbol
         return
      elif [ ${Board[2,0]} != $PlayerSymbol ] && [ ${Board[2,0]} != $ComputerSymbol ]
      then
         Board[2,0]=$ComputerSymbol
         return
      elif [ ${Board[2,2]} != $PlayerSymbol ] && [ ${Board[2,2]} != $ComputerSymbol ]
      then
         Board[2,2]=$ComputerSymbol
         return
      fi
}
InputToBoard
