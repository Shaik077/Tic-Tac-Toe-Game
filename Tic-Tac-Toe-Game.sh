#!/bin/bash -x
NUMBEROFROWS=3
NUMBEROFCOLUMNS=3
Places=0
PlayerSymbol=''
ComputerSymbol=''
LENGTH=$(( $NUMBEROFROWS * $NUMBEROFCOLUMNS ))

cell=1
playerCell=''
playerTurn=''
Center=''
Corner=''
Side=''
Blocked=''

declare -A Board

resetBoard()
{

   for ((row=0; row<NUMBEROFROWS; row++))
   do
      for ((column=0; j<NUMBEROFCOLUMNS; column++))
      do
         Board[$row,$column]=$Places
      done
   done
}
resetBoard

function initializeBoard()
{
   for (( row=0; row<NUMBEROFROWS; row++ ))
   do
      for (( column=0; column<NUMBEROFCOLUMNS; column++ ))
      do
         Board[$x,$y]=$cell
         ((cell++))
      done
   done
}
initializeBoard

CheckSymbol()
{
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
      PlayerSymbol=X
      ComputerSymbol=O
   else
      ComputerSymbol=X
      PlayerSymbol=O
   fi
   echo "PlayerSymbol - $PlayerSymbol"   "ComputerSymbol"- "$ComputerSymbol"
}
CheckSymbol

Checktoss()
{
   if [ $(( RANDOM%2 )) -eq 1 ]
   then
      playerTurn=1
      echo "Player should play first" 
   else
      playerTurn=0
      echo "Computer should play first"
   fi
}
Checktoss

DisplayBoard()
{
   local row=0
   local column=0
   for (( row=0; row<NUMBEROFROWS; row++ ))
   do
      for (( column=0; j<NUMBEROFCOLUMNS; column++ ))
      do
         echo -n "  ${Board[$row,$column]}  "
      done
	 printf "\n"
   done
}

inputToBoard()
{
   local rowindex=''
   local columnindex=''

   for (( row=0; row<$LENGTH; row++))
   do
      DisplayBoard
      if [ $playerTurn -eq 1 ]
      then
      read  -p "Choose input : " playerCell

         if [ $playerCell -gt $LENGTH ]
         then
            echo "invalid move"
            printf "\n"
            ((row--))
         else
            iindex=$(( $playerCell / $NUMBEROFROWS ))
               if [ $(( $playerCell % $NUMBEROFROWS )) -eq 0 ]
               then
                  rowindex=$(( $rowindex - 1 ))
               fi

            columnindex=$(( $playerCell %  $NUMBEROFCOLUMNS ))
               if [ $columnindex -eq 0 ]
               then
                  columnindex=$(( $columnindex + 2 ))
               else
                  columnindex=$(( $columnindex - 1 ))
               fi

               if [ "${Board[$rowindex,$columnindex]}" == "$PlayerSymbol" ] || [ "${Board[$rowindex,$columnindex]}" == "$ComputerSymbol" ]
               then
                  echo "invalid move"
                  printf "\n"
                  ((row--))
               else
                  Board[$rowindex,$columnindex]=$PlayerSymbol
                  playerTurn=0

                  if [ $(checkWinner $PlayerSymbol) -eq 1  ]
                  then
                     echo "You Won"
                     return 0
                  fi
               fi
            fi
      else
         checkForComputerWin
         if [ $(checkWinner $ComputerSymbol) -eq 1  ]
         then
            echo "Computer Won"
            return 0
         fi
         computerTurn
         if [[ $Blocked == true ]]
         then
            Blocked=false
         else
            checkCornersCenterSides
            if [ $Corner == true ] || [ $Center == true ] || [ $Side == true ]
               then
                  Corner=false
                  Center=false
                  Side=false
            fi
         fi
         playerTurn=1
      fi
   done
   echo "Match Tie"
}

