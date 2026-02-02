# SQL Generation Benchmark Report
**Generated**: 2026-02-01 22:18:36\
**Dataset**: mysql\
**Split**: test\
**Total Queries**: 682

---

## Metrics Explanation

### Execution Metrics

- **DataMatch**: Percentage of queries where data values are identical, ignoring column names (most meaningful for semantic correctness)
- **ExecMatch**: Percentage of queries where results are identical including both data values AND column names (most strict)
- **ExecF1**: F1 score of result set accuracy. For ordered queries: row-by-row comparison. For unordered: set-based comparison. Range: 0.0-1.0
- **Exact Match**: Percentage where result DataFrames are byte-for-byte identical (very strict, includes formatting)
- **Normalized Match**: Percentage where results match after normalization (lowercase + trimmed whitespace)

### Success Rate Metrics

- **Parse Success**: Percentage of generated SQL with valid syntax (no syntax errors)
- **Runtime Success**: Percentage of generated SQL that executes without errors (no table/column not found, type errors, etc.)

**Key Insight**: DataMatch is often the most meaningful metric as it focuses on semantic correctness while allowing different column naming conventions.

---

## Overall Summary

| Run | Service | Model | DataMatch | ExecMatch | ExecF1 | Exact Match | Normalized Match | Parse Success | Runtime Success |
|-----|---------|-------|-----------|-----------|--------|-------------|------------------|---------------|----------------|
| 1 | azure | GPT 5.2 Chat | 93.1% | 36.1% | 0.942 | 36.4% | 36.4% | 100.0% | 100.0% |
| 2 | bedrock | anthropic.claude-3-sonnet-20240229-v1:0 | 79.2% | 37.0% | 0.808 | 36.4% | 36.4% | 100.0% | 99.1% |
| 3 | vllm | defog/llama-3-sqlcoder-8b | 49.3% | 24.8% | 0.497 | 24.3% | 24.3% | 70.5% | 66.1% |

## Run 1: azure - GPT 5.2 Chat

### Core Execution Metrics

- **Data Match (Ignoring Column Names)**: 635/682 (93.11%)
  - *Same data values, ignoring column name differences*
- **Execution Accuracy (ExecMatch)**: 246/682 (36.07%)
  - *Exact match including column names*
- **Average ExecF1**: 0.9416
- **Exact Text Match**: 248/682 (36.36%)
- **Normalized Match**: 248/682 (36.36%)
- **Scalar Tolerance**: 1e-05

### Execution Success Rates

- **Parse/Compile Success**: 682/682 (100.00%)
- **Runtime Success**: 682/682 (100.00%)

## Run 2: bedrock - anthropic.claude-3-sonnet-20240229-v1:0

### Core Execution Metrics

- **Data Match (Ignoring Column Names)**: 540/682 (79.18%)
  - *Same data values, ignoring column name differences*
- **Execution Accuracy (ExecMatch)**: 252/682 (36.95%)
  - *Exact match including column names*
- **Average ExecF1**: 0.8082
- **Exact Text Match**: 248/682 (36.36%)
- **Normalized Match**: 248/682 (36.36%)
- **Scalar Tolerance**: 1e-05

### Execution Success Rates

- **Parse/Compile Success**: 682/682 (100.00%)
- **Runtime Success**: 676/682 (99.12%)

### Error Categories

| Error Type | Count | Percentage |
|------------|-------|------------|
| Runtime Error | 6 | 0.88% |

### Error Examples

#### Runtime Error

**Example 1:**

- **Question**: What are the death and injury situations caused by the ship with tonnage 't'?
- **Gold SQL**: ```SELECT `t1`.`killed`, `t1`.`injured` FROM `death` AS `t1` JOIN `ship` AS `t2` ON `t1`.`caused_by_ship_id` = `t2`.`id` WHERE `t2`.`tonnage` = 't'```
- **Generated SQL**: ```SELECT caused_by_ship_id, killed, injured
         FROM battle_death.death
         WHERE caused_by_ship_id = (
           SELECT id
           FROM battle_death.ship
           WHERE tonnage = 't'
         );```
