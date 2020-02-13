# eqemu-maps-docker
A Docker container containing a snapshot of EQEMU Maps files. To be run as a sidekick with eqemu-server-docker.

This container clones the EQEMU Maps github project into /home/eqemu/maps. Mount this folder as a volume into your eqemu-server-docker container at both /home/eqemu/maps and /home/eqemu/Maps. 

Its ENTRYPOINT is set to /bin/true so it will simply exit once run. It exists only to provide its volume, as any sidekick container does.
