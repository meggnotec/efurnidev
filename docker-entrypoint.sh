#!/bin/bash
set -e

source $NVM_DIR/nvm.sh

if [ "$1" == "bash" ]; then
	bash
elif [ "$1" == "start" ]; then
	if [ ! -e "/bcstencil/efurni/efurnidev/efurnitheme/package.json" ]; then
	    if [ ! "$(ls -A /bcstencil/efurni/efurnidev/efurnitheme)" ]; then
		    git clone git://github.com/bigcommerce/cornerstone.git /bcstencil/efurni/efurnidev/efurnitheme
	    else
	      echo "/bcstencil/efurni/efurnidev/efurnitheme must either be empty, or hold a valid stencil theme"
      fi
	fi

	if [ ! -e "/bcstencil/efurni/efurnidev/efurnitheme/node_modules" ]; then
		npm install --loglevel=error
	fi

	if [ ! -e "/bcstencil/efurni/efurnidev/efurnitheme/.stencil" ]; then
		if [ -e "/etc/stencil/.stencil" ]; then
			cp /etc/stencil/.stencil /bcstencil/efurni/efurnidev/efurnitheme
		else
			stencil init
		fi
	fi

	stencil start
else
	exec "$@"
fi