checkWinner()
{
   local symbol=$1

   if [ ${Board[0,0]} == $symbol ] && [ ${Board[0,1]} == $symbol ] && [ ${Board[0,2]} == $symbol ]
   then
      echo 1
   elif [ ${Board[1,0]} == $symbol ] && [ ${Board[1,1]} == $symbol ] && [ ${Board[1,2]} == $symbol ]
   then
      echo 1
   elif [ ${Board[2,0]} == $symbol ] && [ ${Board[2,1]} == $symbol ] && [ ${Board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${Board[0,0]} == $symbol ] && [ ${Board[1,0]} == $symbol ] && [ ${Board[2,0]} == $symbol ]
   then
      echo 1
   elif [ ${Board[0,1]} == $symbol ] && [ ${Board[1,1]} == $symbol ] && [ ${Board[2,1]} == $symbol ]
   then
      echo 1
   elif [ ${Board[0,2]} == $symbol ] && [ ${Board[1,2]} == $symbol ] && [ ${Board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${Board[0,0]} == $symbol ] && [ ${Board[1,1]} == $symbol ] && [ ${Board[2,2]} == $symbol ]
   then
      echo 1
   elif [ ${Board[2,0]} == $symbol ] && [ ${Board[1,1]} == $symbol ] && [ ${Board[0,2]} == $symbol ]
   then
      echo 1
   else
      echo 0
   fi
}

computerTurn()
{
#is
   if [[ $Blocked == false ]]
   then
      for ((row=0; row<NUMBEROFROWS; row++))
      do
         if [ ${Board[$row,$column]} == $PlayerSymbol ] && [ ${Board[$(($row)),$(($column+1))]} == $PlayerSymbol ]
         then
           if [ ${Board[$row,$(($column+2))]} != $ComputerSymbol ]
           then
              Board[$row,$(($column+2))]=$ComputerSymbol
              Blocked=true
              break
           fi
         elif [ ${Board[$row,$(($column+1))]} == $PlayerSymbol ] && [ ${Board[$row,$(($column+2))]} == $PlayerSymbol ]
         then
            if [ ${Board[$row,$column]} != $ComputerSymbol ]
            then
               Board[$row,$column]=$ComputerSymbol
               Blocked=true
               break
            fi
         elif [ ${Board[$row,$column]} == $PlayerSymbol ] && [ ${Board[$row,$(($column+2))]} == $PlayerSymbol ]
         then
            if [ ${Board[$row,$(($column+1))]} != $ComputerSymbol ]
            then
               Board[$row,$(($column+1))]=$ComputerSymbol
               Blocked=true
               break
            fi
         fi
      done

#columns
   elif [[ $Blocked == false ]]
   then
      for ((column=0; column<NUMBEROFCOLUMNS; column++))
      do
         if [ ${Board[$row,$column]} == $PlayerSymbol ] &&  [ ${Board[$(($row+1)),$column]} == $PlayerSymbol ]
         then
            if [ ${Board[$(($row+2)),$column]} != $ComputerSymbol ]
            then
               Board[$(($row+2)),$column]=$ComputerSymbol
               Blocked=true
               break
            fi
         elif [ ${Board[$(($row+1)),$column]} == $PlayerSymbol ] && [ ${Board[$(($row+2)),$column]} == $PlayerSymbol ]
         then
            if [ ${Board[$row,$column]} != $ComputerSymbol ]
            then
               Board[$row,$column]=$ComputerSymbol
               Blocked=true
               break
            fi
         elif [ ${Board[$row,$column]} == $PlayerSymbol ] && [ ${Board[$(($row+2)),$column]} == $PlayerSymbol ]
         then
            if [ ${Board[$(($row+1)),$column]} != $ComputerSymbol ]
            then
               Board[$(($row+1)),$column]=$ComputerSymbol
               Blocked=true
               break
            fi
         fi
      done

#Diagonal

   elif [[ $Blocked == false ]]
   then

      if [ ${Board[$row,$column]} == $PlayerSymbol ] &&  [ ${Board[$(($row+1)),$(($column+1))]} == $PlayerSymbol ]
      then
         if [ ${Board[$(($row+2)),$(($column+2))]} != $ComputerSymbol ]
         then
            Board[$(($row+2)),$(($column+2))]=$ComputerSymbol
            Blocked=true
            return
         fi
      elif [ ${Board[$(($row+1)),$(($column+1))]} == $PlayerSymbol ] && [ ${Board[$(($row+2)),$(($column+2))]} == $PlayerSymbol ]
      then
         if [ ${Board[$row,$column]} != $ComputerSymbol ]
         then
            Board[$row,$column]=$ComputerSymbol
            Blocked=true
            return
          fi
      elif [ ${Board[$row,$column]} == $PlayerSymbol ] && [ ${Board[$(($row+2)),$(($column+2))]} == $PlayerSymbol ]
      then
         if [ ${Board[$(($row+1)),$(($column+1))]} != $ComputerSymbol ]
         then
            Board[$(($row+1)),$(($column+1))]=$ComputerSymbol
            Blocked=true
            return
          fi
      elif [ ${Board[$(($row+2)),$column]} == $PlayerSymbol ] &&  [ ${Board[$(($row+1)),$(($column+1))]} == $PlayerSymbol ]
      then
         if [ ${Board[$row,$(($column+2))]} != $ComputerSymbol ]
         then
            Board[$row,$(($column+2))]=$ComputerSymbol
            Blocked=true
            return
          fi
      elif [ ${Board[$(($row+1)),$(($column+1))]} == $PlayerSymbol ] && [ ${Board[$row,$(($column+2))]} == $PlayerSymbol ]
      then
         if [ ${Board[$(($row+2)),$column]} != $ComputerSymbol ]
         then
            Board[$(($row+2)),$column]=$ComputerSymbol
            Blocked=true
            return
          fi
      elif [ ${Board[$(($row+2)),$column]} == $PlayerSymbol ] && [ ${Board[$row,$(($column+2))]} == $PlayerSymbol ]
      then
         if [ ${Board[$(($row+1)),$(($column+1))]} != $ComputerSymbol ]
         then
            Board[$(($row+1)),$(($column+1))]=$ComputerSymbol
            Blocked=true
            return
         fi
      fi
   fi
}


checkForComputerWin()
{
#Rows
   for ((row=0; row<NUMBER_OF_ROWS; row++))
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

#columns
   for ((column=0; column<NUMBER_OF_COLUMNS; column++))
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

#Diagonal
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

checkCornersCenterSides()
{
      if [ ${Board[0,0]} != $PlayerSymbol ] && [ ${Board[0,0]} != $ComputerSymbol ]
      then
         Board[0,0]=$ComputerSymbol
         Corner=true
      elif [ ${Board[0,2]} != $PlayerSymbol ] && [ ${Board[0,2]} != $ComputerSymbol ]
      then
         Board[0,2]=$ComputerSymbol
         Corner=true
      elif [ ${Board[2,0]} != $PlayerSymbol ] && [ ${Board[2,0]} != $ComputerSymbol ]
      then
         Board[2,0]=$ComputerSymbol
         Corner=true
      elif [ ${Board[2,2]} != $PlayerSymbol ] && [ ${Board[2,2]} != $ComputerSymbol ]
      then
         Board[2,2]=$ComputerSymbol
         Corner=true
      elif [ ${Board[1,1]} != $PlayerSymbol ] && [ ${Board[1,1]} != $ComputerSymbol ]
      then
         Board[1,1]=$ComputerSymbol
         Center=true
      elif [ ${Board[0,1]} != $PlayerSymbol ] && [ ${Board[0,1]} != $ComputerSymbol ]
      then
         Board[0,1]=$ComputerSymbol
         Side=true
      elif [ ${Board[1,2]} != $PlayerSymbol ] && [ ${Board[1,2]} != $ComputerSymbol ]
      then
         Board[1,2]=$ComputerSymbol
         Side=true
      elif [ ${Board[2,1]} != $PlayerSymbol ] && [ ${Board[2,1]} != $ComputerSymbol ]
      then
         Board[2,1]=$ComputerSymbol
         Side=true
      elif [ ${Board[1,0]} != $PlayerSymbol ] && [ ${Board[1,0]} != $ComputerSymbol ]
      then
         Board[1,0]=$ComputerSymbol
         Side=true
      fi
}
inputToBoard
DisplayBoard
