CREATE EXTENSION pgcrypto; --Allows PostgreSQL to understand UUIDs. Only have to create the extension once for a database.

--DROP TABLE product;

CREATE TABLE product (
  id uuid NOT NULL DEFAULT gen_random_uuid(), --The record ID. Stored in the edu.uark.dataaccess.entities:BaseEntity#id property. See also the named constant defined in edu.uark.dataaccess.entities:BaseFieldNames that is used for Java <-> SQL mappings.
  lookupcode character varying(32) NOT NULL DEFAULT(''), --Stored in the edu.uark.models.entities:ProductEntity#lookupCode property. See also the named constant defined in edu.uark.models.entities.fieldnames:ProductFieldNames that is used for Java <-> SQL mappings.
  count int NOT NULL DEFAULT(0), --Stored in the edu.uark.models.entities:ProductEntity#count property. See also the named constant defined in edu.uark.models.entities.fieldnames:ProductFieldNames that is used for Java <-> SQL mappings.
  createdon timestamp without time zone NOT NULL DEFAULT now(), --Stored in the edu.uark.dataaccess.entities:BaseEntity#createdOn property. See also the named constant defined in edu.uark.dataaccess.entities:BaseFieldNames that is used for Java <-> SQL mappings.
  price decimal(12, 2) NOT NULL DEFAULT(0), -- Stored in the edu.uark.edu.models.entities:ProductEntity#price property.  See also the named constant defined in edu.uark.models.entities.fieldNames:ProductFieldNames that is used for Java <-> SQL mappings.
  CONSTRAINT product_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

--DROP INDEX ix_product_lookupcode;

CREATE INDEX ix_product_lookupcode --An index on the product table lookupcode column
  ON product
  USING btree
  (lower(lookupcode::text) COLLATE pg_catalog."default"); --Index on the lower case of the lookup code. Queries for product by lookupcode should search using the lower case of the lookup code.

INSERT INTO product (lookupcode, count, price) VALUES ( --id and createdon are generated by default.
       'lookupcode1', 
        100, 
        1.00
) RETURNING id, createdon;

INSERT INTO product (lookupcode, count, price) VALUES (
       'lookupcode2', 
        125, 
        2.00
) RETURNING id, createdon;

INSERT INTO product (lookupcode, count, price) VALUES (
       'lookupcode3', 
        150,
        3.00
) RETURNING id, createdon;

--SELECT * FROM product;

--DELETE FROM product;

CREATE TABLE employee (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  lastname varchar(255) NOT NULL DEFAULT(''),
  firstname varchar(255) NOT NULL DEFAULT(''),
  employeeid SERIAL,
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
