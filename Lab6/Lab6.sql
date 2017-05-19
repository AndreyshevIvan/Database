4.1 �������� id ����� � ������� ���� PentalgiN
    
    SELECT drug_in_pharmacy.id_pharmacy FROM
    drug 
    LEFT JOIN drug_in_pharmacy ON drug_in_pharmacy.id_drug = drug.id_drug
    WHERE drug.name = 'PentalgiN';
    
    id  select_type table            type   possible_keys key          key_len ref                   rows  Extra
    1   SIMPLE      drug             ref    drugName      drugName     50      const                 1342  Using where; Using index
    1   SIMPLE      drug_in_pharmacy ref    pharmacyDrug  pharmacyDrug 4       task_six.drug.id_drug 25
    
4.2 �������� id ����� � ������� ���� PentalgiN
    
    SELECT drug_in_pharmacy.id_pharmacy FROM
    drug_in_pharmacy
    RIGHT JOIN drug ON drug_in_pharmacy.id_drug = drug.id_drug
    WHERE drug.name = 'PentalgiN';
    
    id  select_type table            type   possible_keys key          key_len ref                   rows  Extra
    1   SIMPLE      drug             ref    drugName      drugName     50      const                 1342  Using where; Using index
    1   SIMPLE      drug_in_pharmacy ref    pharmacyDrug  pharmacyDrug 4       task_six.drug.id_drug 25
    
4.3 �������� ������ � �����, ������� ������ 100 � � ������� ���� ��������� � id = 41

    SELECT bill.id_bill, bill.date FROM
    drug_in_bill
    LEFT JOIN bill ON drug_in_bill.id_bill = bill.id_bill
    WHERE drug_in_bill.price > '100' AND drug_in_bill.id_drug = '41'

    id  select_type        table            type            possible_keys key      key_len ref                               rows Extra
    1   PRIMARY            drug_in_bill     ref             listDrug      listDrug 4       const                             49   Using where
    2   PRIMARY            bill             eq_ref          PRIMARY       PRIMARY  4       task_six.drug_in_bill.id_bill     1

4.4 �������� ������ � �����, ������� ������ 100 � ������� ����� 2000-10-10

    SELECT bill.id_bill, bill.date FROM
    drug_in_bill
    LEFT JOIN bill ON drug_in_bill.id_bill = bill.id_bill
    WHERE drug_in_bill.price > '100' AND bill.date > '2000-10-10'
    
    id select_type table        type   possible_keys     key     key_len ref                           rows  Extra
    1  SIMPLE      drug_in_bill ref    listBill          NULL    NULL    NULL                          15436 Using where
    1  SIMPLE      bill         eq_ref PRIMARY, billDate PRIMARY 4       task_six.drug_in_bill.id_bill 1     Using where

4.5 �������� ���������� � �������������� ������� ����� ��������, ������� ����� PentalgiN

    SELECT DISTINCT pharmacy.id_pharmacy, pharmacy.name FROM
    drug_in_pharmacy
    LEFT JOIN drug ON drug.id_drug = drug_in_pharmacy.id_drug
    LEFT JOIN pharmacy ON drug_in_pharmacy.id_pharmacy = pharmacy.id_pharmacy
    WHERE
    drug_in_pharmacy.id_pharmacy NOT IN (SELECT pharmacy.id_pharmacy FROM pharmacy WHERE pharmacy.name = 'Farmateka') AND
    pharmacy.work_time = '24/7' AND
    drug.name = 'PentalgiN'
    
    // �������� ��������

4.6 ������� ���� �� PentalgiN �� �����

    SELECT drug_in_bill.price FROM
    drug_in_bill
    WHERE
    drug_in_bill.id_drug IN (SELECT drug.id_drug FROM drug WHERE drug.name = 'PentalgiN')
        
    id select_type        table            type            possible_keys    key     key_len ref  rows  Extra
    1  PRIMARY            drug_in_bill     ALL             NULL             NULL    NULL    NULL 14469 Using where
    2  DEPENDENT SUBQUERY drug             unique_subquery PRIMARY,drugName PRIMARY 4       func 1     Using where
    
4.7 ������� ������� ��������������� �� ��������

    SELECT factory.id_factory, factory.name FROM factory ORDER BY factory.name
    
    id select_type table type possible_keys key  key_len ref  rows  Extra
    1  SIMPLE      drug  ALL  NULL          NULL NULL    NULL 14401 Using filesort

4.8 ��������� ��������������� �� �������� � �� ����(description)

    SELECT * FROM drug ORDER BY drug.name, drug.description
    
    id select_type table type possible_keys key  key_len ref  rows  Extra
    1  SIMPLE      drug  ALL  NULL          NULL NULL    NULL 15401 Using filesort