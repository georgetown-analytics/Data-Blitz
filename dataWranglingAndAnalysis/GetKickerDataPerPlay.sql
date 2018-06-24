DELIMITER $$
CREATE DEFINER=`db_gtown_2018`@`%` PROCEDURE `GetKickerDataPerPlay`()
BEGIN
SELECT         
            PBP.GID,
            PBP.FKICKER AS KICKER_ID,
            PLAYER.PNAME AS KICKER_NAME,
            GAME.SEAS AS SEASON,
            CASE
                WHEN GOOD = 'Y' THEN 1
                ELSE 0
            END AS SUCCESS,
            CASE
                WHEN UPPER(DETAIL) LIKE '%BLOCKED%' THEN 1
                ELSE 0
            END AS BLOCKED,
            CASE
                WHEN
                    QTR IN ('2' , '4') AND MIN <= 2
                        AND (PTSO - PTSD) >= - 3
                THEN
                    1
                ELSE 0
            END AS HIGH_PRESSURE,
            CASE
                WHEN
                    QTR IN ('2' , '4') AND MIN <= 2
                        AND (PTSO - PTSD) >= - 3
                        AND GOOD = 'Y'
                THEN
                    1
                ELSE 0
            END AS HIGH_PRESSURE_SUCCESS,
            CASE
                WHEN DIST >= 50 THEN 1
                ELSE 0
            END AS LONG_DIST,
            CASE
                WHEN DIST >= 50 AND GOOD = 'Y' THEN 1
                ELSE 0
            END AS LONG_DIST_SUCCESS,
            DIST - (100 - CASE
                WHEN YFOG = '' THEN '98'
                ELSE YFOG
            END) AS YDS_BEHIND_LOS,
            CASE
                WHEN PRO_BOWL.ProBowl_Level IS NULL THEN 0
                ELSE 1
            END AS IN_PROBOWL_TEAM,
            CASE
                WHEN COND IN ('Rain' , 'Showers', 'Snow', 'Thunderstorms', 'Cold', 'Flurries', 'Light Rain', 'Light Showers', 'Light Snow', 'Windy') THEN 1
                ELSE 0
            END AS BAD_WEATHER,
            CASE
                WHEN COND IN ('Rain' , 'Showers', 'Snow', 'Thunderstorms', 'Cold', 'Flurries', 'Light Rain', 'Light Showers', 'Light Snow', 'Windy') AND GOOD = 'Y' THEN 1
                ELSE 0
            END AS BAD_WEATHER_SUCCESS,
            CASE
                WHEN GAME.SURF <> 'GRASS' THEN 1
                ELSE 0
            END AS TURF_FIELD,
            CASE
                WHEN GAME.SURF <> 'GRASS' AND GOOD = 'Y' THEN 1
                ELSE 0
            END AS TURF_FIELD_SUCCESS,
            (GAME.SEAS - PLAYER.start) AS YEARS_PLAYED,
            DPOS AS DRAFT_POSITION,
            GAME.SEAS - YEAR(STR_TO_DATE(dob, '%m/%d/%Y')) AS AGE_YEARS
    FROM
        db_nfl.PBP
    LEFT OUTER JOIN db_nfl.PLAYER PLAYER ON PBP.FKICKER = PLAYER.PLAYER
    LEFT OUTER JOIN db_nfl.GAME ON PBP.GID = GAME.GID
    LEFT OUTER JOIN db_nfl.PRO_BOWL ON PRO_BOWL.PLAYER_ID = PLAYER.PLAYER
        AND GAME.SEAS = ProBowl_Year
    WHERE
        TYPE = 'FGXP' AND POS1 = 'K';
END$$
DELIMITER ;
