from grass_session import Session

class GrassController:
    """
    This is a lightweight wrapper around Grass GIS Python.
    The purpose is to expose core functionality that's oft-repeated
    in an easily re-usable, testable way.
    """
    def __init__(self, db: str, loc: str, maps: str = None):
        self.__GISDB = db
        self.__LOCATION = loc
        self.__MAPSET = maps
        self.sesh = Session()
        self.sesh.open(gisdb=db, location=loc, mapset=maps)
        import grass.script as grass
        self.grass_client = grass

    def __del__(self):
        """
        Kills the helper, cleans up retained resources, closes Grass.
        """
        self.sesh.close()

