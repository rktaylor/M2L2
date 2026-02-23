from grass_session import Session
from ..grass_helpers import GrassController
import unittest

# these are the default paths for a conda installation
DEFAULT_GISDB = "/opt/conda/grass84"
DEFAULT_LOCATION = "demolocation"

class TestGrassInstallation(unittest.TestCase):
    """
    Tests the *installation* of Grass itself.
    Basic sanity check. Intentionally only uses Grass-provided code
    (i.e., not our helper client).
    """
    def testRegion_demoLocation_nonEmptyReturn(self):
        """
        Logically, this opens a Grass session with default parameters
        that should ALWAYS resolve, and then asserts that there is
        SOME data there.
        """
        # act
        with Session(gisdb=DEFAULT_GISDB, location=DEFAULT_LOCATION):
            import grass.script as grass
            result = grass.parse_command('g.region', flags='p')

        # assert
        self.assertTrue(len(result) > 0)

class TestGrassHelper(unittest.TestCase):
    """
    Tests the utility class we use to surface Grass scripting APIs.
    """
    def testSessionManagement_basicCommand_executes(self):
        """
        Creates a GrassController and uses it to run a command
        that should always resolve. Asserts the output is not empty.
        If Grass throws an error, this test will fail (that's a good thing).
        """
        # arrange
        controller_under_test = GrassController(
            DEFAULT_GISDB,
            DEFAULT_LOCATION
        )
        grass = controller_under_test.grass_client

        # act
        result = grass.parse_command('g.region', flags='p')

        # assert
        self.assertTrue(len(result) > 0)

    def testRegion_invalidLocation_raisesError(self):
        """
        Creates a GrassController with invalid configuration.
        Should error immediately.
        """
        # TODO - Grass docs don't document error contracts. Reverse engineer it.
        with self.assertRaises(Exception) as expected_error:
            controller_under_test = GrassController(
               "/not/a/real/path",
                DEFAULT_LOCATION
            )
            grass.parse_command('g.region', flags='p')

if __name__ == "__main__":
    unittest.main()