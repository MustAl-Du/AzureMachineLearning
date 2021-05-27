/*Replace the URL*/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE NAME = 'Diabetic' AND TYPE = 'U')
CREATE TABLE dbo.Diabetic
(
    PatientID int,
    Pregnancies int,
    PlasmaGlucose int,
    DiastolicBloodPressure int,
    TricepsThickness int,
    SerumInsulin int,
    BMI float,
    DiabetesPedigree float,
    Age int,
    Diabetic int
)
WITH
(
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
)
GO

COPY INTO dbo.Diabetic
(PatientID 1,Pregnancies 2,PlasmaGlucose 3, DiastolicBloodPressure 4,TricepsThickness 5, SerumInsulin 6, BMI 7, DiabetesPedigree 8, Age 9, Diabetic 10)
FROM '<URL to linked storage account>/diabetes.csv'   /*Replace the URL*/
WITH
(
    FILE_TYPE = 'CSV',
    ROWTERMINATOR='0x0A',
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    FIRSTROW = 2
)
GO

SELECT TOP 100 * FROM dbo.Diabetic
GO