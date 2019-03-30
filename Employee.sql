CREATE TABLE employee (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  lastname varchar(255) NOT NULL DEFAULT(''),
  firstname varchar(255) NOT NULL DEFAULT(''),
  employeeid int NOT NULL DEFAULT(0),
  active BIT,
  classification varchar(32),
  password varchar(32),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  manager uuid,
  CONSTRAINT employee_pkey PRIMARY KEY (id),
  FOREIGN KEY (manager) REFERENCES employee(id)
) WITH (
  OIDS=FALSE
);

-- A cheap way to prevent (((them))) from figuring out how many employees you
-- have.  If they figure out who the founder is, it's game over.
CREATE SEQUENCE employee_employeeid_seq AS int START WITH 253 INCREMENT BY 7 OWNED BY employee.employeeid;

ALTER TABLE employee ALTER employeeid SET DEFAULT nextval('employee_employeeid_seq');

INSERT INTO employee (lastName, firstName, active, classification, password) VALUES (
   'Smith',
   'John',
   '1',
   'cashier',
   'password123');

INSERT INTO employee (lastName, firstName, active, classification, password) VALUES (
   'Doe',
   'Jane',
   '1',
   'general manager',
   'password321');

/*
1.) Record ID (This is the primary key of the table)
2.) First name
3.) Last name
4.) Employee ID (Should support up to 5 numerical characters in length)
5.) Active (Indicates whether an employee is active or inactive)
6.) Classification or role (Must maintain 3 or more values starting with: general manager, shift manager, and cashier)
7.) Manager (This is a reference, via the Record ID, to another record in the Employee table. May be empty.)
8.) Password
9.) Created On (timestamp)
*/
