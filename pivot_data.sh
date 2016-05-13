#!/bin/bash

#------------------
# Pivot data script
#------------------

# Usage function
function usage
{
	echo "
	usage: $0 options

	This script will convert vertical data into a horizontal table

	EXAMPLE:
		cat vertical_data.txt | /users/dfowler/bin/pivot_data.sh -x 1 -y 2 -v 3 -l LABEL

	OPTIONS:
	   -h      Show this message
	   -x      x column (Ex. the date column, REQUIRED)
	   -y      y column (Ex. the label column, REQUIRED)
	   -v      value column (One based column number of the uid, REQUIRED)
	   -l      Label string (Will default to empty string if omitted)

	All columns are one based.
	"
}

function main {
	gawk -v x_col=$1 -v y_col=$2 -v val_col=$3 -v label=$4 'BEGIN{FS="\t";OFS="\t"}{
		x_arr[$x_col];
		y_arr[$y_col];
		val_arr[$x_col,$y_col] = $val_col;
	}END{
		printf label
		asorti(x_arr,X);
		for (x=1; x in X; x++) {
			printf "\t%s",X[x]
		}
		print ""
		for (y in y_arr) {
			printf "%s", y
			for (x=1; x in X; x++) {
				if (val_arr[X[x],y]=="")
					printf "\tNA"
				else
					printf "\t%s",val_arr[X[x],y]
			}
			print ""
		}
	}'
}

# If no options are presant print usage
if [[ "$#" -eq 0 ]]; then
	usage; exit 1;
fi

# While loop for reading in args
while getopts ":x:y:v:l:h" OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         x)
             x_col=$OPTARG
             ;;
         y)
             y_col=$OPTARG
             ;;
         v)
             val_col=$OPTARG
             ;;
         l)
             label=$OPTARG
             ;;
         ?)
             usage
             exit 1
             ;;
     esac
done

# Check and see if the x, y, and v args are there
if [[ -z $x_col || -z $y_col || -z $val_col ]]; then
	usage; exit 1;
fi

# Run main function
main $x_col $y_col $val_col $label;

exit 0;

