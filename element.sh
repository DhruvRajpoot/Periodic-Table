#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using(type_id) where atomic_number=$1;")
    echo $ELEMENT | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME MASS MP BP TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
    done


  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
    ELEMENT=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using(type_id) where symbol='$1';")
    echo $ELEMENT | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME MASS MP BP TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
    done

  elif [[ $1 =~ ^[A-Z][a-z]*$ ]]
  then
    ELEMENT=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using(type_id) where name='$1';")
    echo $ELEMENT | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME MASS MP BP TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
    done

  else
    echo "I could not find that element in the database."
  fi
fi