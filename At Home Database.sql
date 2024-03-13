
CREATE database at_home;
USE at_home;

CREATE TABLE Membership (
    MembershipID CHAR(10) NOT NULL,
    LevelName VARCHAR(20) NOT NULL,
    PRIMARY KEY (MembershipID)
);

CREATE TABLE Customer (
    CustID VARCHAR(5) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Phone VARCHAR(12),
    Email VARCHAR(40) NOT NULL,
    CustAddress VARCHAR(100),
    Gender CHAR(1),
	MemberID CHAR(10) NOT NULL,
    PRIMARY KEY (CustID),
	FOREIGN KEY (MemberID)
   	 REFERENCES Membership (MembershipID)
);

CREATE TABLE DistributionCenter (
    DCID CHAR(1) NOT NULL,
    DCAddress VARCHAR(100) NOT NULL,
    ContactFirstName VARCHAR(20) NOT NULL,
    ContactLastName VARCHAR(20) NOT NULL,
    ContactPhone VARCHAR(12) NOT NULL,
    PRIMARY KEY (DCID)
);

CREATE TABLE Category (
    CatID CHAR(1) NOT NULL,
    CatName VARCHAR(20) NOT NULL,
    Aisle CHAR(2) NOT NULL,
    PRIMARY KEY (CatID)
);

CREATE TABLE Product (
    SKU VARCHAR(20) NOT NULL,
    ProductName VARCHAR(50) NOT NULL,
    Price NUMERIC(6 , 2 ) NOT NULL,
    CatID CHAR(1) NOT NULL,
    PRIMARY KEY (SKU),
    FOREIGN KEY (CatID)
   	 REFERENCES Category (CatID)
);

CREATE TABLE ShiftType (
    ShiftTypeID CHAR(1) NOT NULL,
    ShiftName VARCHAR(20) NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    PRIMARY KEY (ShiftTypeID)
);

CREATE TABLE WorkingShift (
    ShiftID VARCHAR(20) NOT NULL,
    ShiftDate DATE NOT NULL,
    ShiftTypeID CHAR(1) NOT NULL,
    PRIMARY KEY (ShiftID),
    FOREIGN KEY (ShiftTypeID)
   	 REFERENCES ShiftType (ShiftTypeID)
);

CREATE TABLE Employee (
    EmpID VARCHAR(5) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Phone VARCHAR(12) NOT NULL,
    Email VARCHAR(40) NOT NULL,
    DateOfHire DATE NOT NULL,
    Title VARCHAR(20) NOT NULL,
    Salary NUMERIC(8 , 2 ) NOT NULL,
    TermDate DATE,
    PRIMARY KEY (EmpID)
);



CREATE TABLE ClockIn (
    EmpID VARCHAR(5) NOT NULL,
    ShiftID VARCHAR(20) NOT NULL,
    StartTime TIME,
    EndTime TIME,
    PRIMARY KEY (EmpID , ShiftID),
    FOREIGN KEY (EmpID)
   	 REFERENCES Employee (EmpID),
    FOREIGN KEY (ShiftID)
   	 REFERENCES WorkingShift (ShiftID)
);

CREATE TABLE Sale (
    TransNumber VARCHAR(30) NOT NULL,
    TransDate DATE NOT NULL,
    TransType VARCHAR(20) NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    EmpID VARCHAR(5),
    CustID VARCHAR(5),
    PRIMARY KEY (TransNumber),
    FOREIGN KEY (EmpID)
   	 REFERENCES Employee (EmpID),
    FOREIGN KEY (CustID)
   	 REFERENCES Customer (CustID)
);

CREATE TABLE Associated (
    SKU VARCHAR(20) NOT NULL,
    TransNumber VARCHAR(30) NOT NULL,
Quantity INT NOT NULL,
    PRIMARY KEY (SKU , TransNumber),
    FOREIGN KEY (SKU)
   	 REFERENCES Product (SKU),
    FOREIGN KEY (TransNumber)
   	 REFERENCES Sale (TransNumber)
);

CREATE TABLE Supply (
	SupplyID VARCHAR(5) NOT NULL,
	SKU VARCHAR(20) NOT NULL,
	DCID CHAR(1) NOT NULL,
	Quantity INT NOT NULL,
	OrderDate DATE NOT NULL,
	ArrivalDate DATE,
	PRIMARY KEY (SupplyID),
	FOREIGN KEY (SKU)
    	REFERENCES Product (SKU),
	FOREIGN KEY (DCID)
    	REFERENCES DistributionCenter (DCID)
);


SHOW TABLES;


-- SQL for Inserting into Tables

INSERT INTO Membership VALUES ('1001','Bronze');
INSERT INTO Membership VALUES ('1002','Silver');
INSERT INTO Membership VALUES ('1003','Gold');
INSERT INTO Membership VALUES ('1004','Platinum');

