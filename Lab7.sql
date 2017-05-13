2 ������ ��� ���������� ������ ������ ���-11 �� ����������.

  SELECT valuation.mark FROM (
    lesson 
    LEFT JOIN subject ON lesson.id_subject = subject.id_subject
    LEFT JOIN stud_group ON lesson.id_group = stud_group.id_group
    LEFT JOIN valuation ON lesson.id_lesson = valuation.id_lesson
  )   WHERE subject.name = 'math' AND stud_group.name = '���-11'
----------------------------------------------------------------

3 ���� ���������� � ��������� ������ ��-41 � ��������� ������� �������� � �������� ��������. ���������� ��������� ��������, �� ������� ������ �� ��������, ������� ������� � ������.

  SELECT student.name, subject.name FROM (
    student LEFT JOIN lesson ON student.id_group = lesson.id_group
      LEFT JOIN stud_group ON stud_group.id_group = stud_group.id_group
        LEFT JOIN valuation ON valuation.id_student = student.id_student
          LEFT JOIN subject ON lesson.id_subject = subject.id_subject
  ) WHERE valuation.mark IS NULL AND stud_group.name = '��-41'
----------------------------------------------------------------

4 (NOT READY) ���� ������� ������ ��������� �� ������� �������� ��� ��� ���������, �� ������� ���������� �� ����� 10 ���������.
  
  SELECT valuation.mark FROM (
    lesson LEFT JOIN student ON lesson.id_group = student.id_group
    LEFT JOIN valuation ON (valuation.id_lesson = lesson.id_lesson AND valuation.id_student = student.id_student)
    LEFT JOIN subject ON lesson.id_subject = subject.id_subject
  )
----------------------------------------------------------------

5 ���� ������ ��������� ������������� �� �� ���� ���������� ��������� � ��������� ������, �������, ��������, ����. ��� ���������� ������ ��������� ���������� NULL ���� ������ � ����.

  SELECT subject.name, stud_group.name, student.name, valuation.mark, valuation.post_date FROM (
    student LEFT JOIN stud_group ON student.id_group = stud_group.id_group
    LEFT JOIN lesson ON lesson.id_group = stud_group.id_group
    LEFT JOIN subject ON lesson.id_subject = subject.id_subject
    LEFT JOIN valuation ON (lesson.id_lesson = valuation.id_lesson AND student.id_student = valuation.id_student)
  ) WHERE stud_group.name = '���-11' ORDER BY subject.name
----------------------------------------------------------------

6 ���� ��������� ������������� ���, ���������� ������ ������� 5 �� �������� �� �� 12.05, �������� ��� ������ �� 1 ����.
  
  UPDATE valuation
  SET valuation.mark = (valuation.mark + 1)
  WHERE (
    valuation.id_student IN (
      SELECT student.id_student FROM (
          student LEFT JOIN stud_group ON student.id_group = stud_group.id_group
      ) WHERE stud_group.spec = '���'
    ) AND
    valuation.id_lesson IN (
      SELECT lesson.id_lesson FROM (
        stud_group LEFT JOIN lesson ON stud_group.id_group = lesson.id_group
      ) WHERE stud_group.spec = '���'
    )
  )
----------------------------------------------------------------