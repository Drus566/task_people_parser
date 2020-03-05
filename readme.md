# Тестовое задание на парсинг
## Задание
Необходимо написать парсер, который будет заходить на страницу Илона Маска в твиттере(twitter.com/elonmusk), парсить 3 его последних поста(только текст) и для каждого поста вывести по 3 последних лайкнувших человека(ссылки на их аккаунты)
## Реализация
Для реализации парсера необходимо использовать:
- ruby 2.4
- Faraday(gem)
- Nokogiri(gem)
## Финальный вид
Парсер должен запускаться так: ```ruby parser.rb``` и выдавать результат в консоли в удобно читаемом виде(на ваше усмотрение), например:

```
Post 1:
New Model S has 370 mile / 595 km range
Liked by:
- https://twitter.com/AliArslanoglu_
- https://twitter.com/septicendoplier
- https://twitter.com/og_djape

Post 2:
Motor Trend on Model S updates
Liked by:
- https://twitter.com/og_djape
- https://twitter.com/sicxspliff
- https://twitter.com/Cedric_hof

Post 3:
Model S drives from San Francisco to Los Angeles without recharging
Liked by:
- https://twitter.com/og_djape
- https://twitter.com/septicendoplier
- https://twitter.com/Cedric_hof
```