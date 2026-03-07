create database hospital

use hospital


CREATE TABLE [dbo].[FactTable](
    [FactTablePK] varchar(255)                     Not NULL Primary Key
    ,[dimPatientPK] varchar(255)                   Not NULL
    ,[dimPhysicianPK] varchar(255)                 Not NULL
    ,[dimDatePostPK] varchar(255)                  Not NULL
    ,[dimDateServicePK] varchar(255)               Not NULL
    ,[dimCPTCodePK] varchar(255)                   Not NULL
    ,[dimPayerPK] varchar(255)                     Not NULL
    ,[dimTransactionPK] varchar(255)               Not NULL
    ,[dimLocationPK] varchar(255)                  Not NULL
    ,[PatientNumber] varchar(255)                  Not NULL
    ,[dimDiagnosisCodePK] varchar(255)             Not NULL
    ,[CPTUnits] decimal(12,2)                      NULL Default 0
    ,[GrossCharge] decimal(12,2)                   NULL Default 0
    ,[Payment] decimal(12,2)                       NULL Default 0
    ,[Adjustment] decimal(12,2)                    NULL Default 0
    ,[AR] decimal(12,2)                            NULL Default 0
    )

    select * from FactTable


CREATE TABLE [dbo].[dimPatient](
    [dimPatientPK] varchar(255)               Not NULL Primary Key
    ,[PatientNumber] varchar(255)             NULL
    ,[FirstName] varchar(255)                 NULL
    ,[LastName] varchar(255)                  NULL
    ,[Email] varchar(255)                     NULL
    ,[PatientGender] varchar(255)             NULL
    ,[PatientAge] integer                     NULL
    ,[City] varchar(255)                      NULL
    ,[State] varchar(255)                     NULL
    
    )    

    select * from dimPatient


CREATE TABLE [dbo].[dimTransaction](
    [dimTransactionPK] varchar(255)                Not NULL Primary Key
    ,[TransactionType] varchar(255)                NULL
    ,[Transaction] varchar(255)                    NULL
    ,[AdjustmentReason] varchar(255)               NULL

    )    

    select * from dimTransaction


CREATE TABLE [dbo].[dimPhysician](
    [dimPhysicianPK] varchar(255)                Not NULL Primary Key
    ,[ProviderNpi] varchar(255)                  NULL
    ,[ProviderName] varchar(255)                 NULL
    ,[ProviderSpecialty] varchar(255)            NULL
    ,[ProviderFTE] decimal                       NULL

    )    

    select * from dimPhysician

CREATE TABLE [dbo].[dimPayer](
    [dimPayerPK] varchar(255)                    Not NULL Primary Key
    ,[PayerName] varchar(255)                    NULL

    )    

    select * from dimPayer

CREATE TABLE [dbo].[dimLocation](
    [dimLocationPK] varchar(255)                    Not NULL Primary Key
    ,[LocationName] varchar(255)                    NULL

    )    

    select * from dimLocation

CREATE TABLE [dbo].[dimDiagnosisCode](
    [dimDiagnosisCodePK] varchar(255)                    Not NULL Primary Key
    ,[DiagnosisCode] varchar(255)                        NULL
    ,[DiagnosisCodeDescription] varchar(255)             NULL
    ,[DiagnosisCodeGroup] varchar(255)                   NULL

    )    

    select * from dimDiagnosisCode

CREATE TABLE [dbo].[dimCptCode](
    [dimCPTCodePK] varchar(255)                Not NULL Primary Key
    ,[CptCode] varchar(255)                    NULL
    ,[CptDesc] varchar(255)                    NULL
    ,[CptGrouping] varchar(255)                NULL

    )    

    select * from dimCptCode

CREATE TABLE [dbo].[dimDate](
    [dimDatePostPK] varchar(255)             Not NULL Primary Key
    ,[Date] date                             NULL
    ,[Year] varchar(255)                     NULL
    ,[Month] varchar(255)                    NULL
    ,[MonthPeriod] varchar(255)              NULL
    ,[MonthYear] varchar(255)                NULL
    ,[Day] integer                           NULL
    ,[DayName] varchar(255)                  NULL

    )    

    select * from dimDate
