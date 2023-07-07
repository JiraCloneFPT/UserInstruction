@echo off
title Setup project
chcp 65001
cls





set name=ADMIN
set user=
set pass= 






cd ..
echo Setting Backend
echo Update version dotnet in project
dotnet tool update --global dotnet-ef
timeout /t 5 /nobreak
cls
if ERRORLEVEL 1 (
	echo Please, install dotnet in https://dotnet.microsoft.com/en-us/download
	exit /b 1
)

echo Excute file database
cd Backend/be
if "%user%"==" " (
	sqlcmd -s %name% -i database.sql
)else (
	sqlcmd -s %name% -u %user% -p %pass% -i database.sql
)
timeout /t 5 /nobreak
cls

echo Edit file appsettings.json in be folder
set settings={"Logging": {"LogLevel": {"Default": "Information","Microsoft.AspNetCore": "Warning"}},"ConnectionStrings": {"dbJiraClone": "Data Source=%name%;Initial Catalog=dbJiraClone;Trusted_Connection=SSPI;Encrypt=True;TrustServerCertificate=True"},"AppSettings": {"Token": "ld4edPteFlGGZwQVFOdg"},"AllowedHosts": "*","AllowedOrigins": "http://localhost:3000","AllowedHeaders": "content-type","AllowedMethods": "GET,POST,PUT,DELETE"}
echo %settings% > appsettings.json
timeout /t 5 /nobreak

cd ..
echo Build backend
dotnet build
timeout /t 5 /nobreak
cls
echo Setting backend success!
timeout /t 5 /nobreak
cls

echo Setting Frontend
cd ..
cd FE
npm install
echo Setting all success!
timeout /t 5 /nobreak
cls
pause





