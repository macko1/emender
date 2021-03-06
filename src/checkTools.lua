-- Module that checks if all tools needed to run selected tests are installed.
-- Copyright (C) 2015 Pavel Tisnovsky
--
-- This file is part of Emender.
--
-- Emender is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; version 3 of the License.
--
-- Emender is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with Emender.  If not, see <http://www.gnu.org/licenses/>.
--



--
-- Module name
--
local checkTools = {
}



--
-- Checks if all tools described in the 'requires' metadata
-- are installed on the system where Emender is started.
--
function checkForAllTools(testSuite, testSuiteName)
    -- fetch all informations about the test
    local test = _G[testSuiteName]

    -- if the test does not exist, print error message and skip
    -- all other processing
    if not test then
        print("Test structure error: test " .. testSuiteName .. " are not loaded properly")
        return false
    end

    -- try to fetch test metadata
    local requires = test["requires"]

    -- no external tools needed -> everything is ok in this step
    -- (note that "not nil" condition can't be used here because we need to
    --  distinguish between "false" and "nil)
    if requires == nil then
        return true
    else
        -- make sure the test structure is correct, ie if the 'requires'
        -- metadata is table (and not other type)
        if type(requires) == "table" then
            return toolsChecker.performCheck(true, requires, false)
        else
            print("Test structure error: wrong 'requires' attribute - table expected")
            return false
        end
    end
end



-- export module 
return checkTools

