# Run Guide

## Local Development Structure

The solution includes:

- SQL scripts for database schema and procedures
- Flask-based backend API skeleton
- project documentation for architecture and modules

## Recommended Setup Order

1. Create database
2. Run master table scripts
3. Run transaction table scripts
4. Run indexes and views
5. Run audit, KPI, tracking, and security scripts
6. Run stored procedures
7. Load sample seed data
8. Start backend application

## Backend Startup

Example:

```bash
python app.py
