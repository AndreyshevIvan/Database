1. �������� ���������� (COMMIT)

  START TRANSACTION;
  UPDATE student SET student.birthday = '1990-10-10'
  WHERE student.id_student = '1';
  COMMIT;
  
  --------------------------------------------------------------------------------

2. ���������� � ������ (ROLLBACK)

  START TRANSACTION;
  INSERT INTO student VALUES (NULL, '����� �����������', '3', '1990-08-08');
  ROLLBACK;
  INSERT INTO student VALUES (NULL, '����� �����������', '2', '1985-12-12');
  COMMIT;

3. ������� �������� ��������� � ����������� � ������� ��

  

4. ������� ������� � ������� ���


