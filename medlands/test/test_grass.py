from grass_session import Session
import unittest

print(__name__)

class TestGrassInstallation(unittest.TestCase):
    def testRegion_demoLocation_nonEmptyReturn(self):
        # arrange
        GISDB = "/opt/conda/grass84"
        LOCATION = "demolocation"

        # act
        with Session(gisdb=GISDB, location=LOCATION):
            import grass.script as grass
            result = grass.parse_command('g.region', flags='p')

        # assert
        self.assertTrue(len(result) > 0)

if __name__ == "__main__":
    unittest.main()