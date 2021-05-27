/*Replace ONNXModel Table and Model Name*/

IF EXISTS (SELECT * FROM sys.objects WHERE NAME = 'PredictDiabetic' AND TYPE = 'P')
DROP PROCEDURE [dbo].[PredictDiabetic]
GO

CREATE PROCEDURE dbo.PredictDiabetic
AS
BEGIN

SELECT
    CAST([PatientID] AS [bigint]) AS [PatientID],
    CAST([Pregnancies] AS [bigint]) AS [Pregnancies],
    CAST([PlasmaGlucose] AS [bigint]) AS [PlasmaGlucose],
    CAST([DiastolicBloodPressure] AS [bigint]) AS [DiastolicBloodPressure],
    CAST([TricepsThickness] AS [bigint]) AS [TricepsThickness],
    CAST([SerumInsulin] AS [bigint]) AS [SerumInsulin],
    CAST([BMI] AS [real]) AS [BMI],
    CAST([DiabetesPedigree] AS [real]) AS [DiabetesPedigree],
    CAST([Age] AS [bigint]) AS [Age]
INTO [dbo].[#Diabetic]
FROM [dbo].[Diabetic];

SELECT *
FROM PREDICT (MODEL = (
                SELECT [model] FROM dbo.ONNXModel WHERE [ID] = 'DiabeticONNXModel:2' /*Replace ONNXModel Table and Model Name*/
                    ), 
              DATA = [dbo].[#Diabetic],
              RUNTIME = ONNX) WITH ([label] [bigint])

END
GO

EXEC dbo.PredictDiabetic