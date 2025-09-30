-- phpMyAdmin SQL Dump
-- version 4.9.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Сен 30 2025 г., 17:12
-- Версия сервера: 8.0.13
-- Версия PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `RobA1234_Tehnicuc`
--

-- --------------------------------------------------------

--
-- Структура таблицы `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `massage` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `comments`
--

INSERT INTO `comments` (`id`, `ticket_id`, `user_id`, `massage`, `date`) VALUES
(1, 1, 4, 'Принтер вообще не реагирует на кнопки. Мигает красный индикатор', '2024-01-15 09:35:00'),
(2, 1, 1, 'Принял в работу. Подойду в течение часа', '2024-01-15 09:40:00'),
(3, 2, 5, 'Проблема возникает только с Excel, Word и PowerPoint работают нормально', '2024-01-14 14:25:00'),
(4, 2, 2, 'Проверил систему. Обновил Office до последней версии. Проблема сохраняется', '2024-01-14 15:30:00'),
(5, 3, 6, 'Сегодня интернет вообще не работал с 10 до 11 утра', '2024-01-15 08:20:00'),
(6, 4, 4, 'Очень срочно нужно! Готовлю отчет для налоговой', '2024-01-12 16:15:00'),
(7, 4, 2, 'Пароль сброшен. Новый пароль: Temp1234. Смените после первого входа', '2024-01-12 16:45:00'),
(8, 5, 5, 'Мышь Logitech M185. Пробовал на другом компьютере - тоже не работает', '2024-01-10 10:05:00'),
(9, 5, 3, 'Заменили мышь на новую. Старая сломана', '2024-01-10 11:30:00');

-- --------------------------------------------------------

--
-- Структура таблицы `knowledge`
--

CREATE TABLE `knowledge` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `solution` text NOT NULL,
  `category` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `knowledge`
--

INSERT INTO `knowledge` (`id`, `title`, `solution`, `category`) VALUES
(1, 'Сброс пароля 1С', '1. Зайти в админку 1С\n2. Выбрать пользователя\n3. Нажать \"Сбросить пароль\"\n4. Выдать временный пароль\n5. Попросить пользователя сменить пароль после входа', '1С'),
(2, 'Ошибка \"Paper jam\" в принтерах HP', '1. Выключить и включить принтер\n2. Открыть все крышки и проверить наличие бумаги\n3. Протереть датчики бумаги\n4. Если не помогает - вызвать специалиста', 'Принтеры'),
(3, 'Установка офисного ПО', '1. Скачать дистрибутив с официального сайта\n2. Запустить установщик от имени администратора\n3. Следовать инструкциям мастера установки\n4. Активировать лицензию', 'ПО'),
(4, 'Проблемы с интернетом', '1. Проверить кабель подключения\n2. Перезагрузить роутер\n3. Проверить настройки сети\n4. Если проблема сохраняется - сообщить провайдеру', 'Сеть'),
(5, 'Не работает беспроводная мышь', '1. Проверить батарейки\n2. Переподключить USB-приемник\n3. Проверить на другом компьютере\n4. Если не работает - заменить на новую', 'Оборудование');

-- --------------------------------------------------------

--
-- Структура таблицы `tickets`
--

CREATE TABLE `tickets` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `problem` text NOT NULL,
  `status` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `worker_id` int(11) NOT NULL,
  `created_date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tickets`
--

INSERT INTO `tickets` (`id`, `title`, `problem`, `status`, `user_id`, `worker_id`, `created_date`) VALUES
(1, 'Не работает принтер в кабинете 301', 'Принтер HP LaserJet 1200 не печатает, выдает ошибку \"Paper jam\", хотя бумага не зажевана', 'new', 4, 1, '2024-01-15 09:30:00'),
(2, 'Не запускается Excel', 'При попытке открыть Excel вылетает ошибка \"Microsoft Excel has stopped working\". Переустановка не помогла', 'in_progress', 5, 2, '2024-01-14 14:20:00'),
(3, 'Проблема с интернетом в кабинете 205', 'Интернет периодически пропадает, особенно при загрузке больших файлов. Скорость очень низкая', 'on_hold', 6, 3, '2024-01-13 11:45:00'),
(4, 'Сброс пароля в 1С', 'Забыл пароль для входа в 1С:Бухгалтерия. Нужно сбросить и выдать новый', 'resolved', 4, 2, '2024-01-12 16:10:00'),
(5, 'Не работает мышь', 'Компьютерная мышь беспроводная перестала работать. Сменил батарейки - не помогло', 'closed', 5, 3, '2024-01-10 10:00:00'),
(6, 'Установка ПО', 'Требуется установить Adobe Photoshop и Lightroom для работы с фотографиями', 'new', 6, 1, '2024-01-16 08:15:00');

-- --------------------------------------------------------

--
-- Структура таблицы `Users`
--

CREATE TABLE `Users` (
  `id` int(10) UNSIGNED NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Users`
--

INSERT INTO `Users` (`id`, `login`, `password`, `name`, `role`) VALUES
(1, 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Иванов Петр Сергеевич', 'admin'),
(2, 'tech1', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Сидоров Алексей Викторович', 'technician'),
(3, 'tech2', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Петрова Мария Ивановна', 'technician'),
(4, 'user1', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Козлова Анна Дмитриевна', 'user'),
(5, 'user2', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Николаев Денис Олегович', 'user'),
(6, 'user3', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Смирнова Ольга Петровна', 'user');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_foreign` (`user_id`),
  ADD KEY `comments_ticket_id_foreign` (`ticket_id`);

--
-- Индексы таблицы `knowledge`
--
ALTER TABLE `knowledge`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tickets_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `knowledge`
--
ALTER TABLE `knowledge`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
