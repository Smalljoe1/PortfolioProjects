/*
Covid 19 Deaths - SQL Data Exploration Project
Skills used: Joins, Aggregate Functions, Converting Data Types
Data source: https://ourworldindata.org/covid-deaths
*/

-- Select Data that we are going to use
SELECT cd.`location`,CAST(cd.`date` AS DATE) AS DATE,cd.`total_cases`,cd.`new_cases`,cd.`total_deaths`,cd.`population`
FROM coviddeaths cd ORDER BY 1,2;

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you're infected with covid in your country
SELECT Location, CAST(DATE AS DATE) AS DATE, total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE location LIKE '%Africa%'
AND continent IS NOT NULL 
ORDER BY 1,2;

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

SELECT Location, CAST(DATE AS DATE) AS DATE, Population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM CovidDeaths
WHERE location LIKE '%Africa%'
ORDER BY 1,2

-- Countries with Highest Infection Rate compared to Population

SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY continent, Population
ORDER BY PercentPopulationInfected DESC

-- Countries with Highest Death Count per Population

SELECT Location, MAX(Total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

SELECT continent, MAX(Total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- GLOBAL NUMBERS

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 1,2

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT cd.continent, cd.location, CAST(cd.date AS DATE) AS DATE, cd.population, cv.new_vaccinations
FROM CovidDeaths cd
JOIN CovidVaccinations cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL 
ORDER BY 2,3

