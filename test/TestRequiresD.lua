-- TestRequiresD.lua - check if all required tools are available.
-- This test contains 'requires' metadata which has wrong type.
--
-- Copyright (C) 2014, 2015 Pavel Tisnovsky
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

TestRequiresD = {
    -- required field
    metadata = {
        description = "Check that docunit core works correctly.",
        authors = "Pavel Tisnovsky",
        emails = "ptisnovs@redhat.com",
        changed = "2015-05-27",
        tags = {"BasicTest", "SmokeTest", "RequireMetadataTest"},
    },
    -- check if the Emender core work properly with 'requires' attribute
    -- that has wrong type
    requires = 1
}



--
-- Set up function.
--
function TestRequiresD.setUp()
    pass("TestRequiresD.setUp()")
end



--
-- Just a dummy test function that shoult always pass. This function is
-- included here because we would like to have non-empty test.
--
function TestRequiresD.testA()
    pass("TestRequiresD.testA()")
end

