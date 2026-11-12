
USE master;
GO


IF DB_ID('Store') IS NULL
    CREATE DATABASE Store;
GO

USE Store;
GO


IF OBJECT_ID('dbo.FK_STORE_EMP',    'F') IS NOT NULL ALTER TABLE dbo.STORE    DROP CONSTRAINT FK_STORE_EMP;
IF OBJECT_ID('dbo.FK_STORE_REGION', 'F') IS NOT NULL ALTER TABLE dbo.STORE    DROP CONSTRAINT FK_STORE_REGION;
IF OBJECT_ID('dbo.FK_EMP_STORE',    'F') IS NOT NULL ALTER TABLE dbo.EMPLOYEE DROP CONSTRAINT FK_EMP_STORE;


IF OBJECT_ID('dbo.EMPLOYEE', 'U') IS NOT NULL DROP TABLE dbo.EMPLOYEE;
IF OBJECT_ID('dbo.STORE',    'U') IS NOT NULL DROP TABLE dbo.STORE;
IF OBJECT_ID('dbo.REGION',   'U') IS NOT NULL DROP TABLE dbo.REGION;


IF OBJECT_ID('dbo.SEQ_EMP_CODE', 'SO') IS NOT NULL DROP SEQUENCE dbo.SEQ_EMP_CODE;
GO

CREATE SEQUENCE dbo.SEQ_EMP_CODE
    AS INT
    START WITH 1
    INCREMENT BY 1;
GO


CREATE TABLE dbo.REGION (
    REGION_CODE     INT          NOT NULL,
    REGION_DESCRIPT VARCHAR(50)  NOT NULL,
    CONSTRAINT PK_REGION PRIMARY KEY (REGION_CODE)
);
GO


CREATE TABLE dbo.STORE (
    STORE_CODE      INT             NOT NULL,
    STORE_NAME      VARCHAR(100)    NOT NULL,
    STORE_YTD_SALES DECIMAL(15, 2)  NOT NULL,
    REGION_CODE     INT             NOT NULL,
    EMP_CODE        INT             NOT NULL,          -- store manager
    CONSTRAINT PK_STORE        PRIMARY KEY (STORE_CODE),
    CONSTRAINT FK_STORE_REGION FOREIGN KEY (REGION_CODE) REFERENCES dbo.REGION (REGION_CODE),
    -- CHECK: annual sales must be positive
    CONSTRAINT CK_STORE_YTD    CHECK (STORE_YTD_SALES > 0)
);
GO


CREATE TABLE dbo.EMPLOYEE (
    EMP_CODE    INT          NOT NULL
                             CONSTRAINT DF_EMP_CODE   DEFAULT (NEXT VALUE FOR dbo.SEQ_EMP_CODE),
    EMP_TITLE   VARCHAR(10)  NULL,
    EMP_LNAME   VARCHAR(50)  NOT NULL,
    EMP_FNAME   VARCHAR(50)  NOT NULL,
    EMP_INITIAL CHAR(1)      NULL,
    EMP_DOB     DATE         NOT NULL,
    STORE_CODE  INT          NOT NULL
                             CONSTRAINT DF_EMP_STORE  DEFAULT 3,
    CONSTRAINT PK_EMPLOYEE PRIMARY KEY (EMP_CODE),
    CONSTRAINT FK_EMP_STORE FOREIGN KEY (STORE_CODE) REFERENCES dbo.STORE (STORE_CODE)
);
GO


ALTER TABLE dbo.STORE
    ADD CONSTRAINT FK_STORE_EMP
    FOREIGN KEY (EMP_CODE) REFERENCES dbo.EMPLOYEE (EMP_CODE);
GO


INSERT INTO dbo.REGION (REGION_CODE, REGION_DESCRIPT) VALUES
    (1, 'East'),
    (2, 'West');
GO


ALTER TABLE dbo.STORE NOCHECK CONSTRAINT FK_STORE_EMP;
GO

INSERT INTO dbo.STORE (STORE_CODE, STORE_NAME, STORE_YTD_SALES, REGION_CODE, EMP_CODE) VALUES
    (1, 'Access Junction',  1003455.76, 2,  8),
    (2, 'Database Corner',  1421987.39, 2, 12),
    (3, 'Tuple Charge',      986783.22, 1,  7),
    (4, 'Attribute Alley',   944568.56, 2,  3),
    (5, 'Primary Key Point', 2930098.45, 1, 15);
GO



INSERT INTO dbo.EMPLOYEE (EMP_CODE, EMP_TITLE, EMP_LNAME,     EMP_FNAME,  EMP_INITIAL, EMP_DOB,    STORE_CODE) VALUES
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Williamson', 'John',     'W', '1964-05-21', 3),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Ms.',  'Ratula',     'Nancy',    NULL,'1969-02-09', 2),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Ms.',  'Greenboro',  'Lottie',   'R', '1961-10-02', 4),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mrs.', 'Rumpersfro', 'Jennie',   'S', '1971-06-01', 5),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Smith',      'Robert',   'L', '1959-11-23', 3),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Renselaer',  'Cary',     'A', '1965-12-25', 1),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Ogallo',     'Roberto',  'S', '1962-07-31', 3),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Ms.',  'Johnsson',   'Elizabeth','I', '1968-09-10', 1),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Eindsmar',   'Jack',     'W', '1955-04-19', 2),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mrs.', 'Jones',      'Rose',     'R', '1966-03-06', 4),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Broderick',  'Tom',      NULL,'1972-10-21', 3),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Washington', 'Alan',     'Y', '1974-09-08', 2),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Smith',      'Peter',    'N', '1964-08-25', 3),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Ms.',  'Smith',      'Sherry',   'H', '1966-05-25', 4),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Olenko',     'Howard',   'U', '1964-05-24', 5),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Archialo',   'Barry',    'V', '1960-09-03', 5),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Ms.',  'Grimaldo',   'Jeanine',  'K', '1970-11-12', 4),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Rosenberg',  'Andrew',   'D', '1971-01-24', 4),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Rosten',     'Peter',    'F', '1968-10-03', 4),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Mr.',  'Mckee',      'Robert',   'S', '1970-03-06', 1),
    (NEXT VALUE FOR dbo.SEQ_EMP_CODE, 'Ms.',  'Baumann',    'Jennifer', 'A', '1974-12-11', 3);
GO


ALTER TABLE dbo.STORE WITH CHECK CHECK CONSTRAINT FK_STORE_EMP;
GO


SELECT * FROM dbo.REGION   ORDER BY REGION_CODE;
SELECT * FROM dbo.STORE    ORDER BY STORE_CODE;
SELECT * FROM dbo.EMPLOYEE ORDER BY EMP_CODE;
GO
