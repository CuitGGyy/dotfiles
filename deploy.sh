#!/usr/bin/env bash
#set -euxo pipefail
#
####

## 当前目录路径
CWD=$(pwd)
## 项目工作路径
PWD=$(cd "$(dirname "$0")" && pwd)


## 安装部署到当前用户家目录
function replace_by() {
	## 进入项目目录
	cd ${PWD}

	if [[ ! -d ${HOME}/.config ]]; then
		mkdir -p ${HOME}/.config
	fi

	files=("${PWD}/.config"/*)
	for file in "${files[@]}"
	do
		target=$(basename "${file}")
		if [[ -d ${HOME}/.config/${target} ]]; then
			rm -rf ${HOME}/.config/${target}
			cp -r ${file} ${HOME}/.config/
		fi
	done

	if [[ "$(uname -s)" = "Darwin" ]]; then
		dotfiles=("zprofile" "zshrc" "vimrc")
	else
		dotfiles=("profile" "bashrc" "bash_logout" "inputrc" "vimrc")
	fi
	for file in "${dotfiles[@]}"
	do
		cp ${PWD}/.config/shenv/${file} ${HOME}/.${file}
	done

	## 返回当前目录
	cd ${CWD}
}

replace_by

