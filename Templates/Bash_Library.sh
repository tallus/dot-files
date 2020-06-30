#!/bin/bash

###############
# Conventions #
###############

# All scripts will start ts_ 
# All libraries will have a second part that acts as a prefix
# finally there will be an actual human readable name
# eg ts_rt_library-name.sh

# All functions will start with the prefix followed by a dot. e.g. rt.fuction_name

# all libraries will:
#       include a prefix.describe function 
#       have a #!/bin/bash line at the top
#       call this function at the end of the script, 
#       testing for -h or --help
#       so you can call the script directly 
#       to get a description of what it does
#       ditto for prefix.list_functions



# global.check_desc() is provided so functions can be made to return 
# a description if given help as an argument
# Use the following in the function:

# local description="Describe function here \n"
# if global.check_desc $1; then
#    cat EOF
#       insert descrption here
# EOF
#    return
# fi

# prefix.list_functions should normally be a wrapper 
# around global.list_functions.
# This returns the decription for all functions that contain a description
# as per above


#####################################
# Functions common to all libraries #
#####################################

# tolower !
global.tolower(){
echo $1 | tr [:upper:] [:lower:]
}

# return 0 (==true) if fed help
global.check_desc(){
local var=$(global.tolower $1)
if [[ $var == 'help' ]]; then
    return 0
else
    return 1
fi
}

#List functions library contains
global.list_functions(){
for function in $(grep '()' $0| grep -v 'global' | grep -v 'grep'); do
    function_name=$(echo $function | awk -F '(' '{print $1}')
    $function_name help
done
}


# Don't forget to replace template with actual prefix

#Describe what this library does
template.describe(){ 
#description
if global.check_desc $1; then cat <<EOF
$FUNCNAME 
Prints Description of library.
EOF
    return
fi
#function...
cat <<EOF

This file is intended as a bash library. 
Calling it directly merely  prints this description.

EOF
}

#List functions library contains
template.list_functions(){ 
#description
if global.check_desc $1; then cat <<EOF
$FUNCNAME 
Prints list of library specific functions.
EOF
    return
fi
#function...
    global.list_functions
EOF
}

template.example_function(){
#description
if global.check_desc $1; then cat <<EOF
$FUNCNAME 
Insert description here
EOF
    return
fi
#function...
}


# END OF FILE, FUNCTIONS GO ABOVE THIS LINE

# Don't forget to replace template with actual prefix

# Describe what this library does, and what it contains

if [[ $1 == "-h" || $1 == "--help" ]]; then
        template.describe
        template.list_functions
fi
