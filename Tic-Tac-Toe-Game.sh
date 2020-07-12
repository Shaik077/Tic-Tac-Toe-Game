#!/bin/bash
NUMBEROFROWS=3
NUMBEROFCOLUMNS=3
BOARD_SIZE=$(($NUMBEROFROWS*$NUMBEROFCOLUMNS))
PlayerSymbol="o"
ComputerSymbol="o"
Blocked=false
valid=false
position=0
count=0
declare -a board
function resetBoard(){
	for (( position=1; position<=$BOARD_SIZE ; position++ )) do
    	board[$position]=0
 done
}
displayBoard(){
	for (( count=1; count<=$BOARD_SIZE ; count++ ))
	do
        	if [ "${board[$count]}" == "0" ]
         	then
			printf  _"|"
        	else
	        	printf ${board[$count]}"|"
         fi
		if [ $(( $count % $NUMBEROFROWS )) -eq 0 ]
		then
			echo
		fi
		done
	}

assignSymbol(){
	Check=$((RANDOM%2))
		if [ $Check -eq  0 ]
                then
				PlayerSymbol="X"
		else
				ComputerSymbol="X"
		fi
		echo "PlayerSymbol" $PlayerSymbol    "ComputerSymbol" $ComputerSymbol
	}
toss(){
		check=$((RANDOM%2))
		if [ $check -eq 0 ]
		then
			PlayerTurn=1
                     echo "PlayerfirstChane"
		else
			playerTurn=0
                   echo "ComputerfirstChane"
   	fi
	}
Position(){
	if [ "$cell" == "false" ]
        then

        	if [ "$1" -gt "0"  -a "$1" -le "$BOARD_SIZE" ]
		 then
			valid=true
		fi
				if [ "$valid" == "true" -a "${board[$1]}" == "0" ]
				then
					board[$1]=$2
					cell=true
				else
					valid=false
				fi
		fi
	}
computerTurn(){
	if [ "$cell" == "false" ]
      	then
		while [ "$valid" == "false" ]
	        	do
			   number=$((RANDOM%BOARD_SIZE+1))
			Position $number $ComputerSymbol
			done
				valid=false
		fi
	}
userPlays(){
		while [ "$valid" == "false" ]
		do
		read -p "Please enter the number between 1-$BOARD_SIZE where insert your $PlayerSymbol in board " input;
		Position $input $PlayerSymbol
		if [ "$valid" == "false" ]
		then
			echo "Invalid User Input"
		fi
		done
	}
winnerDisplay(){
		if [ "$1" == "$PlayerSymbol" ]
		then
		echo "You won"
		else
		echo "Computer won"
		fi
	}
countRowSize(){
	count==$ROW_SIZE
         winnerDisplay $1
         Blocked=true
	}

	function diagonal(){
		if [ "$cell" == "false" ]
        then
			local count=0
			for (( position=1; position <= $BOARD_SIZE; position+=$((ROW_SIZE+1))  )) 
			do
			if [ ${board[$position]} == $1 ]
				then
					((count++))
			elif [ "$cell" == "0" -a "${board[$position]}" == "0" ]
       		then
          		cell=$position
			fi
			done
			if [ $count -eq $ROW_SIZE ]
				then
					countRowSize
			elif [ $count -ne $(($ROW_SIZE-1)) ]
	      	then
	                cell=0
			fi
		fi
	}
diagonal(){
	if [ "$cell" == "false" ]
      then
			local cell=0
     		local count=0
			for (( position=$NUMBEROFROWS; position <= $((BOARD_SIZE-NUMBEROFCOLUMNS+1)); position+=$((NUMBEROFCOLUMNS-1)) ))
				do
       			if [ ${board[$position]} == $1 ]
      				then
       					(( count++ ))
		 			elif [ "$cell" == "0" -a "${board[$position]}" == "0" ]
 						then
							cell=$position
 		 			fi
      		done
     			if [ $count == $NUMBEROFROWS ]
  		  			then
						countRowSize
     			elif [ $count -ne $(($NUMBEROFCOLUMNS-1)) ]
        			then
	        			cell=0
     			fi
	fi
	}

	function row(){
	if [ "$cell" == "false" ]
		then
		local count=0
        for (( row=0;row<$NUMBEROFROWS;row++ ))
			do
          count=0
          cell=0
          for (( col=1; col<=$NUMBEROFCOLUMNS; col++ ))
			 do
            position=$((NUMBEROFROWS*row+col ))
         	if [ ${board[$position]} == $1 ]
      		then
               (( count++ ))
            elif [ "$cell" == "0" -a "${board[$position]}" == "0" ]
            then
               cell=$position
            fi
  	         done
				if [ $count == $NUMBEROFROWS ]
				then
					countRowSize
  	        	elif [ $count -ne $(( NUMBEROFCOLUMNS-1 )) ]
  	        	then
                cell=0
				else
					break
            fi
        done
	fi
	}
