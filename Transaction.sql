CREATE TABLE transaction (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  quantity int NOT NULL DEFAULT(1),
  totalcost float(8,2) NOT NULL DEFAULT(0.00),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  product uuid,
  employee uuid,
  CONSTRAINT transaction_pkey PRIMARY KEY (id),
  FOREIGN KEY (product) REFERENCES product(id),
  FOREIGN KEY (employee) REFERENCES employee(id)
) WITH (
  OIDS=FALSE
);