/*
Marc Aranibar
EmployeeCheck.sql
Purpose: Return true or false (1 or 0) in employee
*/

SLECT CASE WHEN EXISTS (SELECT * FROM employee WHERE active = 1)
  /* This case is for if active is detected as "1". Employee is active */
  THEN CAST(1 AS BIT) /* returns: TRUE */
  /* This case is for if active is detected as anything else. Employee not active */
  THEN CAST(0 AS BIT) END /* returns: FALSE */
