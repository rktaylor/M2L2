from grass_session import Session
from ..grass_helpers import GrassController
import unittest

# these are the default paths for a conda installation
DEFAULT_GISDB = "/opt/conda/grass84"
DEFAULT_LOCATION = "demolocation"

class TestGrassInstallation(unittest.TestCase):
    def testRegion_demoLocation_nonEmptyReturn(self):
        # act
        with Session(gisdb=DEFAULT_GISDB, location=DEFAULT_LOCATION):
            import grass.script as grass
            result = grass.parse_command('g.region', flags='p')

        # assert
        self.assertTrue(len(result) > 0)

class TestGrassHelper(unittest.TestCase):
    def testSessionManagement_basicCommand_executes(self):
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
        # TODO - Grass docs don't document error contracts. Reverse engineer it.
        with self.assertRaises(Exception) as expected_error:
            controller_under_test = GrassController(
               "/not/a/real/path",
                DEFAULT_LOCATION
            )
            grass.parse_command('g.region', flags='p')

if __name__ == "__main__":
    unittest.main()