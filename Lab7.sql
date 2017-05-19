1 (СДАНО) Выдать все полученные оценки группы ИВТ-11 по математике.

  SELECT valuation.mark FROM
    lesson 
    LEFT JOIN subject ON lesson.id_subject = subject.id_subject
    LEFT JOIN stud_group ON lesson.id_group = stud_group.id_group
    LEFT JOIN valuation ON lesson.id_lesson = valuation.id_lesson
  WHERE subject.name = 'math' AND stud_group.name = 'ИВТ-11'
  
  id select_type table      type   possible_keys               key             key_len ref                            rows Extra
  1  SIMPLE      stud_group ref    PRIMARY,stud_group_name     stud_group_name 32      const                          1    Using where; Using index
  1  SIMPLE      lesson     ref    lesson_group,lesson_subject lesson_group    4       task_seven.stud_group.id_group 1    Using where
  1  SIMPLE      subject    eq_ref PRIMARY                     PRIMARY         4       task_seven.lesson.id_subject   1    Using where
  1  SIMPLE      valuation  eq_ref valuated_lesson             valuated_lesson 4       task_seven.lesson.id_lesson    1

----------------------------------------------------------------

2 Дать информацию о должниках группы ПС-41 с указанием фамилии студента
  и названия предмета. Должниками считаются студенты, не имеющие
  оценки по предмету, который ведется в группе.

  SELECT student.name, subject.name FROM
    student
    LEFT JOIN lesson ON student.id_group = lesson.id_group
    LEFT JOIN stud_group ON stud_group.id_group = stud_group.id_group
    LEFT JOIN valuation ON valuation.id_student = student.id_student
    LEFT JOIN subject ON lesson.id_subject = subject.id_subject
  WHERE valuation.mark IS NULL AND stud_group.name = 'ПС-41'
  
  id select_type table      type   possible_keys    key              key_len ref                           rows Extra
  1  SIMPLE      stud_group ref    stud_group_name  stud_group_name  32      const                         1    Using where; Using index
  1  SIMPLE      student    ALL    NULL             NULL             NULL    NULL                          7    Using join buffer
  1  SIMPLE      valuation  ref    valuated_student valuated_student 4       task_seven.student.id_student 1    Using where; Not exists
  1  SIMPLE      lesson     ref    lesson_group     lesson_group     4       task_seven.student.id_group   1
  1  SIMPLE      subject    eq_ref PRIMARY          PRIMARY          4       task_seven.lesson.id_subject  1
  
----------------------------------------------------------------

3 Дать среднюю оценку студентов по каждому предмету для тех предметов,
  по которым занимается не менее 10 студентов.
  
  SELECT * FROM valuation WHERE valuation.id_lesson IN (
    SELECT lesson.id_lesson FROM
      subject
      LEFT JOIN lesson ON subject.id_subject = lesson.id_subject
      LEFT JOIN student ON lesson.id_group = student.id_group
      GROUP BY subject.id_subject HAVING COUNT(DISTINCT student.id_student) > 3
  )

  id select_type        table     type   possible_keys  key            key_len ref                           rows Extra
  1  PRIMARY            valuation ALL    NULL           NULL           NULL    NULL                          3    Using where
  1  DEPENDENT SUBQUERY subject   index  NULL           PRIMARY        4       NULL                          1    Using index
  1  DEPENDENT SUBQUERY lesson    ref    lesson_subject lesson_subject 4       task_seven.subject.id_subject 1
  1  DEPENDENT SUBQUERY student   ref    student_group  student_group  4       task_seven.lesson.id_group    1    Using index
  
----------------------------------------------------------------

4 (СДАНО) Дать оценки студентов специальности ВМ по всем проводимым предметам
  с указанием группы, фамилии, предмета, даты. При отсутствии оценки
  заполнить значениями NULL поля оценки и даты.

  SELECT subject.name, stud_group.name, student.name, valuation.mark, valuation.post_date FROM
    student
    LEFT JOIN stud_group ON student.id_group = stud_group.id_group
    LEFT JOIN lesson ON lesson.id_group = stud_group.id_group
    LEFT JOIN subject ON lesson.id_subject = subject.id_subject
    LEFT JOIN valuation ON (lesson.id_lesson = valuation.id_lesson AND student.id_student = valuation.id_student)
    WHERE stud_group.name = 'ИВТ-11' ORDER BY subject.name
    
  id select_type table      type   possible_keys                    key              key_len ref                            rows Extra
  1  SIMPLE      stud_group ref    PRIMARY,stud_group_name          stud_group_name  32      const                          1    Using where; Using index...
  1  SIMPLE      lesson     ref    lesson_group                     lesson_group     4       task_seven.stud_group.id_group 1
  1  SIMPLE      subject    eq_ref PRIMARY                          PRIMARY          4       task_seven.lesson.id_subject   1
  1  SIMPLE      student    ref    student_group                    student_group    4       task_seven.stud_group.id_group 1
  1  SIMPLE      valuation  ref    valuated_student,valuated_lesson valuated_student 4       task_seven.student.id_student  1
  
----------------------------------------------------------------

5 Всем студентам специальности ИВТ, получившим оценки меньшие 5
  по предмету БД до 12.05, повысить эти оценки на 1 балл.
  
  UPDATE valuation SET valuation.mark = (valuation.mark + 1)
  WHERE
  valuation.id_student IN (
    SELECT student.id_student FROM
      student
      LEFT JOIN stud_group ON student.id_group = stud_group.id_group
    WHERE stud_group.spec = 'ИВТ')
  AND
  valuation.id_lesson IN (
    SELECT lesson.id_lesson FROM
      lesson
      LEFT JOIN stud_group ON stud_group.id_group = lesson.id_group
      LEFT JOIN student ON stud_group.id_group = student.id_student
      LEFT JOIN valuation ON (valuation.id_student = student.id_student AND valuation.id_lesson = lesson.id_lesson)
    WHERE valuation.post_date < '2017-10-12')
----------------------------------------------------------------