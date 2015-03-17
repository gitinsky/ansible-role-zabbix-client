#!/bin/sh -eu

ls "/proc/$1/fd/"|wc -l
