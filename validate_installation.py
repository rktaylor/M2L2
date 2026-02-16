from testcontainers.core.container import DockerContainer
#from testcontainers.core.image import DockerImage

with DockerContainer("integ") as container:
    delay = wait_for_logs(container, "Hello from docker!")
