DELIMITER $$
CREATE DEFINER=`db_gtown_2018`@`%` PROCEDURE `GetKickerDataPerSeason`()
BEGIN
SELECT 
    FKICKER AS KICKER_ID,
    MIN(PLAYER_NAME) AS KICKER_NAME,
    SEASON,
    MAX(INPROBOWLTEAM) AS IN_PROBOWL_TEAM,
    ((SUM(SUCCESS) / COUNT(*)) * 100) AS SUCCESS_PRCNTG,
    ((SUM(BLOCKED) / COUNT(*)) * 100) AS BLOCKED_PRCNTG,
    COUNT(*) AS PLAY_COUNT,
    CASE
        WHEN SUM(HIGH_PRESSURE) = 0 THEN 0
        ELSE ((SUM(HIGH_PRESSURE_SUCCESS) / SUM(HIGH_PRESSURE)) * 100)
    END AS HIGH_PRESSURE_SUCCESS_PRCNTG,
    SUM(HIGH_PRESSURE) AS HIGH_PRESSURE_COUNT,
    CASE
        WHEN SUM(LONG_DIST) = 0 THEN 0
        ELSE ((SUM(LONG_DIST_SUCCESS) / SUM(LONG_DIST)) * 100)
    END AS LONG_DIST_SUCCESS_PRCNTG,
    SUM(LONG_DIST) AS LONG_DIST_COUNT,
    ((SUM(BAD_WEATH_SUCCESS) / SUM(BAD_WEATH)) * 100) AS BAD_WEATHER_SUCCESS_PRCNTG,
    SUM(BAD_WEATH) AS BAD_WEATHER_COUNT,
    ((SUM(TURF_FIELD_SUCCESS) / SUM(TURF_FIELD)) * 100) AS TURF_FIELD_SUCCESS_PRCNTG,
    SUM(TURF_FIELD) AS TURF_FIELD_COUNT,
    MAX(YEARS_PLAYED) AS YEARS_PLAYED,
    MAX(DRAFT_POSITION) AS DRAFT_POSITION,
    MAX(AGE_YEARS) AS AGE_YEARS
FROM
    (SELECT 
        FGXP,
            PBP.GID,
            PBP.FKICKER,
            PLAYER.PNAME AS PLAYER_NAME,
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
            END AS INPROBOWLTEAM,
            CASE
                WHEN COND IN ('Rain' , 'Showers', 'Snow', 'Thunderstorms', 'Cold', 'Flurries', 'Light Rain', 'Light Showers', 'Light Snow', 'Windy') THEN 1
                ELSE 0
            END AS BAD_WEATH,
            CASE
                WHEN
                    COND IN ('Rain' , 'Showers', 'Snow', 'Thunderstorms', 'Cold', 'Flurries', 'Light Rain', 'Light Showers', 'Light Snow', 'Windy')
                        AND GOOD = 'Y'
                THEN
                    1
                ELSE 0
            END AS BAD_WEATH_SUCCESS,
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
        TYPE = 'FGXP' AND POS1 = 'K') AS PerPlay
GROUP BY PerPlay.SEASON , FKICKER
ORDER BY PerPlay.SEASON , FKICKER;
END$$
DELIMITER ;