- **Error**: (mysql.connector.errors.DataError) 1242 (21000): Subquery returns more than 1 row
[SQL: SELECT caused_by_ship_id, killed, injured
         FROM battle_death.death
         WHERE caused_by_ship_id = (


**Example 2:**

- **Question**: What is the maker of the carr produced in the earliest year and what year was it?
- **Gold SQL**: ```SELECT `t2`.`Make`, `t1`.`Year` FROM `cars_data` AS `t1` JOIN `car_names` AS `t2` ON `t1`.`Id` = `t2`.`MakeId` WHERE `t1`.`Year` = (SELECT MIN(`YEAR`) FROM `cars_data`)```
- **Generated SQL**: ```SELECT cm.Maker, MIN(cd.Year) AS EarliestYear
FROM car_1.car_makers cm
JOIN car_1.model_list ml ON cm.Id = ml.Maker
JOIN car_1.cars_data cd ON ml.Model = cd.Model
GROUP BY cm.Maker
ORDER BY EarliestYear ASC
LIMIT 1;```
- **Error**: (mysql.connector.errors.ProgrammingError) 1054 (42S22): Unknown column 'cd.Model' in 'on clause'
[SQL: SELECT cm.Maker, MIN(cd.Year) AS EarliestYear
FROM car_1.car_makers cm
JOIN car_1.model_list ml O

**Example 3:**

- **Question**: Which model has the most version(make) of cars?
- **Gold SQL**: ```SELECT `Model` FROM `car_names` GROUP BY `Model` ORDER BY COUNT(*) DESC LIMIT 1```
- **Generated SQL**: ```SELECT Model, COUNT(DISTINCT Make) AS NumVersions
          FROM car_1.model_list
          INNER JOIN car_1.car_names ON car_1.model_list.Model = car_1.car_names.Model
          GROUP BY Model
          ORDER BY NumVersions DESC
          LIMIT 1;```
- **Error**: (mysql.connector.errors.IntegrityError) 1052 (23000): Column 'Model' in field list is ambiguous
[SQL: SELECT Model, COUNT(DISTINCT Make) AS NumVersions
          FROM car_1.model_list
          INNER 

## Run 3: vllm - defog/llama-3-sqlcoder-8b

### Core Execution Metrics

- **Data Match (Ignoring Column Names)**: 336/682 (49.27%)
  - *Same data values, ignoring column name differences*
- **Execution Accuracy (ExecMatch)**: 169/682 (24.78%)
  - *Exact match including column names*
- **Average ExecF1**: 0.4970
- **Exact Text Match**: 166/682 (24.34%)
- **Normalized Match**: 166/682 (24.34%)
- **Scalar Tolerance**: 1e-05

### Execution Success Rates

- **Parse/Compile Success**: 481/682 (70.53%)
- **Runtime Success**: 451/682 (66.13%)

### Error Categories

| Error Type | Count | Percentage |
|------------|-------|------------|
| Syntax Error | 201 | 29.47% |
| Runtime Error | 30 | 4.40% |

### Error Examples

#### Syntax Error

**Example 1:**

- **Question**: What are the name and results of the battles when the bulgarian commander is not 'Boril'
- **Gold SQL**: ```SELECT `name`, `RESULT` FROM `battle` WHERE `bulgarian_commander` <> 'Boril'```
- **Generated SQL**: ```SELECT b.name, b.result FROM battle_death.battle b WHERE b.bulgarian_commander != 'Boril' ORDER BY b.name NULLS LAST;```
- **Error**: (mysql.connector.errors.ProgrammingError) 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'NULLS LAS

**Example 2:**

- **Question**: What are the notes of the death events which has substring 'East'?
- **Gold SQL**: ```SELECT `note` FROM `death` WHERE `note` LIKE '%East%'```
- **Generated SQL**: ```SELECT d.note FROM battle_death.death d WHERE d.note ilike '%East%';```
- **Error**: (mysql.connector.errors.ProgrammingError) 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'ilike '%E

**Example 3:**

- **Question**: How many models does each car maker produce? List maker full name, id and the number.
- **Gold SQL**: ```SELECT `t1`.`FullName`, `t1`.`Id`, COUNT(*) FROM `car_makers` AS `t1` JOIN `model_list` AS `t2` ON `t1`.`Id` = `t2`.`Maker` GROUP BY `t1`.`FullName`, `t1`.`Id````
- **Generated SQL**: ```SELECT c.Maker, c.Id, COUNT(m.ModelId) AS model_count FROM car_1.car_makers c JOIN car_1.model_list m ON c.Id = m.Maker GROUP BY c.Maker, c.Id ORDER BY model_count DESC NULLS LAST```
- **Error**: (mysql.connector.errors.ProgrammingError) 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'NULLS LAS

#### Runtime Error

**Example 1:**

- **Question**: Find the model of the car whose weight is below the average weight.
- **Gold SQL**: ```SELECT `t1`.`model` FROM `car_names` AS `t1` JOIN `cars_data` AS `t2` ON `t1`.`MakeId` = `t2`.`Id` WHERE `t2`.`Weight` < (SELECT AVG(`Weight`) FROM `cars_data`)```
- **Generated SQL**: ```SELECT c.Model FROM car_1.cars_data c WHERE c.Weight < (SELECT AVG(c2.Weight) FROM car_1.cars_data c2);```
- **Error**: (mysql.connector.errors.ProgrammingError) 1054 (42S22): Unknown column 'c.Model' in 'field list'
[SQL: SELECT c.Model FROM car_1.cars_data c WHERE c.Weight < (SELECT AVG(c2.Weight) FROM car_1.cars_dat

**Example 2:**

- **Question**: What is the model for the car with a weight smaller than the average?
- **Gold SQL**: ```SELECT `t1`.`model` FROM `car_names` AS `t1` JOIN `cars_data` AS `t2` ON `t1`.`MakeId` = `t2`.`Id` WHERE `t2`.`Weight` < (SELECT AVG(`Weight`) FROM `cars_data`)```
- **Generated SQL**: ```SELECT c.Model FROM car_1.cars_data c WHERE c.Weight < (SELECT AVG(c2.Weight) FROM car_1.cars_data c2);```
- **Error**: (mysql.connector.errors.ProgrammingError) 1054 (42S22): Unknown column 'c.Model' in 'field list'
[SQL: SELECT c.Model FROM car_1.cars_data c WHERE c.Weight < (SELECT AVG(c2.Weight) FROM car_1.cars_dat

**Example 3:**

- **Question**: Find the make and production time of the cars that were produced in the earliest year?
- **Gold SQL**: ```SELECT `t2`.`Make`, `t1`.`Year` FROM `cars_data` AS `t1` JOIN `car_names` AS `t2` ON `t1`.`Id` = `t2`.`MakeId` WHERE `t1`.`Year` = (SELECT MIN(`YEAR`) FROM `cars_data`)```
- **Generated SQL**: ```SELECT c.Model, c.Year FROM car_1.cars_data c ORDER BY c.Year ASC LIMIT 1;```
- **Error**: (mysql.connector.errors.ProgrammingError) 1054 (42S22): Unknown column 'c.Model' in 'field list'
[SQL: SELECT c.Model, c.Year FROM car_1.cars_data c ORDER BY c.Year ASC LIMIT 1;]
(Background on this e

