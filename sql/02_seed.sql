-- Seed data for AI chat funnel

TRUNCATE TABLE analytics.events;

-- User 1: completes full activation (ai_response_received)
INSERT INTO analytics.events (user_id, session_id, event_name, event_time, platform, country, properties) VALUES
('u1','s1','first_open',           now() - interval '2 days', 'ios','TR','{}'),
('u1','s1','welcome_view',         now() - interval '2 days' + interval '3 seconds', 'ios','TR','{}'),
('u1','s1','register_start',       now() - interval '2 days' + interval '10 seconds', 'ios','TR','{}'),
('u1','s1','register_completed',   now() - interval '2 days' + interval '40 seconds', 'ios','TR','{"age":22,"gender":"female"}'),
('u1','s1','home_view',            now() - interval '2 days' + interval '45 seconds', 'ios','TR','{}'),
('u1','s1','chat_created',         now() - interval '2 days' + interval '60 seconds', 'ios','TR','{}'),
('u1','s1','message_sent',         now() - interval '2 days' + interval '70 seconds', 'ios','TR','{"message_length":18}'),
('u1','s1','ai_response_received', now() - interval '2 days' + interval '72 seconds', 'ios','TR','{"latency_ms":1200}');

-- User 2: drops after welcome (never registers)
INSERT INTO analytics.events (user_id, session_id, event_name, event_time, platform, country, properties) VALUES
('u2','s2','first_open',   now() - interval '1 day', 'android','TR','{}'),
('u2','s2','welcome_view', now() - interval '1 day' + interval '2 seconds', 'android','TR','{}');

-- User 3: registers but never starts chat
INSERT INTO analytics.events (user_id, session_id, event_name, event_time, platform, country, properties) VALUES
('u3','s3','first_open',         now() - interval '10 hours', 'ios','TR','{}'),
('u3','s3','welcome_view',       now() - interval '10 hours' + interval '2 seconds', 'ios','TR','{}'),
('u3','s3','register_start',     now() - interval '10 hours' + interval '6 seconds', 'ios','TR','{}'),
('u3','s3','register_completed', now() - interval '10 hours' + interval '25 seconds', 'ios','TR','{"age":29,"gender":"male"}'),
('u3','s3','home_view',          now() - interval '10 hours' + interval '28 seconds', 'ios','TR','{}');

-- User 4: starts chat and sends message but no AI response (error/timeout scenario)
INSERT INTO analytics.events (user_id, session_id, event_name, event_time, platform, country, properties) VALUES
('u4','s4','first_open',         now() - interval '6 hours', 'android','TR','{}'),
('u4','s4','welcome_view',       now() - interval '6 hours' + interval '2 seconds', 'android','TR','{}'),
('u4','s4','register_start',     now() - interval '6 hours' + interval '8 seconds', 'android','TR','{}'),
('u4','s4','register_completed', now() - interval '6 hours' + interval '35 seconds', 'android','TR','{"age":24,"gender":"female"}'),
('u4','s4','home_view',          now() - interval '6 hours' + interval '40 seconds', 'android','TR','{}'),
('u4','s4','chat_created',       now() - interval '6 hours' + interval '55 seconds', 'android','TR','{}'),
('u4','s4','message_sent',       now() - interval '6 hours' + interval '62 seconds', 'android','TR','{"message_length":42}');

-- User 5: registers, chat created, message sent, AI response received (slower latency)
INSERT INTO analytics.events (user_id, session_id, event_name, event_time, platform, country, properties) VALUES
('u5','s5','first_open',           now() - interval '3 hours', 'ios','TR','{}'),
('u5','s5','welcome_view',         now() - interval '3 hours' + interval '2 seconds', 'ios','TR','{}'),
('u5','s5','register_start',       now() - interval '3 hours' + interval '7 seconds', 'ios','TR','{}'),
('u5','s5','register_completed',   now() - interval '3 hours' + interval '28 seconds', 'ios','TR','{"age":21,"gender":"female"}'),
('u5','s5','home_view',            now() - interval '3 hours' + interval '32 seconds', 'ios','TR','{}'),
('u5','s5','chat_created',         now() - interval '3 hours' + interval '44 seconds', 'ios','TR','{}'),
('u5','s5','message_sent',         now() - interval '3 hours' + interval '50 seconds', 'ios','TR','{"message_length":12}'),
('u5','s5','ai_response_received', now() - interval '3 hours' + interval '58 seconds', 'ios','TR','{"latency_ms":4200}');