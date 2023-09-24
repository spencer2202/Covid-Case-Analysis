SELECT *
FROM Covid_Deaths
WHERE continent is not null
ORDER BY 3,4

SELECT *
FROM Covid_Vaccinations
WHERE continent is not null
ORDER BY 3,4

--SELECT location, cast(date as date) as dt, total_cases, total_deaths, cast (population as bigint) as pt
--FROM Covid_Deaths
--ORDER BY 1,2

SELECT location, cast(date as date) as date, total_cases, total_deaths, population
FROM Covid_Deaths
ORDER BY 1,2

SELECT location, cast(date as date) as date, ISNULL(total_cases,0) as total_cases, ISNULL(cast(total_deaths as float), 0) as total_deaths, population
FROM Covid_Deaths
ORDER BY 1,2

SELECT location, cast(date as date) as date, ISNULL(total_cases,0) as total_cases, CAST(ISNULL(total_deaths,0) as float) as total_deaths, population
FROM Covid_Deaths
WHERE location like '%states%'
ORDER BY 1,2


SELECT location, cast(date as date) as date, total_cases, total_deaths, cast(total_deaths as float)/ cast(total_cases as int) *100 as death_percentage
FROM Covid_Deaths
ORDER BY 1,2

SELECT location, cast(date as date) as date, total_cases, total_deaths, cast(total_deaths as float)/ cast(total_cases as int) *100 as death_percentage
FROM Covid_Deaths
Where location like '%states%'
AND continent is not null
ORDER BY 1,2

SELECT location, population, MAX(total_cases) as highest_infection, MAX(cast(total_cases as float))/ population *100 as percent_population_infected
FROM Covid_Deaths
GROUP BY location, population
ORDER BY percent_population_infected desc

SELECT location, MAX(total_deaths) as total_death_count
FROM Covid_Deaths
WHERE continent is not null
GROUP BY location
ORDER BY total_death_count desc

SELECT continent, MAX(total_deaths) as total_death_count
FROM Covid_Deaths
WHERE continent is not null
GROUP BY continent
ORDER BY total_death_count desc


SELECT cast(date as date) as date, SUM(new_cases) as new_cases, --ISNULL(total_cases,0) as total_cases, ISNULL(cast(total_deaths as float), 0) as total_deaths, population
FROM Covid_Deaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

SELECT cast(date as date) as date, total_cases, total_deaths, cast(total_deaths as float)/ cast(total_cases as int) *100 as death_percentage
FROM Covid_Deaths
ORDER BY 1,2



SELECT *
FROM covid_deaths 
JOIN covid_vaccinations 
ON covid_deaths.location = covid_vaccinations.location
AND covid_deaths.date = covid_vaccinations.date

SELECT covid_deaths.location, CAST(covid_deaths.date as date) as date, covid_deaths.population, covid_vaccinations.new_vaccinations
FROM covid_deaths 
JOIN covid_vaccinations 
ON covid_deaths.location = covid_vaccinations.location
AND covid_deaths.date = covid_vaccinations.date
ORDER BY 1,2


Create View TotalCasesTotalDeathsByDate as
SELECT location, cast(date as date) as date, ISNULL(total_cases,0) as total_cases, ISNULL(cast(total_deaths as float), 0) as total_deaths, population
FROM Covid_Deaths
--ORDER BY 1,2

CREATE VIEW PercentPopulationInfected as
SELECT location, population, MAX(total_cases) as highest_infection, MAX(cast(total_cases as float))/ population *100 as percent_population_infected
FROM Covid_Deaths
GROUP BY location, population
--ORDER BY percent_population_infected desc

CREATE VIEW USTotalCasesTotalDeathsByPopulation as
SELECT location, cast(date as date) as date, ISNULL(total_cases,0) as total_cases, CAST(ISNULL(total_deaths,0) as float) as total_deaths, population
FROM Covid_Deaths
WHERE location like '%states%'
--ORDER BY 1,2