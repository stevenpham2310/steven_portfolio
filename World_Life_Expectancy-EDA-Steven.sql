# World Life Expectancy Project (Exploratory Data Analysis)

SELECT * 
FROM World_Life_Expectancy.world_life_expectancy
;

# What is the time duration of this dataset?
SELECT Country, 
 MIN(`Year`), 
 MAX(`Year`),
 ROUND(MAX(`Year`) - MIN(`Year`)) 
 FROM World_Life_Expectancy.world_life_expectancy
 GROUP BY Country
 ;
 
---------------------------------
# Identiy the MIN & MAX of Life expectancy for each country 
# Calculate the growth of Life expectancy for each country
 SELECT Country, 
 MIN(`Life expectancy`), 
 MAX(`Life expectancy`),
 ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years
 FROM World_Life_Expectancy.world_life_expectancy
 GROUP BY Country
 HAVING MIN(`Life expectancy`) <> 0
 AND MAX(`Life expectancy`) <> 0
 ORDER BY Life_Increase_15_Years DESC
 ; 
 
 # Calculate the Average of Life expectancy by Year
 SELECT Year, ROUND(AVG(`Life expectancy`),2)
 FROM World_Life_Expectancy.world_life_expectancy
 WHERE `Life expectancy` <> 0
 AND  `Life expectancy` <> 0
 GROUP BY Year
 ORDER BY Year
 ;
-- From 2007-2022, the AVG Life expectancy is 67-72 years

 ---------------------------------
 # GDP & Life Expectancy
 
 # Now we want to see the corelation between Life expectancy & GDP
 SELECT Country, `Life expectancy`, GDP
 FROM World_Life_Expectancy.world_life_expectancy
 ;
 
 # Let's take a look of the AVG of Life expectancy & GDP
 SELECT Country, 
 ROUND(AVG(`Life expectancy`),1) AS Life_Exp,
 ROUND(AVG(GDP),1) AS GDP
 FROM World_Life_Expectancy.world_life_expectancy
 GROUP BY Country
 HAVING Life_Exp > 0
 AND GDP > 0
 ORDER BY GDP ASC
 ;
 -- The 1st 5 lowest GDP countries have the Life exp only from 53-61 years
 
 SELECT Country, 
 ROUND(AVG(`Life expectancy`),1) AS Life_Exp,
 ROUND(AVG(GDP),1) AS GDP
 FROM World_Life_Expectancy.world_life_expectancy
 GROUP BY Country
 HAVING Life_Exp > 0
 AND GDP > 0
 ORDER BY GDP DESC
 ;
 -- Contrary to the first 5 countries with highest GDP, their AVG Life_Exp is from 77-83 Years
 -- >> Highest GDP countries live significantly longer the lowest GDP countries alter
 -- >> Positve corelation
 
---------------------------------
# LOW-HIGH GDP & Life Expectancy 

SELECT *
FROM World_Life_Expectancy.world_life_expectancy
ORDER BY GDP
;


SELECT
SUM(CASE
	WHEN GDP >= 1500 THEN 1
	ELSE 0
END) High_GDP_Count
FROM World_Life_Expectancy.world_life_expectancy;
 -- The output = 1326 rows of country with GDP >= 1500 
 
 
# Let's see the life expectancy of these high GDP countries
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy
FROM World_Life_Expectancy.world_life_expectancy
;
-- The output = 74 years, that's the AVG life expectancy of all these 1326 rows
 

# Now, let's compare it with Low GDP countries 
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM World_Life_Expectancy.world_life_expectancy
;
-- We can see the Low GDP countries have -10 years less of life expectancy than the High GDP countries
-- We've found the High corelation between High-Low GDP countries vs High-Low Life expectancy of their people
 
 
 ---------------------------------
 # Status & Life Expectancy
 
SELECT * 
FROM World_Life_Expectancy.world_life_expectancy
;
 
 SELECT Status, ROUND(AVG(`Life expectancy`),1)
 FROM World_Life_Expectancy.world_life_expectancy
 GROUP BY Status
 ;
 -- AVG(Developing) = 67, AVG(Developed) = 79 >> 12 years difference
 -- BUT this query alone doesn't give us the Full picture -- Is these numbers skew?
 -- How many Developing/Developed countries in this dataset?

SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1)
FROM World_Life_Expectancy.world_life_expectancy
GROUP BY Status
;
-- Output: 32 developed, 161 developing countries >> the AVG numbers above is skewed
 

---------------------------------
 # BMI & Life Expectancy
 
# Let's find the AVG BMI for each country
SELECT Country, 
ROUND(AVG(`Life expectancy`),1) AS Life_Exp,
ROUND(AVG(BMI),1) AS BMI
FROM World_Life_Expectancy.world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI DESC
;
-- This code is the same as above, in real-life-work, ppl just copy-paste lots of old codes to save time
-- BUT for learning purposes, it's best to re-write code
-- OUTPUT: over 25 BMI is overweight >> in this findings, higher BMI doesn't relate to low life exp
 
 
---------------------------------
# Adult Mortality & Life Expectancy
# Adult Mortality = Tỷ lệ tử vong ở người lớn 
 
SELECT * 
FROM World_Life_Expectancy.world_life_expectancy
;


# Let's see the corelation between Adult Mortality & Life Expectancy of all countries
SELECT Country, Year, `Life expectancy`, `Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM World_Life_Expectancy.world_life_expectancy 
;
 
SELECT Country, Year, `Life expectancy`, `Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM World_Life_Expectancy.world_life_expectancy 
WHERE Country LIKE '%United%'
;
 
 
 
 
 
 
 
 
 