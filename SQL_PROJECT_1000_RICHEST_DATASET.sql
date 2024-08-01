-- USE richest

-- Quesion 1 < Total Number of Individuals:

SELECT COUNT(*) FROM 1000_richest_people_in_the_world;

-- Question 2 < Top 10 Richest People:

SELECT * FROM 1000_richest_people_in_the_world
ORDER BY `Net Worth (in billions)` DESC LIMIT 10 ;

-- Question 3 < Bottom 10 Richest People:

SELECT * FROM 1000_richest_people_in_the_world
ORDER BY `Net Worth (in billions)` LIMIT 10;

-- Question 4 < Average Net Worth:

SELECT AVG(`Net Worth (in billions)`) FROM 1000_richest_people_in_the_world;


-- Question 5 < Median Net Worth (assuming SQL supports window functions):

SELECT `Net Worth (in billions)`
FROM (
    SELECT `Net Worth (in billions)`, 
           ROW_NUMBER() OVER (ORDER BY `Net Worth (in billions)`) AS row_num,
           COUNT(*) OVER () AS total_rows
    FROM 1000_richest_people_in_the_world
) AS ranked
WHERE row_num = (total_rows + 1) / 2;

-- Question 6 < Wealth Distribution by Deciles:

SELECT
    NTILE(10) OVER (ORDER BY `Net Worth (in billions)`) AS decile,
    COUNT(*) AS count
FROM 1000_richest_people_in_the_world
GROUP BY decile
ORDER BY decile;


-- Question 7 < Top Countries by Number of Richest People:

SELECT Country,SUM(`Net Worth (in billions)`) AS num FROM 1000_richest_people_in_the_world
GROUP BY Country
ORDER BY num DESC
LIMIT 5;

-- Question 8 < Average Net Worth by Country:

SELECT Country,AVG(`Net Worth (in billions)`) FROM `1000_richest_people_in_the_world`
GROUP BY Country;

-- Question 9 < Country with the Richest Average Net Worth:

SELECT Country,AVG(`Net Worth (in billions)`) AS num FROM `1000_richest_people_in_the_world`
GROUP BY Country
ORDER BY num DESC
LIMIT 1;

-- Question 10 < Top Industries by Number of Richest People:

SELECT Industry,SUM(`Net Worth (in billions)`) AS num FROM `1000_richest_people_in_the_world`
GROUP BY Industry
ORDER BY num DESC
LIMIT 5;

-- Question 11 < Average Net Worth by Industry:

SELECT Industry,AVG(`Net Worth (in billions)`) FROM `1000_richest_people_in_the_world`
GROUP BY Industry;

-- Question 12 < Industry with the Richest Average Net Worth:
SELECT Industry,SUM(`Net Worth (in billions)`) AS num FROM `1000_richest_people_in_the_world`
GROUP BY Industry
ORDER BY num DESC
LIMIT 1;


--  Question 13 < Total Net Worth of the Top 10%:

SELECT * FROM 
			(SELECT `Net Worth (in billions)` 
            FROM `1000_richest_people_in_the_world`
            ORDER BY `Net Worth (in billions)` DESC
            LIMIT (SELECT COUNT(*) FROM `1000_richest_people_in_the_world`) / 10
) AS top_10_percent;



