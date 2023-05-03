# NewsApp

Загрузка новостей из [NewsAPI](https://newsapi.org) и отображение их в виде списка. При нажатии на новость открывается экран с подробной информацией.

### Реализация:
- Стэк: Swift, UIKit, GCD
- Архитектура: SOA + MVP
- Адаптивная верстка кодом
- Обновление новостей с помощью жеста pull-to-refresh
- Постраничная загрузка доступных новостей бесконечной лентой (пагинация по 20 новостей)
- Полный текст новости открывается с использованием WebKit
- Кэширование данных о новостях и счетчик просмотров: CoreData
- Обработка исключений
