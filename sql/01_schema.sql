-- Schema for AI chat funnel analytics

CREATE SCHEMA IF NOT EXISTS analytics;

CREATE TABLE IF NOT EXISTS analytics.events (
  event_id        BIGSERIAL PRIMARY KEY,
  user_id         TEXT NOT NULL,
  session_id      TEXT,
  event_name      TEXT NOT NULL,
  event_time      TIMESTAMPTZ NOT NULL DEFAULT now(),

  -- useful dimensions
  platform        TEXT,         -- ios/android/web
  app_version     TEXT,
  country         TEXT,

  -- flexible payload (e.g., onboarding step, paywall_id, latency_ms)
  properties      JSONB NOT NULL DEFAULT '{}'::jsonb
);

-- Core indexes for funnel queries
CREATE INDEX IF NOT EXISTS idx_events_time
  ON analytics.events (event_time);

CREATE INDEX IF NOT EXISTS idx_events_user_time
  ON analytics.events (user_id, event_time);

CREATE INDEX IF NOT EXISTS idx_events_name_time
  ON analytics.events (event_name, event_time);

CREATE INDEX IF NOT EXISTS idx_events_user_name_time
  ON analytics.events (user_id, event_name, event_time);

-- JSONB index for property filtering (optional but helpful)
CREATE INDEX IF NOT EXISTS idx_events_properties_gin
  ON analytics.events USING GIN (properties);