1.1 ��� ������ ������
    SELECT * FROM client LIMIT 3;
    
2.1 ������� ��� �������� ������
    SELECT * FROM client WHERE bonuses_count IS NULL;
    
2.2 ������� � ��������� ������������
    SELECT * FROM client WHERE bonuses_count IS NOT NULL;
    
2.3 ���� ���������� ������ 5000, �� ������ 10000
    SELECT * FROM tour WHERE price BETWEEN 5000 AND 10000;
    
2.4 ������� ���������� 1996-12-10 � 1999-09-22
    SELECT * FROM client WHERE bithday IN ('1996-12-10', '1999-09-22');

2.5 ���� ������� ������
    SELECT * FROM tour WHERE start_date='2017-04-01';
    
2.6 ���� �� ������������ � ����� ��
    SELECT id_tour FROM route WHERE id_start_point!='1';

3.1 ���� ��������������� �� ����������� ����
    SELECT * FROM tour ORDER BY price ASC;
    
3.2 ���� ��������������� �� �������� ����
    SELECT * FROM tour ORDER BY price DESC;
    
3.3 ������� ��������������� �� ����������� ������ � �� ���� ��������
    SELECT * FROM client ORDER BY bonuses_count, bithday ASC;
    
3.4 ������ - �����, id ������, ��� ������� ��������������� �� ����������� ������
    SELECT bonuses_count, id, full_name FROM client ORDER BY bonuses_count ASC;
    
4.1 ����� ������� ���
    SELECT MIN(price) AS SmallestTourPrice FROM tour;
    
4.2 ����� ������� ���
    SELECT MAX(price) AS BiggestTourPrice FROM tour;
    
4.3 ������� ������������ ����
    SELECT AVG(end_date - start_date) AS AverageTourDuration FROM tour;
    
4.4 ����� ������� �������� ������� �������� ����� 31 ������ 1996
    SELECT SUM(bonuses_count) AS SumOfBonuses FROM client WHERE bithday > '1996-12-31';
    
5.1 �������� ������ ������� �� ���������
    SELECT DISTINCT name FROM point;
    
5.2 ���������� ������ ������� �� ���������
    SELECT COUNT(DISTINCT name) AS CountOfPoints FROM point;
    
6.1 ���� � ������ �������
    SELECT start_date, SUM(price) AS PricesSum FROM tour GROUP BY start_date;
    
6.2 ����� ������� �� ���� ������ ��� ����� ������� ��������� ������ ������� ������
    SELECT start_date, SUM(price) WHERE end_date < '2017-04-01' AS PricesSum FROM tour GROUP BY start_date;

6.3 ���� � ������� ����� ������� ����� ������ 20000
    SELECT start_date, SUM(price) FROM tour GROUP BY start_date HAVING SUM(price) > 20000;
    
