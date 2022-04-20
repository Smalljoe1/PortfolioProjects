/*
SQL Queries used for covid 19 Deaths Data visualization - PowerBI Project
*/



-- 1. Table1_Covid deaths Global Numbers

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 1,2


-- 2. Table2_Showing contintents with the highest death count

SELECT location, SUM(new_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NULL 
AND location NOT IN ('World', 'European Union', 'International','Upper middle income','High income','Lower middle income','Low income')
GROUP BY location
ORDER BY TotalDeathCount DESC


-- 3. Table3_PecentPopulation Infected by Location

SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM CovidDeaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC


-- 4. Table4_PecentPopulation Infected by Location and Date


SELECT Location, Population,CAST(DATE AS DATE) AS DATE, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM CovidDeaths
GROUP BY Location, Population, DATE
ORDER BY PercentPopulationInfected DESC

