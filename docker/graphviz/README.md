Graphviz
========

Builds a minimal docker image for rendering graphviz files (in particular dot files).
The container contains some basic fonts and graphviz.

### Build

```sh
make build
```

### Usage

#### Direct usage

To run, override the user, mount a volume, specify the image, and then provide any arguments for the `dot` command.
For example, to convert a `test.dot` to a `test.jpg` run:

```sh
docker run --user=$(id -u):$(id -g) -v `pwd`:/workspace cryptic-dot -Tjpg test.dot -o test.jpg
```