column(){
		if [ "$cell" == "false" ]
        then
		local count=0
		for (( col=1;col<=$NUMBEROFCOLUMNS;col++ ))
			do
        	count=0
         cell=0
         for (( row=0; row<=$NUMBEROFROWS; row++ ))
			do
          	position=$((NUMBEROFROWS*row+col ))
         	if [ "${board[$position]}" == "$1" ]
				then
               (( count++ ))
             elif [ "$cell" == "0" -a "${board[$position]}" == "0" ]
				 then
					cell=$position
             fi
        	done
			if [ $count == $ROW_SIZE ]
         then
            countRowSize
         elif [ $count -ne $(( ROW_SIZE-1 )) ]
         then
             cell=0
			 else
            	break
       	 fi
     		done
		fi
		}

block(){
row $PlayerSymbol
Position $cell $ComputerSymbol
column $PlayerSymbol
Position $cell $ComputerSymbol
diagonal $PlayerSymbol
Position $cell $ComputerSymbol
diagonal $PlayerSymbol
Position $cell $ComputerSymbol
	}

corners(){
if [ $cell == "false" ]
 then
	local position=1

		Position 1 $ComputerSymbol
		position=$((NUMBEROFROWS*0+NUMBEROFCOLUMNS))
		Position $position $ComputerSymbol
		position=$(( NUMBEROFROWS*$((NUMBEROFCOLUMNS-1)) + 1))

		Position $position $ComputerSymbol
		position=$(( NUMBEROFROWS*$((NUMBEROFCOLUMNS-1)) + NUMBEROFCOLUMNS))
		Position $position $ComputerSymbol
	fi
	}

winnerChecker(){
		rowChecker $ComputerSymbol
		Position $cell $ComputerSymbol

		column $ComputerSymbol
		Position $cell $ComputerSymbol

		diagonal $ComputerSymbol
		Position $cell $ComputerSymbol

		diagonal $ComputerSymbol
		Position $cell $ComputerSymbol
	}
centre()
	{
	 if [ "$cell" == "false" ]
		then
			centremid=$((ROW_SIZE/2))
			position=$(( $(( NUMBEROFROWS*centremid)) + $((NUMBEROFROWS-centremid)) ))
			Position $position $ComputerSymbol
		fi
	}
PossibleWins(){
		diagonal $1
		diagonal $1
		rowChecker $1
		column $1
	}

sides()
   {
		local side=0
   if [ $cell == "false" ]
   then
   for (( "side"="1"; "side"<="$NUMBEROFROWS"; side++ ))
   do
      position=side
      Position $position $ComputerSymbol
   done

   for (( "side=1"; "side"<="$BOARD_SIZE"; side+=$NUMBEROFROWS ))
   do
      position=side
      Position $position $ComputerSymbol
   done

   for (( "side"="$((BOARD_SIZE-NUMBEROFROWS+1))"; "side"<="$BOARD_SIZE"; side++ ))
   do
      position=side
      Position $position $ComputerSymbol
   done
   for (( "side"="$NUMBEROFROWS"; "side"<="$BOARD_SIZE"; side++ ))
   do
      position=side
      Position $position $ComputerSymbol
   done
   fi
   }
Plays(){
	winnerChecker
	block
	corners
	centre
	sides
	computerPlay
	}
GameEnd()
	{
	local count=0
	for elements in ${board[@]}
	do
		if [ $elements == "0" ]
		then
			((count++))
		fi
		if [ $count -gt 0 ]
		then
			break
		fi
	done
	if [ $count -eq 0  -a $Blocked == "false" ]
	then
		Blocked=true
	fi
	}
reset(){
	 valid=false
         cell=false
	}
TicTacToe()
	{
		resetBoard
		assignSymbol
		toss
		while [ $Blocked == false ]
		do
			resetter
			if [ $first == user ]
			then
				displayBoard
				userPlays
				resetter
				PossibleWins $PlayerSymbol
				GameEnd
				playerTurn=0
			fi
			if [ $playerTurn == 0 -a $Blocked == false ]
			then
				Plays
				reset
				PossibleWins $ComputerSymbol
				GameEnd
				playerTurn=0 
			fi
		done
	displayBoard
	}
TicTacToe
