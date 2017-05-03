1.INSERT
    1. Без указания списка полей
        INSERT INTO `medication` VALUES (NULL, 'Доктор Мом', '10', 'Россия');

    2. С указанием списка полей
        INSERT INTO `medication` (`id`, `name`, `dose`, `id_factory`) VALUES (NULL, 'Трависил', '115', '2')

    3. С чтением значения из другой таблицы
        INSERT INTO purpose (id, create_date, id_patient) SELECT NULL, '2014-04-11', '1000' FROM patient WHERE full_name = 'Ivan Ivanov'

2.DELETE
    1. Все записи
        DELETE FROM purpose
    2. По условию
        DELETE FROM purpose WHERE create_date < '2000-11-12'
    3. Очистить таблицу
        TRUNCATE table purpose
        
3. UPDATE
    1. Всех записей
        UPDATE purpose SET create_date = '1996-12-10'
    2. По условию обновляя один атрибут
        UPDATE purpose SET create_date = '2000-12-10' WHERE id_patient = '1'
    3. По условию обновляя несколько атрибутов
        UPDATE purpose SET id_patient = '4', create_date = '1996-12-10'WHERE id = '1'
        
4. SELECT в рамках одной таблицы
    1. С определённым набором извлекаемых атрибутов
        SELECT id_patient, create_date FROM purpose
    2. Со всеми атрибутами
        SELECT * FROM purpose
    3. С условием по атрибуту (SELECT * FROM ... WHERE atr1 = '')
        SELECT * FROM purpose WHERE id_patient = '1334'
