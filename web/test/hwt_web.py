import unittest
from ..webui import hello_world

print(__name__)

class TestWebUi(unittest.TestCase):
    def testHelloWorld_noChange_returnsDefault(self):
        # arrange
        expected = "Hello ...world!"

        # act
        actual = hello_world()

        # assert
        self.assertEqual(actual, expected)

if __name__ == "__main__":
    unittest.main()