--to fix error win add foreign keys ******

IF OBJECT_ID('references_dimPatientPK') IS NOT NULL ALTER TABLE FactTable DROP CONSTRAINT references_dimPatientPK
GO
IF OBJECT_ID('references_dimPhysician') IS NOT NULL ALTER TABLE FactTable DROP CONSTRAINT references_dimPhysician
GO
IF OBJECT_ID('references_dimDatePostPK') IS NOT NULL ALTER TABLE FactTable DROP CONSTRAINT references_dimDatePostPK
GO
IF OBJECT_ID('references_dimCPTCodePK') IS NOT NULL ALTER TABLE FactTable DROP CONSTRAINT references_dimCPTCodePK
GO
IF OBJECT_ID('references_dimPayerPK') IS NOT NULL ALTER TABLE FactTable DROP CONSTRAINT references_dimPayerPK
GO
IF OBJECT_ID('references_dimTransaction') IS NOT NULL ALTER TABLE FactTable DROP CONSTRAINT references_dimTransaction
GO
IF OBJECT_ID('references_dimLocation') IS NOT NULL ALTER TABLE FactTable DROP CONSTRAINT references_dimLocation
GO
IF OBJECT_ID('references_dimDiagnosisCode') IS NOT NULL ALTER TABLE FactTable DROP CONSTRAINT references_dimDiagnosisCode
GO


--create foreing keys *********

ALTER TABLE FactTable
ADD CONSTRAINT references_dimPatientPK FOREIGN KEY (dimPatientPK) REFERENCES dimPatient(dimPatientPK),
    CONSTRAINT references_dimPhysicianPK FOREIGN KEY (dimPhysicianPK) REFERENCES dimPhysician(dimPhysicianPK),
    CONSTRAINT references_dimDatePostPK FOREIGN KEY (dimDatePostPK) REFERENCES dimDate(dimDatePostPK),
    CONSTRAINT references_dimCPTCodePK FOREIGN KEY (dimCPTCodePK) REFERENCES dimCptCode(dimCPTCodePK),
    CONSTRAINT references_dimPayerPK FOREIGN KEY (dimPayerPK) REFERENCES dimPayer(dimPayerPK),
    CONSTRAINT references_dimTransactionPK FOREIGN KEY (dimTransactionPK) REFERENCES dimTransaction(dimTransactionPK),
    constraint references_dimLocationPK foreign key (dimLocationPK) references dimLocation(dimLocationPK),
    constraint references_dimDiagnosisCodePK foreign key (dimDiagnosisCodePK) references dimDiagnosisCode(dimDiagnosisCodePK);

--Explorer les données **********

select top 10 * from FactTable
select top 10 * from dimCptCode
select top 10 * from dimPatient
select top 10 * from dimPhysician
select top 10 * from dimDate
select top 10 * from dimPayer
select top 10 * from dimTransaction
select top 10 * from dimLocation
select top 10 * from dimDiagnosisCode


--Étape 5 : Réaliser les jointures *********

SELECT F.*, DT.TransactionType
FROM 
    FactTable AS F
LEFT JOIN 
    dimTransaction AS DT 
    ON F.dimTransactionPK = DT.dimTransactionPK
    ---------------------
--les jointures pour suivre le flux complet d’un patient fictif  :
SELECT 
    p.FirstName , p.LastName,
    l.LocationName, d.Date,
    phy.ProviderName, f.GrossCharge,
    diag.DiagnosisCode, cpt.CptDesc,
    t.TransactionType, f.Payment    
