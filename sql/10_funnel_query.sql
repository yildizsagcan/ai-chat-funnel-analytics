--  AI chat funnel counts + step-to-step conversion

WITH per_user AS (
  SELECT
    user_id,
    MIN(event_time) FILTER (WHERE event_name = 'first_open')            AS t1,
    MIN(event_time) FILTER (WHERE event_name = 'welcome_view')          AS t2,
    MIN(event_time) FILTER (WHERE event_name = 'register_start')        AS t3,
    MIN(event_time) FILTER (WHERE event_name = 'register_completed')    AS t4,
    MIN(event_time) FILTER (WHERE event_name = 'home_view')             AS t5,
    MIN(event_time) FILTER (WHERE event_name = 'chat_created')          AS t6,
    MIN(event_time) FILTER (WHERE event_name = 'message_sent')          AS t7,
    MIN(event_time) FILTER (WHERE event_name = 'ai_response_received')  AS t8
  FROM analytics.events
  GROUP BY 1
),
seq AS (
  SELECT
    user_id,
    (t1 IS NOT NULL) AS s1,
    (t2 IS NOT NULL AND t2 >= t1) AS s2,
    (t3 IS NOT NULL AND t3 >= t2) AS s3,
    (t4 IS NOT NULL AND t4 >= t3) AS s4,
    (t5 IS NOT NULL AND t5 >= t4) AS s5,
    (t6 IS NOT NULL AND t6 >= t5) AS s6,
    (t7 IS NOT NULL AND t7 >= t6) AS s7,
    (t8 IS NOT NULL AND t8 >= t7) AS s8
  FROM per_user
)
SELECT
  COUNT(*) FILTER (WHERE s1) AS users_first_open,
  COUNT(*) FILTER (WHERE s2) AS users_welcome_view,
  COUNT(*) FILTER (WHERE s3) AS users_register_start,
  COUNT(*) FILTER (WHERE s4) AS users_register_completed,
  COUNT(*) FILTER (WHERE s5) AS users_home_view,
  COUNT(*) FILTER (WHERE s6) AS users_chat_created,
  COUNT(*) FILTER (WHERE s7) AS users_message_sent,
  COUNT(*) FILTER (WHERE s8) AS users_ai_response_received,

  ROUND(100.0 * COUNT(*) FILTER (WHERE s2) / NULLIF(COUNT(*) FILTER (WHERE s1),0), 2) AS conv_s1_to_s2_pct,
  ROUND(100.0 * COUNT(*) FILTER (WHERE s4) / NULLIF(COUNT(*) FILTER (WHERE s2),0), 2) AS conv_s2_to_s4_pct,
  ROUND(100.0 * COUNT(*) FILTER (WHERE s6) / NULLIF(COUNT(*) FILTER (WHERE s5),0), 2) AS conv_s5_to_s6_pct,
  ROUND(100.0 * COUNT(*) FILTER (WHERE s8) / NULLIF(COUNT(*) FILTER (WHERE s7),0), 2) AS conv_s7_to_s8_pct
FROM seq;