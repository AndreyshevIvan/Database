1.INSERT
    1. ��� �������� ������ �����
        INSERT INTO `medication` VALUES (NULL, '������ ���', '10', '������');

    2. � ��������� ������ �����
        INSERT INTO `medication` (`id`, `name`, `dose`, `id_factory`) VALUES (NULL, '��������', '115', '2')

    3. � ������� �������� �� ������ �������
        INSERT INTO purpose (id, create_date, id_patient) SELECT NULL, '2014-04-11', '1000' FROM patient WHERE full_name = 'Ivan Ivanov'

2.DELETE
    1. ��� ������
        DELETE FROM purpose
    2. �� �������
        DELETE FROM purpose WHERE create_date < '2000-11-12'
    3. �������� �������
        TRUNCATE table purpose
        
3. UPDATE
    1. ���� �������
        UPDATE purpose SET create_date = '1996-12-10'
    2. �� ������� �������� ���� �������
        UPDATE purpose SET create_date = '2000-12-10' WHERE id_patient = '1'
    3. �� ������� �������� ��������� ���������
        UPDATE purpose SET id_patient = '4', create_date = '1996-12-10'WHERE id = '1'
        
4. SELECT � ������ ����� �������
    1. � ����������� ������� ����������� ���������
        SELECT id_patient, create_date FROM purpose
    2. �� ����� ����������
        SELECT * FROM purpose
    3. � �������� �� �������� (SELECT * FROM ... WHERE atr1 = '')
        SELECT * FROM purpose WHERE id_patient = '1334'
