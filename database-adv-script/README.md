# 📘 Booking API SQL Queries

This repository contains essential SQL queries for interacting with airbnb project. The queries are based on a relational database schema that supports users, properties, bookings, payments, reviews, and messaging functionalities.

---

## 🗂️ Database Schema Overview

The platform’s schema includes the following tables:

### 🔹 `User`
Stores information about all users on the platform (guests, hosts, and admins).

### 🔹 `Property`
Listings created by hosts.

### 🔹 `Booking`
Represents a user's booking of a property.

### 🔹 `Payment`
Stores payment details associated with bookings.

### 🔹 `Review`
Reviews left by users on properties.

### 🔹 `Message`
Messages exchanged between users.

---

## 🔍 SQL Queries

### ✅ 1. INNER JOIN — Get All Bookings with Corresponding Users

This query retrieves all bookings alongside the users who made them. Only bookings linked to existing users will appear.

### ✅ 2. LEFT JOIN — Get All Properties and Their Reviews

This query lists all properties and their corresponding reviews. Properties without reviews will still appear with NULL values for the review columns.

### ✅ 3. FULL OUTER JOIN — Get All Users and All Bookings

This query returns every user and every booking, whether or not they are related. Useful for spotting unlinked or orphaned records.



# SQL Subqueries 

This demonstrates the use of **correlated** and **non-correlated** subqueries in a SQL database, based on the schema for an airbnb clone. The goal is to perform analytical queries involving user activity and property ratings.

## 🎯 Objective

To write SQL queries that:
1. Use a **non-correlated subquery** to find properties with an average review rating greater than 4.0.
2. Use a **correlated subquery** to find users who have made **more than 3 bookings**.

## 📄 Query Descriptions

### 1. Non-Correlated Subquery – Top Rated Properties
This query retrieves all properties that have an average rating greater than 4.0.

The inner query calculates average ratings per property using GROUP BY and HAVING.

### 2. Correlated Subquery – Active Users
This query identifies users who have made more than three bookings.

The inner query is evaluated per user, making it a correlated subquery.