INSERT INTO Customer VALUES ('1','John', 'Doe', '555-123-4567', 'john.doe@email.com', '123 Main St', 'M', '1002');
INSERT INTO Customer VALUES ('2','Jane', 'Smith', '555-987-6543', 'jane.smith@email.com', '456 Elm Ave', 'F', '1004');
INSERT INTO Customer VALUES ('3','Michael', 'Johnson', '555-567-8901', 'michael@email.com', '789 Oak Ave', 'M', '1002');
INSERT INTO Customer VALUES ('4','Emily', 'Davis', '555-234-5678', 'emily@email.com', '101 Pine Lane', 'F', '1002');
INSERT INTO Customer VALUES ('5','Mark', 'Wilson', '555-777-8888', 'mark@email.com', '222 Oak St', 'M', '1002');
INSERT INTO Customer VALUES ('6','Sarah', 'Lee', '555-333-4444', 'sarah@email.com', '555 Maple Ave', 'F', '1003');
INSERT INTO Customer VALUES ('7','Robert', 'Brown', '555-888-9999', 'robert@email.com', '777 Birch Rd', 'M', '1004');
INSERT INTO Customer VALUES ('8','Lisa', 'Taylor', '555-111-2222', 'lisa@email.com', '888 Cedar Ln', 'F', '1002');
INSERT INTO Customer VALUES ('9','Chris', 'Green', '555-555-5555', 'chris@email.com', '999 Pine Ave', 'M', '1004');
INSERT INTO Customer VALUES ('10','Amanda', 'Hall', '555-999-8888', 'amanda@email.com', '111 Willow St', 'F', '1002');
INSERT INTO Customer VALUES ('11','James', 'Harris', '555-222-3333', 'james@email.com', '123 Oak Ave', 'M', '1004');
INSERT INTO Customer VALUES ('12','Laura', 'Turner', '555-444-5555', 'laura@email.com', '456 Elm St', 'F', '1004');
INSERT INTO Customer VALUES ('13','David', 'White', '555-666-7777', 'david@email.com', '789 Pine Rd', 'M', '1004');
INSERT INTO Customer VALUES ('14','Susan', 'Moore', '555-333-4444', 'susan@email.com', '101 Birch Ave', 'F', '1003');
INSERT INTO Customer VALUES ('15','Brian', 'Young', '555-888-9999', 'brian@email.com', '222 Cedar St', 'M', '1003');
INSERT INTO Customer VALUES ('16','Karen', 'King', '555-111-2222', 'karen@email.com', '555 Willow Rd', 'F', '1001');
INSERT INTO Customer VALUES ('17','Michael', 'Turner', '555-777-8888', 'michael@email.com', '777 Pine Ave', 'M', '1001');
INSERT INTO Customer VALUES ('18','Nancy', 'Allen', '555-555-5555', 'nancy@email.com', '888 Elm Ln', 'F', '1002');
INSERT INTO Customer VALUES ('19','Robert', 'Johnson', '555-123-5647', 'robert@email.com', '999 Oak St', 'M', '1004');
INSERT INTO Customer VALUES ('20','Mary', 'Lee', '918-999-8888', 'mary@email.com', '111 Maple Rd', 'F', '1004');
INSERT INTO Customer VALUES ('21','William', 'Baker', '918-234-5678', 'william@email.com', '123 Pine Ave', 'M', '1004');
INSERT INTO Customer VALUES ('22','Linda', 'Walker', '918-333-444', 'linda@email.com', '456 Oak Ln', 'F', '1002');
INSERT INTO Customer VALUES ('23','Joseph', 'Martin', '918-888-9999', 'joseph@email.com', '789 Birch St', 'M', '1002');
INSERT INTO Customer VALUES ('24','Patricia', 'King', '918-555-2222', 'patricia@email.com', '101 Cedar Rd', 'F', '1002');
INSERT INTO Customer VALUES ('25','Christopher', 'Clark', '918-777-8888', 'christopher@email.com', '222 Willow Ave', 'M', '1003');
INSERT INTO Customer VALUES ('26','Susan', 'Scott', '918-555-5555', 'susan.scott@email.com', '555 Pine Ln', 'F', '1001');
INSERT INTO Customer VALUES ('27','Robert', 'Hall', '918-123-4567', 'robert.hall@email.com', '777 Oak St', 'M', '1003');
INSERT INTO Customer VALUES ('28','Karen', 'Allen', '918-341-4616', 'karen.allen@email.com', '888 Maple Rd', 'F', '1004');
INSERT INTO Customer VALUES ('29','Michael', 'Tucker', '423-383-4645', 'mike.tucker@email.com', '999 Cedar Ave', 'M', '1001');
INSERT INTO Customer VALUES ('30','Laura', 'Walker', '423-785-4158', 'laura.walker@email.com', '111 Birch St', 'F', '1002');

