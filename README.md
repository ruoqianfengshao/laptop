Laptop
======

Laptop is a script to set up your Mac OS X development environment.

## 初始化环境

Requirements
------------

1) XCode and Command Line Tools

2) `chsh -s /bin/zsh`

Install
-------

`zsh <(curl -sL https://github.com/ruoqianfengshao/laptop/master/bootstrap.sh)`

## 已有环境优化
script for optimizing exist env, no dependency with zsh

没有安装 zsh，使用以下命令，不会安装 zsh

`bash <(curl -sL https://github.com/ruoqianfengshao/laptop/master/op-bootstrap.sh)`

安装了 zsh，使用以下命令，不会重复安装 zsh

`zsh <(curl -sL https://github.com/ruoqianfengshao/laptop/master/op-bootstrap.sh)`