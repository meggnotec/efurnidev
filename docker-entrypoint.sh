#!/bin/bash
set -e

source $NVM_DIR/nvm.sh

if [ "$1" == "bash" ]; then
	bash
elif [ "$1" == "start" ]; then
	if [ ! -e "/bcstencil/efurni/package.json" ]; then
	    if [ ! "$(ls -A /bcstencil/efurni)" ]; then
		    git clone git://github.com/bigcommerce/cornerstone.git /bcstencil/efurni
	    else
	      echo "/bcstencil/efurni must either be empty, or hold a valid stencil theme"
      fi
	fi

	if [ ! -e "/bcstencil/efurni/node_modules" ]; then
		npm install --loglevel=error
	fi

	if [ ! -e "/bcstencil/efurni/.stencil" ]; then
		if [ -e "/etc/stencil/.stencil" ]; then
			cp /etc/stencil/.stencil /bcstencil/efurni/
		else
			stencil init
		fi
	fi

	stencil start
else
	exec "$@"
fi
