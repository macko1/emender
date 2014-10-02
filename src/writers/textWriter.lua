-- textWriter.lua - a writer for the plain text file format
-- Copyright (C) 2014 Pavel Tisnovsky

-- This file is part of Emender.

-- This program is free software:  you can redistribute it and/or modify it
-- under the terms of  the  GNU General Public License  as published by the
-- Free Software Foundation, version 3 of the License.
--
-- This program  is  distributed  in the hope  that it will be useful,  but
-- WITHOUT  ANY WARRANTY;  without  even the implied warranty of MERCHANTA-
-- BILITY or  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
-- License for more details.
--
-- You should have received a copy of the GNU General Public License  along
-- with this program. If not, see <http://www.gnu.org/licenses/>.

local textWriter = {
}

function textWriter.writeHeader(fout, results)
    fout:write("*** Emender ***\n")
end

function textWriter.writeFooter(fout, results)
    local passedTests = results.passedTests
    local failedTests = results.failedTests
    local allTests = passedTests + failedTests

    fout:write("Overall results:\n")
    fout:write("    Total: " ..(passedTests + failedTests).."\n")
    fout:write("    Passed:" ..passedTests.."\n")
    fout:write("    Failed:" ..failedTests.."\n")
    fout:write("\n(Generated by Emender)\n\n")
end

function textWriter.writeSuiteStart(fout, testSuite)
    fout:write("    Test: " .. testSuite.name .. "\n")
    fout:write("        Description: " .. testSuite.description .. "\n")
    fout:write("        Authors:     " .. testSuite.authors .. "\n")
    fout:write("        Modified:    " .. testSuite.modified .. "\n")
    local tagsStr = ""
    if type(testSuite.tags) == "table" then
        for _,tag in ipairs(testSuite.tags) do
             tagsStr = tagsStr .. tag .. " "
        end
    else
        tagsStr = testSuite.tags
    end
    fout:write("        Tags:        " .. tagsStr .. "\n")
end

function textWriter.writeSuiteEnd(fout, testSuite)
    local passed = testSuite.passCount
    local failed = testSuite.failCount
    local errors = testSuite.errorCount
    local total  = testSuite.total
    fout:write("            Summary:\n")
    fout:write("                Passed: " .. passed .. "\n")
    fout:write("                Failed: " .. failed .. "\n")
    fout:write("                Error:  " .. errors .. "\n")
    fout:write("                ----------\n")
    fout:write("                Total:  " .. total .. "\n")
    fout:write("\n")
end

function textWriter.writeCaseStart(fout, testCaseInfo)
    local functionName = testCaseInfo.name
    fout:write("            Test method: " .. functionName .. "\n")
end

function textWriter.writeCaseEnd(fout, testCaseInfo)
    local pass   = testCaseInfo.pass
    local fail   = testCaseInfo.fail
    local info   = testCaseInfo.info
    local errors = testCaseInfo.errors

    fout:write("                ---------\n")
    fout:write("                Pass:  " .. pass .. "\n")
    fout:write("                Fail:  " .. fail .. "\n")
    fout:write("                Info:  " .. info .. "\n")
    fout:write("                Error: " .. errors .. "\n")
    fout:write("\n");
end

function textWriter.writeTestPass(fout, testName, message)
    local msg = message[2] or "(unknown)"
    fout:write("                PASS: " .. msg .. "\n")
end

function textWriter.writeTestFail(fout, testName, message)
    local msg = message[2] or "(unknown)"
    fout:write("                FAIL: " .. msg .. "\n")
end

function textWriter.writeTestInfo(fout, testName, message)
    local msg = message[2] or "(unknown)"
    fout:write("                INFO: " .. msg .. "\n")
end

function textWriter.writeTestError(fout, testName, message)
    local msg = message[2] or "(unknown)"
    fout:write("                ERROR: " .. msg .. "\n")
end

return textWriter
