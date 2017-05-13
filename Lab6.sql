4.1 Получить названия лекарств из аптеки с id = 3
    
    SELECT drug.name FROM drug_in_pharmacy 
      LEFT JOIN drug ON drug_in_pharmacy.id_drug = drug.id_drug
    WHERE drug_in_pharmacy.id_pharmacy = 3;
    
    id  select_type table            type   possible_keys key      key_len ref                               rows  Extra
    1   SIMPLE      drug_in_pharmacy ref    pharmacy      pharmacy 4       const                             30
    1   SIMPLE      drug             eq_ref PRIMARY       PRIMARY  4       task_six.drug_in_pharmacy.id_drug 1
    
4.2 Получить названия лекарств из аптеки с id = 3
    
    SELECT drug.name FROM (
      drug_in_pharmacy RIGHT JOIN drug ON drug_in_pharmacy.id_drug = drug.id_drug
    ) WHERE drug_in_pharmacy.id_pharmacy = 3;
    
    id  select_type table            type   possible_keys key      key_len ref                               rows  Extra
    1   SIMPLE      drug_in_pharmacy ref    pharmacy      pharmacy 4       const                             30
    1   SIMPLE      drug             eq_ref PRIMARY       PRIMARY  4       task_six.drug_in_pharmacy.id_drug 1
    
4.3 Названия лекарств из аптеки 500 и фабрикой 43
    
    SELECT DISTINCT drug.name FROM drug_in_pharmacy RIGHT JOIN drug ON drug_in_pharmacy.id_drug = drug.id_drug
    WHERE 
   	(drug_in_pharmacy.id_pharmacy = 500 AND
    drug_in_pharmacy.id_drug IN (SELECT id_drug FROM drug WHERE drug.id_factory = 43))
    
    id  select_type        table            type            possible_keys key      key_len ref                               rows Extra
    1   PRIMARY            drug_in_pharmacy ref             pharmacy,drug pharmacy 4       const                             30   Using where; Using temporary
    2   PRIMARY            drug             eq_ref          PRIMARY       PRIMARY  4       task_six.drug_in_pharmacy.id_drug 1
    3   DEPENDENT SUBQUERY drug             unique_subquery PRIMARY       PRIMARY  4       func                              1    Using where
    
4.4 Получить круглосуточные аптеки продающие лекарство с id = 500

    SELECT pharmacy.name FROM (
      drug_in_pharmacy LEFT JOIN pharmacy ON drug_in_pharmacy.id_pharmacy = pharmacy.id_pharmacy
    ) WHERE pharmacy.work_time = '24/7' AND drug_in_pharmacy.id_drug = 500;
    
    id select_type table            type   possible_keys key     key_len ref                                   rows Extra
    1  SIMPLE      drug_in_pharmacy ref    pharmacy,drug drug    4       const                                 30
    1  SIMPLE      pharmacy         eq_ref PRIMARY       PRIMARY 4       task_six.drug_in_pharmacy.id_pharmacy 1    Using where

4.5 Получить информацию о гелях id которых меньше 2000 и которые продаются везде, кроме фарматеки

    SELECT * FROM (
      drug LEFT JOIN drug_in_pharmacy ON drug.id_drug = drug_in_pharmacy.id_drug
         LEFT JOIN pharmacy ON drug_in_pharmacy.id_pharmacy = pharmacy.id_pharmacy
    ) WHERE
        (drug.description = 'Gel') AND
        (drug_in_pharmacy.id_drug < 2000) AND
        (pharmacy.name != 'Farmateka')
    
    id select_type table            type    possible_keys           key       key_len ref                                   rows  Extra
    1  SIMPLE      drug_in_pharmacy ALL     pharmacy,drug,pharmDrug pharmDrug 4       NULL                                  7250  Using where; Using index
    1  SIMPLE      drug eq_ref      PRIMARY PRIMARY,drugDiscript    PRIMARY   4       task_six.drug_in_pharmacy.id_drug     1     Using where
    1  SIMPLE      pharmacy eq_ref  PRIMARY PRIMARY,farmacuName     PRIMARY   4       task_six.drug_in_pharmacy.id_pharmacy 1     Using where

4.6 Вывести названия лекарств продающихся в фарматеках

    SELECT drug.name FROM drug WHERE drug.id_drug IN (
      SELECT drug_in_pharmacy.id_drug FROM drug_in_pharmacy WHERE drug_in_pharmacy.id_pharmacy IN (
        SELECT pharmacy.id_pharmacy FROM pharmacy WHERE pharmacy.name = 'Farmateka'
    ))
        
    id select_type        table            type            possible_keys   key     key_len ref  rows  Extra
    1  PRIMARY            drug             index           NULL            name    50      NULL 15401 Using where;Using index
    2  DEPENDENT SUBQUERY drug_in_pharmacy index_subquery  drug            drug    4       func 14    Using where 
    3  DEPENDENT SUBQUERY pharmacy         unique_subquery PRIMARY         PRIMARY 4       func 1     Using where
    
4.7 Вывести фабрики отсортированные по названию

    SELECT * FROM factory ORDER BY factory.name
    
    id select_type table type possible_keys key  key_len ref  rows  Extra
    1  SIMPLE      drug  ALL  NULL          NULL NULL    NULL 14401 Using filesort

4.8 Лекарства отсортированные по названию и по виду(description)

    SELECT * FROM drug ORDER BY drug.name, drug.description
    
    id select_type table type possible_keys key  key_len ref  rows  Extra
    1  SIMPLE      drug  ALL  NULL          NULL NULL    NULL 15401 Using filesort