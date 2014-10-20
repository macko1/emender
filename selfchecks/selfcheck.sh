#!/usr/bin/env bash

# Emender selfcheck - this script tries to run Emender using several command
# line options and check if the output is the same as expected output.
#
# This file is part of Emender.
#
# Emender is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 3 of the License.
#
# Emender is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Emender.  If not, see <http://www.gnu.org/licenses/>.
#



# Counters of all tests, passed tests and failed tests
test_cnt=0
pass_cnt=0
fail_cnt=0



# Run Emender by using various CLI options and export output
function runTestsForBasicCLI {
    ../emend -V        > show_version_1.out
    ../emend --version > show_version_2.out
    ../emend -L        > show_license_1.out
    ../emend --license > show_license_2.out
    ../emend -h        > show_help_1.out
    ../emend --help    > show_help_2.out
}



# Run Emender by using various bad CLI options
function runTestsWithBadCLIOptions {
    ../emend -x                  > bad_cli_options_1.out
    ../emend --xyzzy             > bad_cli_options_2.out
    ../emend -x -h               > bad_cli_options_3.out
    ../emend -x -?               > bad_cli_options_4.out
    ../emend --xyzzy --??        > bad_cli_options_5.out
    ../emend --xyzzy --?? -v -c  > bad_cli_options_6.out
    ../emend  -v -c -V -x -y -z  > bad_cli_options_7.out
}



# Run Emender by using various bad output format
function runTestsWithBadOutputFormat {
    ../emend -o output1 ../test/TestPassFail.lua ../test/Test1.lua > bad_output_format_1.out
    ../emend -o out.    ../test/TestPassFail.lua ../test/Test1.lua > bad_output_format_2.out
    ../emend -o out..   ../test/TestPassFail.lua ../test/Test1.lua > bad_output_format_3.out
    ../emend -o out.doc ../test/TestPassFail.lua ../test/Test1.lua > bad_output_format_4.out
    ../emend -o out.X   ../test/TestPassFail.lua ../test/Test1.lua > bad_output_format_5.out
}



# Run Emender with some example tests with known output
function runTestExamples {
     ../emend ../test/TestEmpty.lua        > test_empty.out
     ../emend ../test/TestSetUp.lua        > test_setup.out
     ../emend ../test/TestSetUpOnly.lua    > test_setup_only.out
     ../emend ../test/TestTearDown.lua     > test_teardown.out
     ../emend ../test/TestTearDownOnly.lua > test_teardown_only.out
}



# Run all tests
function runAllTests {
    runTestsForBasicCLI
    runTestsWithBadCLIOptions
    runTestsWithBadOutputFormat
    runTestExamples
}



# Prepare log file containing all error messages
function prepareErrorFile {
    echo -n "" > errors.txt
}



# Compare Emender output with the expected results
function compareResults {
    # loop over all .in files with expected results
    for expected_file_name in *.in
    do
        # get only basename (without extension suffix and/or directory prefix)
        filename=$(basename "${expected_file_name}")
        filename="${filename%.*}"
        diff -u ${expected_file_name} ${filename}.out > ${filename}.diff
        # check the diff output
        if [[ $? != 0 ]]
        then
            echo ${filename} >> errors.txt
            let fail_cnt=fail_cnt+1
            echo "[ FAIL ]   ${filename}"
        else
            let pass_cnt=pass_cnt+1
            echo "[ PASS ]   ${filename}"
        fi
        let test_cnt=test_cnt+1
    done
}



# Print self check summary
function printSummary {
    echo
    echo "Passed: ${pass_cnt}"
    echo "Failed: ${fail_cnt}"
    echo "Total:  ${test_cnt}"
    echo "YVALUE=${test_cnt}" >> all_tests.property
    echo "YVALUE=${pass_cnt}" >> passed_tests.property
    echo "YVALUE=${fail_cnt}" >> failed_tests.property
}



# Run selfcheck
function run {
    prepareErrorFile
    runAllTests
    compareResults
    printSummary
}

run

# Only zero test failures means OK!
exit ${fail_cnt}
