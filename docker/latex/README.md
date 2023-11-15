LaTeX
=====

Builds a minimal LaTeX image for running `pdflatex`

### Build

```sh
make build
```

### Usage

#### Direct usage

To run, override the user, mount a volume, specify the file to remove, and then provide any arguments for the `pdflatex` command.
For example, to convert `test.tex` to a `test.pdf` run:

```sh
docker run --user=$(id -u):$(id -g) -v `pwd`:/workspace cryptic-latex test
```

#### Makefile

If you need to run multiple documents, a `Makefile` can be helpful for reducing the duplication:

```make
latex:
	docker run --user=$(id -u):$(id -g) -v `pwd`:/workspace cryptic-latex $(file)
  
example1.pdf: example1.tex
	$(MAKE) latex file=example1
  
example2.pdf: example2.tex
	$(MAKE) latex file=example2
```
