# AirBnB Clone Project — Database Schema Setup

This project provides a relational database schema for an AirBnB Clone platform.  
The schema models users, properties, bookings, payments, reviews, and messaging between users.

## 📂 Tables

- **User** — stores user accounts (guests, hosts, admins)
- **Property** — stores property listings hosted by users
- **Booking** — stores reservations made by guests
- **Payment** — stores payment details for bookings
- **Review** — stores user reviews for properties
- **Message** — stores private messages between users

## 🛠️ Requirements

- PostgreSQL (recommended) or any SQL-compatible RDBMS
- SQL client (e.g., psql, PgAdmin, DBeaver)

## ⚙️ How to Create the Schema

1. Open your SQL client and connect to your target database.
2. Run the schema SQL script (`schema.sql`) to create all tables and constraints.

```bash
psql -U username -d database_name -f schema.sql
