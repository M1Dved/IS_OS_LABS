#!/bin/bash
while true;
do
    echo "Выберите действие:"
    echo "1 Запустить nano"
    echo "2 Запустить vi"
    echo "3 Запустить браузер links"
    echo "4 Выход"
    read res

    case $res in
        1) nano ;;
        2) vi ;;
        3) links ;;
        4) exit 0 ;;
    esac
done
