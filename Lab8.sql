1. Успешную транзакция (COMMIT)

  START TRANSACTION;
  UPDATE student SET student.birthday = '1990-10-10'
  WHERE student.id_student = '1';
  COMMIT;
  
  --------------------------------------------------------------------------------

2. Транзакцию с отктом (ROLLBACK)

  START TRANSACTION;
  INSERT INTO student VALUES (NULL, 'Перед Роллбекович', '3', '1990-08-08');
  ROLLBACK;
  INSERT INTO student VALUES (NULL, 'После Роллбекович', '2', '1985-12-12');
  COMMIT;

3. Создать хранимую процедуру с параметрами и вызвать ее

  

4. Создать триггер и вызвать его


