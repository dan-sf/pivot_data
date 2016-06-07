README for pivot_data
=====================

Unix command line utility used to convert tabular vertical data to horizontal data

Usage
-----

.. code-block:: bash

    usage: pivot_data.sh -x HORCOL -y VERTCOL -v VALUES -l LABEL

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

Example
-------

.. code-block:: bash

    $ cat file
    201308	data_type_1	13529
    201309	data_type_1	390
    201310	data_type_1	14145
    201311	data_type_1	23368
    201312	data_type_1	24183
    201401	data_type_1	29616
    201402	data_type_1	23753
    201308	data_type_2	24474
    201309	data_type_2	9601
    201310	data_type_2	28223
    201312	data_type_2	2239
    201401	data_type_2	89
    201402	data_type_2	11123

    $ cat file | pivot_data.sh -x 1 -y2 -v 3 -l Label
    Label	201308	201309	201310	201311	201312	201401	201402
    data_type_1	13529	390	14145	23368	24183	29616	23753
    data_type_2	24474	9601	28223	NA	2239	89	11123

