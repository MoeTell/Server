# MoeTell Server

This is MoeTell server-side program.

## Environment

* PHP 7.0+

* Swoole 1.8.5+

* MySQL 5.7+

* Redis

## Setup

* Import database.sql into your MySQL server

* Rename `moetell/Config.example.ini` to `moetell/Config.ini`

* Configure the connection information for MySQL and Redis in `moetell/Config.ini`

* Set up other configurations you want to modify

* Execute `php start.php`