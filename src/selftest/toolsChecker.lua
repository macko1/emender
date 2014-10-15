-- Tools checker module.
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



--
-- Data structure that holds all exported variables and functions
--
local toolsChecker = {
    requiredTools = {"curl", "wget", "xmllint"}
}



--
-- Check if given command exists (and could be started)
--
function commandExists(command)
    -- run the given command
    -- NOTE: it does not work properly for interactive commands
    local process = io.popen(command .. " 2> /dev/null")
    -- read exit value (might indicate error) and process return code
    local exitValue, signal, code = process:close()
    -- TODO: is this code always stable?
    return code ~= 127
end



--
-- Print a message when some external tool is about to be checked about its presence.
--
function commandCheckMessage(command, result)
    print("Checking existence of command '" ..  command .. "': " .. result)
end



--
-- Perform check if all required commands are installed.
-- If any of required tools is not intalled, the process fail.
--
function toolsChecker.performCheck()
    -- loop over all required tools
    for _, command in ipairs(toolsChecker.requiredTools) do
        -- check for tool existence
        local exists = commandExists(command)
        if not exists then
            commandCheckMessage(command, "error")
            print("Failure, this tool can't be started properly.")
            os.exit(1)
        else
            commandCheckMessage(command, "OK")
        end
    end
end



--
-- Export the module API
--
return toolsChecker

