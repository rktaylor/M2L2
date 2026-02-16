- Remove DistroBox section as the legacy UI no longer needed
- Switch MacOS docs to just use the `brew install --cask podman-desktop`
- Build a different version of the container image for Apple Silicon. 
- Don't need 7.4 and Fedora as hard requirements.
- README: podman build needs a docker flag
>podman build --format docker -t 
- TESTS:
    - Validation Installation: Should check that all host requirements are working, e.g., should be able to see if podman machine is up, should try to pull a hello world container and assert on the output, that sort of thing.
    - Web UI test (external): 
- Tests organized in a hierarchy. Anything in the root/test runs outside the container. Anything in medlands/ or web/ is tested inside the container.
- Simple orchestration script that runs all tests. AT FIRST THESE CAN BE STUBBED. this should trigger a podman build/podman run sequence, but with a different entry point, so that in testing mode, it launches the internal tests.
- GRADIO: UI should allow for setting environment variables for stuff like Grass and paths in Data.
- Move test data in
- Test GRASS install by pointing to its demolocation permanent mapset and running a hello world


(base) mambauser@e463443a1bc5:/medlands/app$ grass --text /opt/conda/grass84/demolocation/PERMANENT --exec "g.gisenv"   
GISDBASE=/opt/conda/grass84
LOCATION_NAME=demolocation
MAPSET=PERMANENT
GUI=text

Potentially useful: https://deepwiki.com/containers/podman-compose/4.2-testing-framework

https://testinfra.readthedocs.io/en/latest/backends.html

https://testcontainers.com/guides/getting-started-with-testcontainers-for-python/