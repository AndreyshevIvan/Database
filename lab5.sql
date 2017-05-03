1.1 Три первых клиета
    SELECT * FROM client LIMIT 3;
    
2.1 Клиенты без бонусных баллов
    SELECT * FROM client WHERE bonuses_count IS NULL;
    
2.2 Клиенты с бонусными начислениями
    SELECT * FROM client WHERE bonuses_count IS NOT NULL;
    
2.3 Туры стоимостью больше 5000, но меньше 10000
    SELECT * FROM tour WHERE price BETWEEN 5000 AND 10000;
    
2.4 Клиенты родившиеся 1996-12-10 и 1999-09-22
    SELECT * FROM client WHERE bithday IN ('1996-12-10', '1999-09-22');

2.5 Туры первого апреля
    SELECT * FROM tour WHERE start_date='2017-04-01';
    
2.6 Туры не начинающиеся в Марий Эл
    SELECT id_tour FROM route WHERE id_start_point!='1';

3.1 Туры отсортированные по возрастанию цены
    SELECT * FROM tour ORDER BY price ASC;
    
3.2 Туры отсортированные по убыванию цены
    SELECT * FROM tour ORDER BY price DESC;
    
3.3 Клиенты отсортированные по возрастанию баллов и по дате рождения
    SELECT * FROM client ORDER BY bonuses_count, bithday ASC;
    
3.4 Список - баллы, id клиета, имя клиента отсортированные по возрастанию баллов
    SELECT bonuses_count, id, full_name FROM client ORDER BY bonuses_count ASC;
    
4.1 Самый дорогой тур
    SELECT MIN(price) AS SmallestTourPrice FROM tour;
    
4.2 Самый дешёвый тур
    SELECT MAX(price) AS BiggestTourPrice FROM tour;
    
4.3 Средняя длительность тура
    SELECT AVG(end_date - start_date) AS AverageTourDuration FROM tour;
    
4.4 Сумма бонусов клиентов которые родились позже 31 января 1996
    SELECT SUM(bonuses_count) AS SumOfBonuses FROM client WHERE bithday > '1996-12-31';
    
5.1 Названия разных пунктов из маршрутов
    SELECT DISTINCT name FROM point;
    
5.2 Количество разных пунктов из маршрутов
    SELECT COUNT(DISTINCT name) AS CountOfPoints FROM point;
    
6.1 Даты с суммой выручки
    SELECT start_date, SUM(price) AS PricesSum FROM tour GROUP BY start_date;
    
6.2 Сумма выручки за день старта для туров которые кончаются раньше первого апреля
    SELECT start_date, SUM(price) WHERE end_date < '2017-04-01' AS PricesSum FROM tour GROUP BY start_date;

6.3 Даты в которые сумма выручки будет больше 20000
    SELECT start_date, SUM(price) FROM tour GROUP BY start_date HAVING SUM(price) > 20000;
    
