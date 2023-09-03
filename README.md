
#  Дипломная работа по профессии «Системный администратор»

Содержание
==========
* [Задача](#Задача)
* [Инфраструктура](#Инфраструктура)
    * [Сайт](#Сайт)
    * [Логи](#Логи)
    * [Мониторинг](#Мониторинг)
    * [Сеть](#Сеть)
    * [Резервное копирование](#Резервное-копирование)

---------
## Задача
Ключевая задача — разработать отказоустойчивую инфраструктуру для сайта, включающую мониторинг, сбор логов и резервное копирование основных данных. Инфраструктура должна размещаться в [Yandex Cloud](https://cloud.yandex.com/).


## Инфраструктура
Для развёртки инфраструктуры используем [Terraform](https://github.com/alex31bel/sys-diplom/tree/main/terraform), а для установки ПО [Ansible](https://github.com/alex31bel/sys-diplom/tree/main/ansible).

Terraform:

Проверяем правильность синтаксиса файлов Terraform

![Скриншот-1](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom1.PNG) 

Просматриваем план создание инфраструктуры

![Скриншот-2](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom2.PNG)

И запускаем terraform apply

![Скриншот-3](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom3.PNG)

Дожидаемся окончания создания инфраструктуры и вывода информации output

![Скриншот-4](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom4.PNG)

Заранее подготовленный [output-ansible-hosts](https://github.com/alex31bel/sys-diplom/blob/main/terraform/output.tf) сохраняем в отдельный файл hosts для ansible и удаляем лишнее из файла

![Скриншот-5](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom5.PNG)

Проверяем доступность созданных ВМ с помощью ansible all -m ping

![Скриншот-6](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom6.PNG)

Переходим к установке и настройке ПО с помощью Ansible

### Сайт
Запускаем playbook - [webservers-playbook.yml](https://github.com/alex31bel/sys-diplom/blob/main/ansible/webservers-playbook.yml)

По окончанию выполнения playbook проверяем что сервисы nginx, node_exporter и nginx_logexporter работаю

![Скриншот-7](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom7.PNG)

![Скриншот-8](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom8.PNG)

Проверяем что наш сайт работает

![Скриншот-9](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom9.PNG)

![Скриншот-10](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom10.PNG)

### Логи
Запускаем playbook - [log-playbook.yml](https://github.com/alex31bel/sys-diplom/blob/main/ansible/log-playbook.yml)

По завершению выполнения playbook проверяем что контейнеры с elasticsearch и kibana работают

![Скриншот-25](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom25.PNG)

![Скриншот-26](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom26.PNG)

Уставноку filebeat - [log-filebeat-playbook.yml](https://github.com/alex31bel/sys-diplom/blob/main/ansible/log-filebeat-playbook.yml)

![Скриншот-24](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom24.PNG)

Заходим в Kibana для проверки что логи nginx с web серверов поступают

![Скриншот-17](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom17.PNG)

![Скриншот-18](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom18.PNG)

Из лога ошибок Nginx видим что кто то пытается зайти на страницу которой нет)))

### Мониторинг
Запускаем playbook - [monitoring-playbook.yml](https://github.com/alex31bel/sys-diplom/blob/main/ansible/monitoring-playbook.yml)

Проверяем что работа playbook завершилась без ошибок

![Скриншот-11](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom11.PNG)

<details>
При первом запуске monitoring-playbook.yml выдаёт ошибку импорта дашборда в графану

![Скриншот-12](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom12.PNG)

При повторном запуске playbook он выполняется полностью без ошибок.
</details>

Заходим в Grafana для проверки работоспособности наших ранее импортированных дашбордов 

NGINX Servers Metrics:

![Скриншот-13](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom13.PNG)

![Скриншот-14](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom14.PNG)

Node Exporter Full:

![Скриншот-27](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom27.PNG)

### Сеть

![Скриншот-20](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom20.PNG)

![Скриншот-21](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom21.PNG)

![Скриншот-22](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom22.PNG)

### Резервное копирование

![Скриншот-19](https://github.com/alex31bel/sys-diplom/blob/main/img/sys-diplom19.PNG)

