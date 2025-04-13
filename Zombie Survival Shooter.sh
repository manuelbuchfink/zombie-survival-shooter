#!/bin/sh
echo -ne '\033c\033]0;Zombie Survival Shooter\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Zombie Survival Shooter.x86_64" "$@"
