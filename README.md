### Тестовое задание
*Стек: python:3.10, Django:4.2, Postgres:12.4*  
*Среда разработки: PyCharm*

### Описание задания:  
Представляет web-приложение на django, которое реализует древовидное меню с соблюдением следующих условий:
1) Меню реализовано через template tag
2) Все, что над выделенным пунктом - развернуто. Первый уровень вложенности под выделенным пунктом тоже развернут.
3) Хранится в БД.
4) Редактируется в стандартной админке Django
5) Активный пункт меню определяется исходя из URL текущей страницы
6) Меню на одной странице может быть несколько. Они определяются по названию.
7) При клике на меню происходит переход по заданному в нем URL. URL может быть задан как явным образом, так и через named url.
8) На отрисовку каждого меню требуется ровно 1 запрос к БД.

---
### Для проверки задания:
`Требования:`  
* [обязательно] установленная платформа [Docker](https://docs.docker.com/get-docker/)

1. Рядом с файлом *docker-compose.yaml* положить файл *.env* с параметрами для подключения к базе данных (см. файл [.env.example](.env.example)):
2. Собрать и запустить контейнеры с django приложением и базой данных (БД):
```python
docker-compose up --build -d
```
В результате будет собран и запущен контейнер с работающим приложением, а так же скачан и запущен контейнер с БД PostgreSQL.  
Приложение будет доступно по адресу [localhost/app/home/](http://localhost/app/home/)

Посмотреть список запущенных контейнеров можно командой:
```python
docker-compose ps
```

Остановить контейнеры:
```python
docker-compose down
```

#### Ручной запуск
1. Создать виртуальное окружение:
```python
python -m venv venv
./venv/Scripts/Activate.ps1 # Windows PowerShell
venv\Scripts\activate.bat   # Windows CMD
source venv/bin/activate    # Linux, MacOS
```
2. Установить зависимости:
```python
pip install poetry
poetry install
```
3. Запустить образ с PostgreSQL с учетом параметров в .env-файле:
```python
docker run --name psql -e POSTGRES_DB=postgres -e  POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres:12.4-alpine
```
где:  
POSTGRES_DB - имя БД (DB_NAME),  
POSTGRES_PASSWORD - пароль для доступа к БД (DB_PASSWORD).  
4. Запустить приложение:
```python
python manage.py runserver
```
