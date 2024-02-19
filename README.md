﻿Дипломная работа — мобильное приложении для социальной сети ВКонтакте.

- Приложение написано на архитектуре MVC
- Для работы с постами, добавлением и удалением их в избранном, используется Core Data
- Для примера посты берутся из открытого API - https://rickandmortyapi.com
- Авторизация/регистрация пользователя происходит с помощью Firebase, а также UserDefaults и базы данных Realm
- Приложение полностью локализовано
- Есть поддержка светлой и темной темы


  ![](Aspose.Words.30b015c7-8165-404e-b5c9-e35a795bf648.001.png)Приложение VK     









После запуска приложения пользователь попадает на экран авторизации, где может зарегистрироваться или войти, введя логин и пароль (хранятся в базе Firebase), а если ранее был авторизован, то может использовать FaceID/TouchID.

![](Aspose.Words.30b015c7-8165-404e-b5c9-e35a795bf648.002.png)![](Aspose.Words.30b015c7-8165-404e-b5c9-e35a795bf648.003.png)![](Aspose.Words.30b015c7-8165-404e-b5c9-e35a795bf648.004.png)























Приложение принимает светлую или темную тему в зависимости от настроек телефона, также есть поддержка русского и английского языка.

![](Aspose.Words.30b015c7-8165-404e-b5c9-e35a795bf648.005.png)

![](Aspose.Words.30b015c7-8165-404e-b5c9-e35a795bf648.006.png)



















Если авторизация прошла успешно, пользователь попадает на главный экран с профилем, там он может устанавливать статус пользователя, проматывать ленту постов и добавлять понравившийся пост в избранное путем двойного нажатия на сам пост. Также пост можно удалить из избранного свайпом влево. В профиле пользователя есть кнопка выхода, которая разлогинивает пользователя.

![](Aspose.Words.30b015c7-8165-404e-b5c9-e35a795bf648.007.png)![](Aspose.Words.30b015c7-8165-404e-b5c9-e35a795bf648.008.png)




















Также можно зайти в фотоальбом пользователя нажатием на ячейку с изображениями, на этом экране можно открыть любое изображение.

![](Aspose.Words.30b015c7-8165-404e-b5c9-e35a795bf648.009.png)

![](Aspose.Words.30b015c7-8165-404e-b5c9-e35a795bf648.010.png)
