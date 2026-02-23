import unittest
from ..webui import hello_world

class TestWebUi(unittest.TestCase):
    """
    All tests for the WebUI module are hosted here.
    unittest depends on this class inheritance to execute.
    Test classes AND test cases (functions/methods)
    must begin with `test` for unittest's discovery to work.
    """
    def testHelloWorld_noChange_returnsDefault(self):
        """
        Naming convention for test cases:
        testComponent_Condition_Expectation
        As this example test tests the Hello World function
        in the webUI, that is the first third of the name.
        As it relies on the default behavior -- i.e.,
        does not mutate environment state before testing --
        the middle part of the name reflects that.
        Finally, the last part defines the expected result.
        """
        # arrange
        expected = "Hello ...world!"

        # act
        actual = hello_world()

        # assert
        self.assertEqual(actual, expected)

if __name__ == "__main__":
    unittest.main()