INSERT INTO DistributionCenter VALUES ('1', '123 Warehouse St', 'John', 'Walker', 856-111-2222);
INSERT INTO DistributionCenter VALUES ('2', '456 Storage Ave', 'Sarah', 'Ferguson', 852-222-3333);
INSERT INTO DistributionCenter VALUES ('3', '789 Distribution Rd', 'Robert', 'Stevens', 852-333-4444);
INSERT INTO DistributionCenter VALUES ('4', '101 Logistics Ln', 'Lisa', 'Herries', 383-444-5555);
INSERT INTO DistributionCenter VALUES ('5', '555 Supply St', 'David', 'Whitacre', 817-555-5555);

INSERT INTO Category VALUES ('1', 'Furniture', 1);
INSERT INTO Category VALUES ('2', 'Outdoor', 2);
INSERT INTO Category VALUES ('3', 'Decor & Pillows', 3);
INSERT INTO Category VALUES ('4', 'Rugs & Curtains', 4);
INSERT INTO Category VALUES ('5', 'Wall Decor', 5);
INSERT INTO Category VALUES ('6', 'Kitchen & Dining', 6);
INSERT INTO Category VALUES ('7', 'Bed & Bath', 7);
INSERT INTO Category VALUES ('8', 'Storage & Cleaning', 8);
INSERT INTO Category VALUES ('9', 'Seasonal', 9);
INSERT INTO Category VALUES ('0', 'Clearance', 10);

INSERT INTO Product VALUES ('5001', 'Sofa', '299.99', 1);
INSERT INTO Product VALUES ('5002', 'Coffee Table', '149.99', 1);
INSERT INTO Product VALUES ('5003', 'Dining Table', '199.99', 1);
INSERT INTO Product VALUES ('5004', 'Chair', '79.99', 1);
INSERT INTO Product VALUES ('5005', 'Desk', '49.99', 1);
INSERT INTO Product VALUES ('5006', 'Outdoor Chair', '199.99', 2);
INSERT INTO Product VALUES ('5007', 'Outdoor Table', '499.99', 2);
INSERT INTO Product VALUES ('5008', 'Wall Art', '99.99', 5);
INSERT INTO Product VALUES ('5009', 'Throw Pillow', '39.99', 3);
INSERT INTO Product VALUES ('5010', 'Bed', '199.99', 7);
INSERT INTO Product VALUES ('5011', 'Bath Towel', '29.99', 7);
INSERT INTO Product VALUES ('5012', 'Storage Cabinet', '79.99', 8);
INSERT INTO Product VALUES ('5013', 'Storage Bin', '19.99', 8);
INSERT INTO Product VALUES ('5014', 'Christmas Tree', '149.99', 9);
INSERT INTO Product VALUES ('5015', 'Halloween Decor', '9.99', 9);
INSERT INTO Product VALUES ('5016', 'Clearance Rug', '129.99', 0);
INSERT INTO Product VALUES ('5017', 'Clearance Decor', '149.99', 0);
INSERT INTO Product VALUES ('5018', 'Clearance Furniture', '199.99', 0);
INSERT INTO Product VALUES ('5019', 'Clearance Outdoor', '399.99', 0);
INSERT INTO Product VALUES ('5020', 'Clearance Bedding', '49.99', 0);

INSERT INTO ShiftType VALUES ('1', 'Day', '06:00', '14:00');
INSERT INTO ShiftType VALUES ('2', 'Afternoon', '14:00', '22:00');
INSERT INTO ShiftType VALUES ('3', 'Night', '22:00', '06:00');

INSERT INTO WorkingShift VALUES ('7001', '2023-10-01', '1');
INSERT INTO WorkingShift VALUES ('7002', '2023-10-01', '2');
INSERT INTO WorkingShift VALUES ('7003', '2023-10-01', '3');
INSERT INTO WorkingShift VALUES ('7004', '2023-10-02', '1');
INSERT INTO WorkingShift VALUES ('7005', '2023-10-02', '2');
INSERT INTO WorkingShift VALUES ('7006', '2023-10-02', '3');
INSERT INTO WorkingShift VALUES ('7007', '2023-10-03', '1');
INSERT INTO WorkingShift VALUES ('7008', '2023-10-03', '2');
INSERT INTO WorkingShift VALUES ('7009', '2023-10-03', '3');
INSERT INTO WorkingShift VALUES ('7010', '2023-10-04', '1');
INSERT INTO WorkingShift VALUES ('7011', '2023-10-04', '2');
INSERT INTO WorkingShift VALUES ('7012', '2023-10-04', '3');
INSERT INTO WorkingShift VALUES ('7013', '2023-10-05', '1');
INSERT INTO WorkingShift VALUES ('7014', '2023-10-05', '2');
INSERT INTO WorkingShift VALUES ('7015', '2023-10-05', '3');
INSERT INTO WorkingShift VALUES ('7016', '2023-10-06', '1');
INSERT INTO WorkingShift VALUES ('7017', '2023-10-06', '2');
INSERT INTO WorkingShift VALUES ('7018', '2023-10-06', '3');
INSERT INTO WorkingShift VALUES ('7019', '2023-10-07', '1');
INSERT INTO WorkingShift VALUES ('7020', '2023-10-07', '2');
INSERT INTO WorkingShift VALUES ('7021', '2023-10-07', '3');
INSERT INTO WorkingShift VALUES ('7022', '2023-10-08', '1');
INSERT INTO WorkingShift VALUES ('7023', '2023-10-08', '2');
INSERT INTO WorkingShift VALUES ('7024', '2023-10-08', '3');
INSERT INTO WorkingShift VALUES ('7025', '2023-10-09', '1');
INSERT INTO WorkingShift VALUES ('7026', '2023-10-09', '2');
INSERT INTO WorkingShift VALUES ('7027', '2023-10-09', '3');
INSERT INTO WorkingShift VALUES ('7028', '2023-10-10', '1');
INSERT INTO WorkingShift VALUES ('7029', '2023-10-10', '2');
INSERT INTO WorkingShift VALUES ('7030', '2023-10-10', '3');

