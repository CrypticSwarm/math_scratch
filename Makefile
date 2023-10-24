nb:
	docker run --rm -it -e NB_USER=${USER} -e CHOWN_HOME=yes --user root -e JUPYTER_ENABLE_LAB=yes -p $(port):8888 -v "`pwd`":/code -v "`pwd`/before-notebook.d":/usr/local/bin/before-notebook.d -w /code jupyter/base-notebook
