# Introduction

Definition of some key terms:

+ _image_: a static, read-only blueprint.
+ _container_: a live, runnable instance created from an image.

Key Differences at a Glance:

| Attribute | Docker Image | Docker Container |
| --------- | ------------ | ---------------- |
| State & Mutability | Static and immutable (read-only). | Dynamic and mutable (read-write). |
| Filesystem Layers | Stack of read-only layers. | Image's read-only layers + 1 top writable layer. |
| Lifecycle | Built, tagged, pushed, and pulled via registries. | Created, started, paused, stopped, and removed (rm). |
| System Resources | Consumes only disk storage. | Consumes CPU, RAM, network interfaces, and disk I/O while active. |
| Multiplicity | One image serves as the single source of truth. | Many independent containers can run simultaneously from the same image. |


# Tools for examining docker images

+ https://github.com/wagoodman/dive - I have used this to quickly
  examine docker images and see what files were added, modified, or
  deleted in each layer.


# How to start a docker image running bash, so that it continues after docker run command completes

Starting a container from an image:
```bash
docker run -dit --name my_container <image_name> /bin/bash
```

# Working with the Running Container

Attach to the main bash session: Use docker attach to connect directly
to that background shell:
```bash
docker attach my_container
```

Tips: Press Ctrl+P followed by Ctrl+Q to detach without stopping the
container; typing exit will terminate the main bash process and stop
the container.

Open a separate shell session: Use docker exec to start a secondary bash process that you can safely exit without stopping the container:
```bash
docker exec -it my_container /bin/bash
```

Bypass a custom ENTRYPOINT: If the image already defines an ENTRYPOINT
that overrides /bin/bash, pass --entrypoint:
```bash
docker run -dit --name my_container --entrypoint /bin/bash <image_name>
```
