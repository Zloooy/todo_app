# Done
Приложение для отслеживания задач.

[Загрузить apk](https://github.com/Zloooy/todo_app/releases/download/0.0.1-alpha/app-release.apk)

## Screenshots

![task_list](./screenshots/task_list.png)
![task_edit](./screenshots/task_edit.png)

## Features

* Отображение списка задач, фильтрация несделанных задач.
* Изменение и удаление задач из списка задач через свайпы, добавление новой задачи через последний элемент списка.
* Подробный просмотр информации о задаче на экране редактирования задачи.
* Изменение, сохранение и удаление задачи на экране редактирования задачи.
* Хранение данных приложения оффлайн
* Синхронизация данных приложения с сервером при наличии указанного в файле *credentials.env* токена авторизации *TOKEN*

* Поддержка тёмной темы
    Приложение поддерживает светлую, тёмную и системную темы оформления. Для переключения тем необходимо зажать иконку фильтрации выполненных задач (глаз).
* Поддержка deeplinks
    Приложение поддерживает открытие deeplinks (протестировано на android). Для тестирования подходят следующие адреса:
  * todo://to.do/tasks или просто todo://to.do/ - список задач
  * todo://to.do/tasks/new - создание новой задачи
  * todo://to.do/tasks/\<id задачи\> - проверка задачи
  Остальные адреса возвращают страницу ошибки.
* Firebase Crashlytics, Firebase Analytics

## Work in progress
* Тесты
* Работа с Firebase remote config