FROM FactTable f
inner join dimPatient p ON f.dimPatientPK = p.dimPatientPK
inner join dimLocation l ON f.dimLocationPK = l.dimLocationPK
inner join dimDate d ON f.dimDatePostPK = d.dimDatePostPK
inner join dimPhysician phy ON f.dimPhysicianPK = phy.dimPhysicianPK
inner join dimDiagnosisCode diag ON f.dimDiagnosisCodePK = diag.dimDiagnosisCodePK
inner join dimCptCode cpt ON f.dimCPTCodePK = cpt.dimCPTCodePK
inner join dimTransaction t ON f.dimTransactionPK = t.dimTransactionPK 
order by FirstName asc;
 ---------------------------------
  select top 10 * from FactTable

 --Étape 6 : Résolution de 10 requêtes SQL*******

 --1-Nombre de lignes avec charge brute > 100 $

 select count(*) as 'charge brute'
 from FactTable
 where GrossCharge > 100;

 --2-Nombre de patients uniques
 
 select distinct count(dimPatientPK) as 'Nombre de patients uniques'
 from FactTable;

 --3-Nombre de codes CPT par groupe
 
 select CptGrouping, count(CptGrouping) as 'Nombre de codes CPT'
 from dimCptCode
 group by CptGrouping

 --4-Nombre de Médecins ayant soumis une réclamation Medicare

 select count(distinct F.dimPhysicianPK) as 'NBR Médecins réclamé Medicare'
 from FactTable as F
 inner join dimPhysician as P
 on F.dimPhysicianPK=P.dimPhysicianPK
 inner join dimPayer as Py
 on F.dimPayerPK=Py.dimPayerPK
 where PayerName='Medicare'

 --5-Nombre de Codes CPT avec plus de 100 unités

 select  count(distinct CptCode) as 'Nombre Codes CPT'
 from FactTable as F
 inner join dimCptCode as C
 on F.dimCPTCodePK=C.dimCPTCodePK
 where CPTUnits > 100

 --6-Spécialité médicale ayant reçu le plus de paiements

--SELECT TOP 1 P.ProviderSpecialty,sum(F.Payment) as 'Total Reçu'
--FROM FactTable as F
--JOIN dimPhysician as P ON F.dimPhysicianPK = P.dimPhysicianPK
--JOIN dimTransaction AS DT ON F.dimTransactionPK = DT.dimTransactionPK
--AND DT.TransactionType='Payment'
--GROUP BY P.ProviderSpecialty
--ORDER BY 'Total Reçu' DESC;

SELECT TOP 1 P.ProviderSpecialty,sum(F.Payment) as 'Total Reçu'
FROM FactTable as F
JOIN dimPhysician as P ON F.dimPhysicianPK = P.dimPhysicianPK
GROUP BY P.ProviderSpecialty
ORDER BY 'Total Reçu' DESC;

--les paiements par mois pour cette spécialité.
SELECT d.MonthYear, SUM(f.Payment) AS PaiementMensuel
FROM FactTable f
JOIN dimPhysician p ON f.dimPhysicianPK = p.dimPhysicianPK
JOIN dimDate d ON f.dimDatePostPK = d.dimDatePostPK
WHERE p.ProviderSpecialty = 'Surgery - Surgical Oncology'
GROUP BY d.MonthYear, d.MonthPeriod
ORDER BY d.MonthPeriod;

--7-Nombre Unités CPT pour diagnostics commençant par J

SELECT SUM(f.CPTUnits) AS TotalUnitesJ
FROM FactTable as F
JOIN dimDiagnosisCode as D ON F.dimDiagnosisCodePK = D.dimDiagnosisCodePK
WHERE D.DiagnosisCode LIKE 'J%';

--8-Rapport démographique des patients

SELECT 
    FirstName + LastName AS FullName,
    Email, PatientAge, City, State,
    CASE 
        WHEN PatientAge < 18 THEN '<18 ans'
        WHEN PatientAge BETWEEN 18 AND 65 THEN '18-65 ans'
        ELSE '>65 ans'
    END AS TrancheAge
FROM dimPatient;

--9-Ajustements liés au credentialing

SELECT 
    L.LocationName, 
    SUM(f.Adjustment) AS 'Total Annulée',
    COUNT(DISTINCT F.dimPhysicianPK) AS NbMedecinsImpactes
FROM FactTable f
JOIN dimTransaction T ON F.dimTransactionPK = T.dimTransactionPK
JOIN dimLocation l ON f.dimLocationPK = l.dimLocationPK
WHERE T.AdjustmentReason = 'Credentialing'
GROUP BY L.LocationName
ORDER BY 'Total Annulée' ASC;

