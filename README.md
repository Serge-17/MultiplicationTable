# Игра "Таблица умножения"

Эта игра реализована с использованием SwiftUI и позволяет пользователям проверять свои знания таблицы умножения, отвечая на случайно сгенерированные вопросы. Уровень сложности может быть установлен на "Легкий", "Средний" или "Тяжелый", что определяет количество вопросов для ответа.

## Особенности

- Градиентный фон для привлекательного интерфейса.
- Выбор уровня сложности.
- Случайная генерация вопросов по умножению.
- Мгновенная проверка ответов.
- Отображение результатов, включая количество правильных и неправильных ответов.
- Возможность перезапуска игры.

## Начало работы

### Требования

- Xcode 12 или более поздней версии.
- Swift 5.3 или более поздней версии.

### Установка

#### bash
- Копировать код git clone https://github.com/your-username/MultiplicationTable.git

### Откройте проект в Xcode:
#### Копировать код
- cd MultiplicationTable
- open MultiplicationTable.xcodeproj
- Соберите и запустите проект на симуляторе или физическом устройстве.

### Обзор кода
ContentView
Основное представление игры, включающее:

#### Градиентный фон.
NavigationView, содержащий интерфейс игры.
Переменные состояния для управления состоянием игры, вводом пользователя и результатами.
UI-компоненты, такие как текстовые поля, кнопки и пикеры для взаимодействия с пользователем.
Логика для запуска игры, генерации вопросов, проверки ответов и отображения результатов.
checkLevelQuestion(Level:numberQuestion:)
Вспомогательная функция для определения, должна ли игра закончиться в зависимости от текущего уровня сложности и количества отвеченных вопросов.

#### StyleText
Пользовательский модификатор представления для стилизации текстовых элементов в разделе результатов.

### Использование
##### -Выберите уровень сложности с помощью пикера.
##### -Нажмите кнопку "Начать игру" для начала.
##### -Введите результат отображаемого вопроса по умножению в текстовое поле.
##### -Нажмите "OK" для проверки ответа.
##### -Результат будет отображен, и будет сгенерирован новый вопрос.
##### -Игра заканчивается после определенного количества вопросов в зависимости от выбранного уровня сложности.
##### -Просмотрите свои результаты и нажмите "Конец игры" для перезапуска.
