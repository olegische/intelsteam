# Description
Репозиторий инфраструктуры is

# Configuration Management System

## Abstract
Управление конфигурациями производиться с помощью Ansible

## Playbooks Common
- **hosts** -- описание структуры сайта
- **group_vars/all.yml** -- настройка пользователя ansible, vault, timezone, ssh keys

## Common Role
- **roles/common/defaults/main.yml** -- список устанавливаемых пакетов для всех машин под управлением ansible, список файлов индивидуальной настройки sudo
- **roles/common/files/** -- файлы конфигурации sshd и общий файл sudoers
- **roles/common/templates/** -- jinja2 шаблоны для индивидуальной настройки sudo

## Additional Info
- Существует структура пользоваетля сайта. Все пользователи описываются согласно структуре.
- Права пользователям задаются через конфигурацию индивидуальных sudo файлов.
- Все пароли сайта хранятся в vault в зашифрованном виде.
