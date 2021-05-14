#include "catch2/catch.hpp"

#include "Dummy.h"

SCENARIO("Dummy section")
{
    GIVEN("Nothing")
    {
        THEN("1 is always equal to 1")
        {
            REQUIRE(1 == 1);
        }
    }
}