INSERT INTO Employee VALUES ('3001', 'Sarah', 'Johnson', '423-111-2222', 'sarah.johnson@email.com', '2022-01-15', 'Cashier', 45000.00, null);
INSERT INTO Employee VALUES ('3002', 'David', 'Smith', '423-222-3333', 'david.smith@email.com', '2021-03-20', 'CSR', 52000.00, null);
INSERT INTO Employee VALUES ('3003', 'Emily', 'Davis', '423-333-4444', 'emily.davis@email.com', '2022-05-10', 'Associate', 48000.00, null);
INSERT INTO Employee VALUES ('3004', 'Michael', 'Wilson', '423-444-5555', 'michael.wilson@email.com', '2022-06-15', 'Specialist', 55000.00, null);
INSERT INTO Employee VALUES ('3005', 'Mark', 'Lee', '423-555-6666', 'mark.lee@email.com', '2022-11-05', 'Store Operations', 60000.00, null);

INSERT INTO ClockIn VALUES ('3001', '7001', '06:36', '14:02');
INSERT INTO ClockIn VALUES ('3002', '7001', '05:56', '14:03');
INSERT INTO ClockIn VALUES ('3003', '7002', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3004', '7002', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3005', '7003', '22:23', '06:01');
INSERT INTO ClockIn VALUES ('3001', '7004', '05:58', '14:02');
INSERT INTO ClockIn VALUES ('3002', '7004', '05:56', '14:03');
INSERT INTO ClockIn VALUES ('3003', '7005', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3004', '7005', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3005', '7006', '21:59', '06:01');
INSERT INTO ClockIn VALUES ('3001', '7007', '05:58', '14:02');
INSERT INTO ClockIn VALUES ('3002', '7007', '05:56', '14:03');
INSERT INTO ClockIn VALUES ('3003', '7008', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3004', '7008', '14:16', '22:02');
INSERT INTO ClockIn VALUES ('3005', '7009', '21:59', '06:01');
INSERT INTO ClockIn VALUES ('3001', '7010', '05:58', '14:02');
INSERT INTO ClockIn VALUES ('3002', '7010', '05:56', '14:03');
INSERT INTO ClockIn VALUES ('3003', '7011', '14:15', '22:02');
INSERT INTO ClockIn VALUES ('3004', '7011', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3005', '7012', '21:59', '06:01');
INSERT INTO ClockIn VALUES ('3001', '7013', '05:58', '14:02');
INSERT INTO ClockIn VALUES ('3002', '7013', '05:56', '14:03');
INSERT INTO ClockIn VALUES ('3003', '7014', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3004', '7014', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3005', '7015', '21:59', '06:01');
INSERT INTO ClockIn VALUES ('3001', '7016', '05:58', '14:02');
INSERT INTO ClockIn VALUES ('3002', '7016', '05:56', '14:03');
INSERT INTO ClockIn VALUES ('3003', '7017', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3004', '7017', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3005', '7018', '21:59', '06:01');
INSERT INTO ClockIn VALUES ('3001', '7019', '05:58', '14:02');
INSERT INTO ClockIn VALUES ('3002', '7019', '05:56', '14:03');
INSERT INTO ClockIn VALUES ('3003', '7020', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3004', '7020', '13:57', '22:02');
INSERT INTO ClockIn VALUES ('3005', '7021', '21:59', '06:01');


INSERT INTO Sale VALUES ('2001', '2023-10-05', 'In-Store', 'Credit Card', '3003','1');
INSERT INTO Sale VALUES ('2002', '2023-10-05', 'Online', 'PayPal', '3004','19');
INSERT INTO Sale VALUES ('2003', '2023-10-02', 'In-Store', 'Cash', '3001','1');
INSERT INTO Sale VALUES ('2004', '2023-10-01', 'Online', 'Credit Card', '3003','13');
INSERT INTO Sale VALUES ('2005', '2023-10-04', 'In-Store', 'Debit Card', '3003','20');
INSERT INTO Sale VALUES ('2006', '2023-10-05', 'Online', 'PayPal', '3001','30');
INSERT INTO Sale VALUES ('2007', '2023-10-03', 'In-Store', 'Cash', '3005','18');
INSERT INTO Sale VALUES ('2008', '2023-10-07', 'Online', 'Credit Card', '3005','19');
INSERT INTO Sale VALUES ('2009', '2023-10-02', 'In-Store', 'Debit Card', '3004','18');
INSERT INTO Sale VALUES ('2010', '2023-10-03', 'Online', 'PayPal', '3003','8');
INSERT INTO Sale VALUES ('2011', '2023-10-07', 'In-Store', 'Credit Card', '3005','15');
INSERT INTO Sale VALUES ('2012', '2023-10-06', 'Online', 'PayPal', '3002','15');
INSERT INTO Sale VALUES ('2013', '2023-10-04', 'In-Store', 'Cash', '3001','25');
INSERT INTO Sale VALUES ('2014', '2023-10-02', 'Online', 'Credit Card', '3002','23');
INSERT INTO Sale VALUES ('2015', '2023-10-07', 'In-Store', 'Debit Card', '3004','10');
INSERT INTO Sale VALUES ('2016', '2023-10-06', 'Online', 'PayPal', '3005','22');
INSERT INTO Sale VALUES ('2017', '2023-10-05', 'In-Store', 'Cash', '3004','5');
INSERT INTO Sale VALUES ('2018', '2023-10-04', 'Online', 'Credit Card', '3005','16');
INSERT INTO Sale VALUES ('2019', '2023-10-01', 'In-Store', 'Debit Card', '3001','16');
INSERT INTO Sale VALUES ('2020', '2023-10-07', 'Online', 'PayPal', '3004','7');
INSERT INTO Sale VALUES ('2021', '2023-10-02', 'In-Store', 'Credit Card', '3005','19');
INSERT INTO Sale VALUES ('2022', '2023-10-01', 'Online', 'PayPal', '3004','13');
INSERT INTO Sale VALUES ('2023', '2023-10-06', 'In-Store', 'Cash', '3003','15');
INSERT INTO Sale VALUES ('2024', '2023-10-05', 'Online', 'Credit Card', '3004','1');
INSERT INTO Sale VALUES ('2025', '2023-10-05', 'In-Store', 'Debit Card', '3001','24');
INSERT INTO Sale VALUES ('2026', '2023-10-04', 'Online', 'PayPal', '3004','6');
INSERT INTO Sale VALUES ('2027', '2023-10-07', 'In-Store', 'Cash', '3001','12');
INSERT INTO Sale VALUES ('2028', '2023-10-01', 'Online', 'Credit Card', '3001','21');
INSERT INTO Sale VALUES ('2029', '2023-10-07', 'In-Store', 'Debit Card', '3005','7');
INSERT INTO Sale VALUES ('2030', '2023-10-03', 'Online', 'PayPal', '3005','28');
INSERT INTO Sale VALUES ('2031', '2023-10-06', 'In-Store', 'Cash', '3002','7');
INSERT INTO Sale VALUES ('2032', '2023-10-02', 'Online', 'Credit Card', '3003','17');
INSERT INTO Sale VALUES ('2033', '2023-10-02', 'In-Store', 'Debit Card', '3005','22');
INSERT INTO Sale VALUES ('2034', '2023-10-03', 'Online', 'PayPal', '3005','18');
INSERT INTO Sale VALUES ('2035', '2023-10-02', 'In-Store', 'Credit Card', '3005','26');
INSERT INTO Sale VALUES ('2036', '2023-10-02', 'Online', 'PayPal', '3003','5');
INSERT INTO Sale VALUES ('2037', '2023-10-02', 'In-Store', 'Cash', '3003','13');
INSERT INTO Sale VALUES ('2038', '2023-10-05', 'Online', 'Credit Card', '3003','14');
INSERT INTO Sale VALUES ('2039', '2023-10-04', 'In-Store', 'Debit Card', '3005','11');
INSERT INTO Sale VALUES ('2040', '2023-10-03', 'Online', 'PayPal', '3003','3');

INSERT INTO Associated VALUES ('5008', '2025', 10);
INSERT INTO Associated VALUES ('5019', '2009', 5);
INSERT INTO Associated VALUES ('5017', '2028', 1);
INSERT INTO Associated VALUES ('5002', '2039', 2);
INSERT INTO Associated VALUES ('5014', '2039', 1);
INSERT INTO Associated VALUES ('5018', '2025', 3);
INSERT INTO Associated VALUES ('5015', '2039', 6);
INSERT INTO Associated VALUES ('5018', '2005', 8);
INSERT INTO Associated VALUES ('5013', '2037', 5);
INSERT INTO Associated VALUES ('5007', '2003', 1);
INSERT INTO Associated VALUES ('5005', '2017', 2);
INSERT INTO Associated VALUES ('5010', '2029', 1);
INSERT INTO Associated VALUES ('5013', '2006', 1);
INSERT INTO Associated VALUES ('5009', '2031', 2);
INSERT INTO Associated VALUES ('5019', '2019', 1);
INSERT INTO Associated VALUES ('5018', '2034', 3);
INSERT INTO Associated VALUES ('5020', '2038', 8);
INSERT INTO Associated VALUES ('5013', '2030', 2);
INSERT INTO Associated VALUES ('5002', '2018', 1);
INSERT INTO Associated VALUES ('5019', '2038', 2);
INSERT INTO Associated VALUES ('5017', '2018', 9);
INSERT INTO Associated VALUES ('5018', '2030', 2);
INSERT INTO Associated VALUES ('5002', '2012', 1);
INSERT INTO Associated VALUES ('5015', '2027', 1);
INSERT INTO Associated VALUES ('5015', '2030', 2);
INSERT INTO Associated VALUES ('5007', '2033', 1);
INSERT INTO Associated VALUES ('5009', '2038', 4);
INSERT INTO Associated VALUES ('5018', '2016', 4);
INSERT INTO Associated VALUES ('5017', '2029', 3);
INSERT INTO Associated VALUES ('5013', '2038', 2);
INSERT INTO Associated VALUES ('5003', '2020', 1);
INSERT INTO Associated VALUES ('5007', '2017', 1);
INSERT INTO Associated VALUES ('5003', '2021', 3);
INSERT INTO Associated VALUES ('5006', '2039', 5);
INSERT INTO Associated VALUES ('5016', '2001', 6);
INSERT INTO Associated VALUES ('5020', '2004', 1);
INSERT INTO Associated VALUES ('5005', '2003', 3);
INSERT INTO Associated VALUES ('5009', '2020', 1);
INSERT INTO Associated VALUES ('5010', '2012', 2);
INSERT INTO Associated VALUES ('5002', '2030', 2);
INSERT INTO Associated VALUES ('5014', '2008', 1);
INSERT INTO Associated VALUES ('5002', '2034', 4);
INSERT INTO Associated VALUES ('5019', '2007', 10);
INSERT INTO Associated VALUES ('5007', '2016', 1);
INSERT INTO Associated VALUES ('5001', '2022', 2);
INSERT INTO Associated VALUES ('5004', '2001', 3);
INSERT INTO Associated VALUES ('5016', '2002', 1);
INSERT INTO Associated VALUES ('5009', '2010', 3);
INSERT INTO Associated VALUES ('5017', '2011', 2);
INSERT INTO Associated VALUES ('5013', '2013', 5);
INSERT INTO Associated VALUES ('5002', '2014', 7);
INSERT INTO Associated VALUES ('5008', '2015', 8);
INSERT INTO Associated VALUES ('5017', '2023', 1);
INSERT INTO Associated VALUES ('5016', '2024', 1);
INSERT INTO Associated VALUES ('5002', '2026', 1);
INSERT INTO Associated VALUES ('5008', '2032', 1);
INSERT INTO Associated VALUES ('5011', '2035', 1);
INSERT INTO Associated VALUES ('5015', '2036', 2);
INSERT INTO Associated VALUES ('5002', '2040', 1);

INSERT INTO Supply VALUES ('4001', '5001', '5', 47, '2023-08-22', '2023-09-06');
INSERT INTO Supply VALUES ('4002', '5001', '1', 10, '2023-07-15', '2023-08-05');
INSERT INTO Supply VALUES ('4003', '5001', '4', 46, '2023-06-08', '2023-06-25');
INSERT INTO Supply VALUES ('4004', '5002', '3', 92, '2023-08-22', '2023-09-21');
INSERT INTO Supply VALUES ('4005', '5002', '1', 28, '2023-07-03', '2023-07-28');
INSERT INTO Supply VALUES ('4006', '5002', '4', 52, '2023-08-30', '2023-09-14');
INSERT INTO Supply VALUES ('4007', '5003', '2', 56, '2023-06-07', '2023-06-27');
INSERT INTO Supply VALUES ('4008', '5003', '3', 78, '2023-07-17', '2023-08-13');
INSERT INTO Supply VALUES ('4009', '5003', '5', 33, '2023-08-28', '2023-09-17');
INSERT INTO Supply VALUES ('4010', '5004', '1', 87, '2023-07-26', '2023-08-17');
INSERT INTO Supply VALUES ('4011', '5004', '3', 34, '2023-08-06', '2023-09-04');
INSERT INTO Supply VALUES ('4012', '5004', '4', 80, '2023-07-28', '2023-08-20');
INSERT INTO Supply VALUES ('4013', '5005', '4', 74, '2023-06-20', '2023-07-12');
INSERT INTO Supply VALUES ('4014', '5005', '5', 14, '2023-06-17', '2023-07-07');
INSERT INTO Supply VALUES ('4015', '5005', '3', 65, '2023-06-20', '2023-07-07');
INSERT INTO Supply VALUES ('4016', '5006', '2', 54, '2023-08-31', '2023-09-26');
INSERT INTO Supply VALUES ('4017', '5006', '3', 11, '2023-06-06', '2023-06-21');
INSERT INTO Supply VALUES ('4018', '5006', '4', 29, '2023-06-10', '2023-07-07');
INSERT INTO Supply VALUES ('4019', '5007', '5', 82, '2023-08-13', '2023-08-28');
INSERT INTO Supply VALUES ('4020', '5007', '4', 33, '2023-06-13', '2023-07-09');
INSERT INTO Supply VALUES ('4021', '5007', '3', 78, '2023-07-04', '2023-07-30');
INSERT INTO Supply VALUES ('4022', '5008', '4', 46, '2023-07-07', '2023-08-03');
INSERT INTO Supply VALUES ('4023', '5008', '1', 11, '2023-07-14', '2023-08-02');
INSERT INTO Supply VALUES ('4024', '5008', '2', 50, '2023-07-03', '2023-07-27');
INSERT INTO Supply VALUES ('4025', '5009', '5', 83, '2023-06-29', '2023-07-29');
INSERT INTO Supply VALUES ('4026', '5009', '2', 97, '2023-07-08', '2023-07-29');
INSERT INTO Supply VALUES ('4027', '5009', '3', 58, '2023-07-01', '2023-07-18');
INSERT INTO Supply VALUES ('4028', '5010', '3', 94, '2023-07-11', '2023-08-02');
INSERT INTO Supply VALUES ('4029', '5010', '1', 92, '2023-06-30', '2023-07-22');
INSERT INTO Supply VALUES ('4030', '5010', '2', 41, '2023-07-27', '2023-08-19');
INSERT INTO Supply VALUES ('4031', '5011', '5', 22, '2023-06-12', '2023-06-30');
INSERT INTO Supply VALUES ('4032', '5011', '1', 64, '2023-07-03', '2023-08-01');
INSERT INTO Supply VALUES ('4033', '5011', '2', 85, '2023-07-15', '2023-08-11');
INSERT INTO Supply VALUES ('4034', '5012', '2', 72, '2023-07-08', '2023-08-02');
INSERT INTO Supply VALUES ('4035', '5012', '4', 60, '2023-08-14', '2023-09-13');
INSERT INTO Supply VALUES ('4036', '5012', '3', 93, '2023-06-09', '2023-07-04');
INSERT INTO Supply VALUES ('4037', '5013', '1', 27, '2023-06-15', '2023-07-07');
INSERT INTO Supply VALUES ('4038', '5013', '2', 47, '2023-07-16', '2023-08-03');
INSERT INTO Supply VALUES ('4039', '5013', '3', 27, '2023-06-22', '2023-07-16');
INSERT INTO Supply VALUES ('4040', '5014', '5', 78, '2023-07-27', '2023-08-18');
INSERT INTO Supply VALUES ('4041', '5014', '3', 42, '2023-08-26', '2023-09-25');
INSERT INTO Supply VALUES ('4042', '5014', '2', 59, '2023-08-31', '2023-09-16');
INSERT INTO Supply VALUES ('4043', '5015', '4', 48, '2023-08-03', '2023-08-20');
INSERT INTO Supply VALUES ('4044', '5015', '5', 96, '2023-06-05', '2023-06-28');
INSERT INTO Supply VALUES ('4045', '5015', '2', 93, '2023-06-10', '2023-07-05');
INSERT INTO Supply VALUES ('4046', '5016', '1', 48, '2023-07-25', '2023-08-24');
INSERT INTO Supply VALUES ('4047', '5016', '4', 25, '2023-07-14', '2023-07-30');
INSERT INTO Supply VALUES ('4048', '5016', '2', 71, '2023-07-15', '2023-08-14');
INSERT INTO Supply VALUES ('4049', '5017', '4', 16, '2023-08-20', '2023-09-12');
INSERT INTO Supply VALUES ('4050', '5017', '2', 60, '2023-07-09', '2023-08-01');
INSERT INTO Supply VALUES ('4051', '5017', '5', 51, '2023-08-19', '2023-09-11');
INSERT INTO Supply VALUES ('4052', '5018', '1', 21, '2023-07-01', '2023-07-21');
INSERT INTO Supply VALUES ('4053', '5018', '4', 77, '2023-06-27', '2023-07-12');
INSERT INTO Supply VALUES ('4054', '5018', '3', 37, '2023-07-23', '2023-08-12');
INSERT INTO Supply VALUES ('4055', '5019', '2', 47, '2023-08-06', '2023-08-23');
INSERT INTO Supply VALUES ('4056', '5019', '4', 46, '2023-06-26', '2023-07-14');
INSERT INTO Supply VALUES ('4057', '5019', '5', 50, '2023-08-13', '2023-08-29');
INSERT INTO Supply VALUES ('4058', '5020', '1', 84, '2023-06-10', '2023-06-26');
INSERT INTO Supply VALUES ('4059', '5020', '2', 100, '2023-08-02', '2023-08-23');
INSERT INTO Supply VALUES ('4060', '5020', '4', 16, '2023-07-04', '2023-07-22');




-- SQL for Managerial Questions

-- 1. Top 3 categories by sales
SELECT
	CatName, SUM(a.Quantity) * p.Price AS 'Total Sales'
FROM
	Category c,
	Product p,
	Associated a
WHERE
	p.CatID = c.CatID AND p.SKU = a.SKU
GROUP BY c.CatID
ORDER BY SUM(a.Quantity) DESC
LIMIT 3;

-- 2. Top 3 categories by volume
SELECT
	CatName, SUM(a.Quantity) AS 'Volume Sold'
FROM
	Category c,
	Product p,
	Associated a
WHERE
	p.CatID = c.CatID AND p.SKU = a.SKU
GROUP BY c.CatID
ORDER BY SUM(a.Quantity) DESC
LIMIT 3;

-- 3. Average transaction total
SELECT
	AVG(x.TotalSales) AS 'Average Sale'
FROM
	(SELECT
    	SUM(a.Quantity) * p.Price TotalSales
	FROM
    	Sale s, Associated a, Product p
	WHERE
    	a.TransNumber = s.TransNumber
        	AND p.SKU = a.SKU
	GROUP BY s.TransNumber) x;

-- 4. Average items per transaction
SELECT
	AVG(x.TotalItems) AS 'Average Items Per Transaction'
FROM
	(SELECT
    	TransNumber, SUM(Quantity) AS TotalItems
	FROM
    	Associated
	GROUP BY TransNumber) x;

-- 5. Average product price per transaction sold
SELECT AVG(x.av) as 'Avg Price Transaction'
FROM
(SELECT
    	a.TransNumber, SUM(p.Price * a.Quantity)/sum(a.Quantity) as av
	FROM
    	Associated a
	JOIN Product p ON a.SKU = p.SKU
	GROUP BY a.TransNumber) x;

-- 6. Top online sales
SELECT
	s.TransNumber,
	s.TransDate,
	SUM(p.Price * a.Quantity) AS 'Total Sale Amount'
FROM
	Sale s
    	JOIN
	Associated a ON s.TransNumber = a.TransNumber
    	JOIN
	Product p ON a.SKU = p.SKU
WHERE
	s.TransType = 'Online'
GROUP BY s.TransNumber , s.TransDate
ORDER BY SUM(p.Price * a.Quantity) DESC;


-- 7. Total Sales and transactions by membership level

SELECT
	Membership.LevelName,
	SUM(Product.Price * Associated.Quantity) AS TotalSalesByTier,
	COUNT(Sale.TransNumber) AS 'Num Of Transactions'
FROM
	Membership,
	Customer,
	Sale,
	Associated,
	Product
WHERE
	Membership.MembershipID = Customer.MemberID
    	AND Customer.CustID = Sale.CustID
    	AND Sale.TransNumber = Associated.TransNumber
    	AND Associated.SKU = Product.SKU
GROUP BY Membership.LevelName;


-- 8. Supplies that arrive 25 days or more after ordering
SELECT
	SKU,
	DCID,
	OrderDate,
	ArrivalDate,
	DATEDIFF(ArrivalDate, OrderDate) AS 'Days to arrive'
FROM
	Supply
WHERE
	DATEDIFF(ArrivalDate, OrderDate) >= 25;
    
-- 9. Employees shifts at least 15 minutes late
SELECT
	e.EmpID,
	e.FirstName,
	e.LastName,
	w.ShiftDate,
	c.StartTime AS 'Clock in time',
	s.StartTime AS 'Scheduled Start',
	TIMEDIFF(c.StartTime, s.StartTime) AS 'Minutes Late'
FROM
	Employee e,
	ClockIn c,
	WorkingShift w,
	ShiftType s
WHERE
	e.EmpID = c.EmpID
    	AND c.ShiftID = w.ShiftID
    	AND w.ShiftTypeID = s.ShiftTypeID
    	AND TIMEDIFF(c.StartTime, s.StartTime) >= '00:15:00';
   	 
-- 10. Repeat customers
SELECT
	c.CustID,
	c.FirstName,
	c.LastName,
	COUNT(s.TransNumber) 'Num of Transactions'
FROM
	Customer c,
	Sale s
WHERE
	c.CustID = s.CustID
GROUP BY c.CustID
HAVING COUNT(s.TransNumber) >= 2;

-- 11. Which employees are working the most number of shifts?
SELECT
	e.EmpID,
	e.FirstName,
	e.LastName,
	COUNT(ws.ShiftID) AS NumberOfShifts
FROM
	Employee e
JOIN
	ClockIn c ON e.EmpID = c.EmpID
JOIN
	WorkingShift ws ON c.ShiftID = ws.ShiftID
GROUP BY
	e.EmpID, e.FirstName, e.LastName
ORDER BY
	NumberOfShifts DESC;
