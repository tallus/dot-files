#!/bin/bash
source  /path/to/functions/being/tested
source ./ut_functions
fail_count=0
#### usage #####
# ut.fail                            echo fail and increment fail count
# ut.pass                            echo pass
# ut.test_true [function] [input]    calls ut.pass if function  return 0 
#                                    otherwise ut.fail
#ut.test_false [function] [input]    calls ut.pass if function does not return 0
#                                    otherwise ut.fail unless 127 is returned
#                                    (i.e. function/command not found)
#                                    when it calls ut.fail
# ut.test_output [function] [input] [expected-output]
#                                    returns 255 if ouput is empty
#                                    1 if input and output do not match
#                                    0 if input and output do match
#                                    it does regex match on [expected-output]
# ut.check_answer                    Returns 0 if user enters Y or y, 1 if they
#                                    enter N or n, other wise prompts for 
#                                   correct answer






if (( $fail_count > 254 )); then
    fail_count=255
    echo "Number of failed tests: 255 or greater"
else
    echo "Number of failed tests: $fail_count"
fi
exit $fail_count
