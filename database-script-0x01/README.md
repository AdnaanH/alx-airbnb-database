
---

### 📄 **README-seed.md**

```markdown
# AirBnB Clone Project — Database Seeding

This script populates the database with **sample data** to test and demonstrate the AirBnB Clone schema.

## 📦 Sample Data Coverage

| Table     | Sample Rows | Notes |
|-----------|-------------|-------|
| **User**  | 4 users | Guest, Host, Admin roles covered |
| **Property** | 2 properties | Hosted by same host |
| **Booking** | 2 bookings | Bookings by different guests |
| **Payment** | 2 payments | Payments for bookings |
| **Review** | 2 reviews | Guest reviews for properties |
| **Message** | 2 messages | Sample host–guest conversation |

## 🛠️ Requirements

- PostgreSQL (recommended) or compatible SQL database
- Database schema must be created first (see [README-schema.md](README-schema.md))

## ⚙️ How to Seed the Database

1. Ensure your schema is created and empty.
2. Run the seeding SQL script (`seed.sql`):

```bash
psql -U username -d database_name -f seed.sql
