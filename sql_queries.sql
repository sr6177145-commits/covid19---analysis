use portfolio;
select * from covid_death;

-- country wise calculation 

-- total number of death and total number of cases country wise

select location, sum(new_cases) as total_cases ,sum(new_deaths) as total_deaths
from covid_death 
GROUP BY location ORDER BY total_deaths DESC;

-- death rate in country wise

SELECT location,sum(new_cases) as total_cases ,sum(new_deaths) as total_deaths,(sum(new_deaths)/sum(new_cases))*100 as death_percentage
FROM covid_death 
where continent IS NOT NULL AND location NOT IN ('world','Europe','North America', 'South America','European Union')
GROUP BY location ORDER BY death_percentage DESC;


-- top 10 countries with high death rate 

SELECT location ,
	max(total_deaths) as total_death ,
	max(total_cases) as total_cases , 
	(max(total_deaths)/max(total_cases)) as death_rate
FROM covid_death 
where continent IS NOT NULL AND location NOT IN ("Europe","North America","European Union","South America")
group by location 
ORDER BY death_rate DESC LIMIT 10;
 
 -- top 10 countries most protected low death rate 
 
 SELECT 
	location , 
    max(total_deaths) as total_death ,
    max(total_cases) as total_cases , 
 (max(total_deaths)/max(total_cases)) as death_rate
FROM covid_death 
where continent IS NOT NULL AND location NOT IN ("Europe","North America","European Union","South America")
group by location
ORDER BY death_rate  LIMIT 10;
 
 -- death , cases and death_rate in some big countries 
 
 SELECT 
	location ,
	date,
    total_deaths ,
    total_cases as total_cases , 
    (total_deaths/total_cases)*100 as death_rate
FROM covid_death 
WHERE location LIKE "%state%" 
;

SELECT 
	location  ,
	date,
    total_deaths,
    total_cases as total_cases , 
	(total_deaths/total_cases)*100 as death_rate
FROM covid_death 
WHERE location LIKE "%ussia%" ;


SELECT 
    location  ,
    date,
    total_deaths,
    total_cases as total_cases , 
	(total_deaths/total_cases)*100 as death_rate
FROM covid_death 
WHERE location LIKE "%kingdom%" ;


-- total cases vs population like most infection rate

SELECT 
    location ,
    max(total_cases) as HighInfectionCount ,
    population,
    (max(total_cases)/population)*100 as InfectedPopRate
FROM covid_death 
where continent IS NOT NULL AND location NOT IN ("Europe","North America","European Union","South America")
GROUP BY location,population ORDER BY InfectedPopRate DESC LIMIT 10;

-- death rate per population

SELECT 
	location , 
    population ,
    max(total_deaths) as deaths ,
    (max(total_deaths)/population)*100 as DeathRate
FROM covid_death 
WHERE continent IS NOT NULL AND location NOT IN ("Europe","North America","European Union","South America")
GROUP BY location , population 
ORDER BY deaths DESC ;
SET sql_safe_updates=0;


-- Calculation by continent
 -- total cases and total death related to continent
SELECT 
	continent , 
sum(new_cases) as InfectedPeopleCount , 
sum(new_deaths) as DeathCount 
FROM covid_death
GROUP BY continent;

-- death rate in continent 
SELECT 
	continent , 
sum(new_cases) as InfectedPeopleCount , 
sum(new_deaths) as DeathCount ,
(sum(new_deaths)/sum(new_cases))*100 as death_rate
FROM covid_death
GROUP BY continent ;

-- finding the safest continent from covid 

SELECT 
	continent , 
sum(new_cases) as InfectedPeopleCount , 
sum(new_deaths) as DeathCount ,
(sum(new_deaths)/sum(new_cases))*100 as death_rate
FROM covid_death
GROUP BY continent ORDER BY death_rate  LIMIT 1;

-- the most effected continent from covid 
SELECT 
	continent , 
sum(new_cases) as InfectedPeopleCount , 
sum(new_deaths) as DeathCount ,
(sum(new_deaths)/sum(new_cases))*100 as death_rate
FROM covid_death

GROUP BY continent ORDER BY death_rate DESC LIMIT 1;

-- global death and cases

SELECT 
	date,
	sum(new_cases) as InfectedPeople ,
    sum(new_deaths) as DeathCount
    FROM covid_death 
GROUP BY date ;

-- death percentage across the whole  world
SELECT
	date,
	sum(new_cases) as InfectedPeople ,
    sum(new_deaths) as DeathCount,
    (sum(new_deaths)/sum(new_cases))*100 as DeathRate
    FROM covid_death 
GROUP BY date ;


SELECT
	-- date,
	sum(new_cases) as InfectedPeople ,
    sum(new_deaths) as DeathCount,
    (sum(new_deaths)/sum(new_cases))*100 as DeathRate
    FROM covid_death
GROUP BY date ;

-- finding the total-vaccination according to location

SELECT 
	d.continent,
    d.location,
    d.date,
    d.population ,
    v.new_vaccinations ,
   sum(v.new_vaccinations) OVER (PARTITION BY d.location order by d.location) as RollingVaccination
FROM covid_death d JOIN covid_vaccination v ON d.location=v.location ;


-- finding vaccination vs poplation
with RollVaccP(continent, location, date,population ,new_vaccinations ,RollVaccination)
as 
(SELECT 
	d.continent,
    d.location,
    d.date,
    d.population ,
    v.new_vaccinations ,
   sum(v.new_vaccinations) OVER (PARTITION BY d.location order by d.location) as RollVaccination
FROM covid_death d JOIN covid_vaccination v ON d.location=v.location  ) 

select *,(RollVaccination/population)*100 from RollVaccP;













    






  
 
 
 
 
 
 







