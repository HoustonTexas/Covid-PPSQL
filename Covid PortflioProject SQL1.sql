select *
from PortfolioProject..CovidVaccinations
Where continent is not null
order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

--looking at total cases vs total deaths
--show likelihood of dying if you contract covid in your country

 select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathPercentage
from PortfolioProject..CovidDeaths
where location like '%state%'
order by 1,2

--Looking at Total case vs population
--Show what percentage of population got covid

select location, date, total_cases, population, (total_deaths/population)*100 as deathPercentage
from PortfolioProject..CovidDeaths
where location like '%state%'
order by 1,2

--Looking at countries with highest Infection Rate compared to Population

select location, population, MAX(total_cases) as HighestInfectionCount, MAX (total_cases/population)*100 as PercentagePopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%state%'
Group by location,Population
order by PercentagePopulationInfected desc


--Showing countries with Highest Death Count per Population

select location,  MAX(total_cases) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%state%'
Where continent is not null
Group by location
order by TotalDeathCount desc

--LET'S BREAK THINGS DOWN BY CONTINENT

select continent,  MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%state%'
Where continent is not null
Group by continent
order by TotalDeathCount desc

--GLOBAL NUMBERS

select date, sum(new_cases), SUM(cast(new_deaths as int))
from PortfolioProject..CovidDeaths
--where location like '%state%'
Where continent is not null
group by date
order by 1,2

--With PopvsVac ( coninent, location, Date,Population, New_vaccinations, RollingPeopleVaccinated) as

--TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar (225),
Location nvarchar (225),
Date datetime,
Population numeric,
New_vaccinations numeric,
)
Insert into #PercentPopulationVaccinated

select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations

from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

Select *, (RollingPeopleVaccinated/population)
from #PercentPopulationVaccinated

Create view PopulationVaccinated as
Select * 
From PortfolioProject..Covidvaccinations

