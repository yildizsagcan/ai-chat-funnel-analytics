# AI Chat App Funnel Analytics (PostgreSQL)

This project implements a **SQL-first internal analytics layer** to analyze and validate the user funnel of an AI chat application.

It focuses on **activation, drop-off analysis, and metric verification** by tracking the user journey from first app open to receiving the first AI response.

---

## Why This Project Exists

Modern products often rely on third-party analytics tools.
This project demonstrates how core product metrics can be **independently validated** using raw event data and SQL.

The system is designed as a **lightweight internal analytics / validation layer**, not as a replacement for third-party platforms.

---

## Funnel Scope & Activation Logic

The funnel models the following user journey:

1. first_open  
2. welcome_view  
3. register_start  
4. register_completed  
5. home_view  
6. chat_created  
7. message_sent  
8. ai_response_received  

**Activation is defined as:**  
> The user successfully receiving the first AI-generated response.

This definition ensures that activation represents **actual value delivery**, not just surface-level engagement.

---

## What This Project Demonstrates

- Designed an **event-based funnel model** aligned with real product flows
- Built a **SQL-first analytics pipeline** without relying on external SDKs
- Implemented **drop-off and conversion analysis** using PostgreSQL
- Created a reusable **funnel view** for consistent metric access
- Enabled **internal validation of product metrics** for QA, product, and data teams

---

## Tech Stack

- PostgreSQL (Dockerized)
- SQL (CTEs, FILTER, aggregation, views)
- pgAdmin 4 (manual analytics dashboard)

---

## Database Setup

PostgreSQL runs inside Docker:

```bash
docker compose up -d