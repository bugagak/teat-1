#!/bin/bash
f1(){ read -p "Please enter 'movie id'(1~1682):" input;
cat $1 | sed -n "${input}p" $1;
} 

f2(){ read -p "Do you want to get the data of 'action' genre from 'u.item'?(y/n):" input;
if [ "$input"="y" ];
then cat $1 | awk -F '|' '$7==1 { print $1,$2 }'| head -n 10; fi }

f3(){ read -p "Please enter 'movie id'(1~1682):" input;
cat $2 | awk '$2=='$input' { sum+=$3; count+=1 } END { printf("average rating of input:%.5f",sum/count) }'; 
}

f4(){ read -p "Do you want to delete the 'IMDb URL'from 'u.item'?(y/n):" input;
if [ "$input"="y" ];
then  cat $1 | sed -e 's/http.*)//g' | head -n 10
fi
}

f5(){ read -p "Do you want to get the data about users from 'u.users'?(y/n):" input;
if [ "$input"="y" ];
then cat $3 | sed -e 's/M/male/g' -e 's/F/female/g' | awk -F '|' '{ printf("user %s is  %s years old %s %s\n",$1,$2,$3,$4) }' | head -n 10;
fi
}

f6(){ read -p "Do you want to Modify the format of 'release date' in 'u.item'?(y/n):" input;
if [ "$input"="y" ]
then cat $1 | sed -e "s/\([0-9]\{2\}\)-\([a-z]\{3\}\)-\([0-9]\{4\}\)/\3\2\1/gi" | tail -n 10
fi
}

f7(){ read -p "Please enter the 'user id'(1~943):" input;
cat $2 | awk '$1=='$input' { print $2 }' | sort -n | tr '\n' '|'; 
for i in range $( cat $2 | awk '$1=='$input' { print $2 }' | sort -n) 
do 
cat  $1 | awk -F '|' '$1=='$i' { printf("%s|%s\n",$1,$2) }' 
done
}


echo User Name: Lim Jeong Muk
echo Student Number: 12201785
echo [ MENU ]
echo 1. Get the data of the movie identified by a specific 'movie id' from 'u.item'
echo 2. Get the data of action genre movies from 'u.item'
echo 3. Get the average 'rating' of the movie identified by specific 'movie id' from 'u.data'
echo 4. Delete the 'IMDb URL' from 'u.item'
echo 5. Get the data about users from 'u.user'
echo 6. Modify the format of 'release data' in 'u.item'
echo 7. Get the data of movies rated by a specific 'user id' from 'u.data'
echo 8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'
echo 9. Exit
echo --------------------------
read -p "Enter your choice [ 1-9 ]" input
while true
do
    if [ $input -eq 1 ]; then f1 $1
    elif [ $input -eq 2 ]; then f2 $1
    elif [ $input -eq 3 ]; then f3 $2
    elif [ $input -eq 4 ]; then f4 $1
    elif [ $input -eq 5 ]; then f5 $3
    elif [ $input -eq 6 ]; then f6 $1
    elif [ $input -eq 7 ]; then f7 $1 $2
    else echo "Bye!"; break
    fi
    read -p "Enter your choice [ 1-9 ]" input
done
