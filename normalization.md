### Normalized Schema

### User

```sql
user_id UUID PRIMARY KEY,
first_name VARCHAR NOT NULL,
last_name VARCHAR NOT NULL,
email VARCHAR UNIQUE NOT NULL,
password_hash VARCHAR NOT NULL,
phone_number VARCHAR NULL,
role ENUM('guest','host','admin') NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
```

### Property

```sql
property_id UUID PRIMARY KEY,
host_id UUID REFERENCES User(user_id),
name VARCHAR NOT NULL,
description TEXT NOT NULL,
location VARCHAR NOT NULL,
pricepernight DECIMAL NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
```

### Booking

```sql
booking_id UUID PRIMARY KEY,
property_id UUID REFERENCES Property(property_id),
user_id UUID REFERENCES User(user_id),
start_date DATE NOT NULL,
end_date DATE NOT NULL,
total_price DECIMAL NOT NULL,
status ENUM('pending','confirmed','canceled') NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
```

### Payment

```sql
payment_id UUID PRIMARY KEY,
booking_id UUID REFERENCES Booking(booking_id),
amount DECIMAL NOT NULL,
payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
payment_method ENUM('credit_card','paypal','stripe') NOT NULL
```

### Review

```sql
review_id UUID PRIMARY KEY,
property_id UUID REFERENCES Property(property_id),
user_id UUID REFERENCES User(user_id),
rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,
comment TEXT NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
```

### Message

```sql
message_id UUID PRIMARY KEY,
sender_id UUID REFERENCES User(user_id),
recipient_id UUID REFERENCES User(user_id),
message_body TEXT NOT NULL,
sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
```


# Normalization Steps for AirBnB Clone Database (Achieving 3NF)

## Step 1: **Unnormalized Schema (UNF)**

We started with the following entities:

* **User**
* **Property**
* **Booking**
* **Payment**
* **Review**
* **Message**

---

## Step 2: **First Normal Form (1NF)**

**Rule:** Ensure atomicity (no repeating groups or arrays).

✅ Our schema already satisfies 1NF — all fields contain atomic values.

---

## Step 3: **Second Normal Form (2NF)**

**Rule:** Remove partial dependencies (non-prime attributes must depend on the whole primary key).

Since all our tables use **single attribute primary keys (UUIDs)**, no partial dependency exists. Schema satisfies 2NF.

✅ No adjustments needed here.

---

## Step 4: **Third Normal Form (3NF)**

**Rule:** Remove transitive dependencies (non-prime attributes must depend only on the key, the whole key, and nothing but the key).

We reviewed all tables:

### 1️⃣ **User Table**

| Attribute  | Depends on | Transitive Dependency? |
| ---------- | ---------- | ---------------------- |
| All fields | user\_id   | ❌ None                 |

✅ User table is in 3NF.

---

### 2️⃣ **Property Table**

| Attribute        | Depends on    | Transitive Dependency? |
| ---------------- | ------------- | ---------------------- |
| host\_id         | FK → user\_id | ❌ Valid FK             |
| All other fields | property\_id  | ❌ None                 |

✅ Property table is in 3NF.

---

### 3️⃣ **Booking Table**

| Attribute        | Depends on        | Transitive Dependency? |
| ---------------- | ----------------- | ---------------------- |
| property\_id     | FK → property\_id | ❌ Valid FK             |
| user\_id         | FK → user\_id     | ❌ Valid FK             |
| All other fields | booking\_id       | ❌ None                 |

✅ Booking table is in 3NF.

---

### 4️⃣ **Payment Table**

| Attribute                              | Depends on       | Transitive Dependency? |
| -------------------------------------- | ---------------- | ---------------------- |
| booking\_id                            | FK → booking\_id | ❌ Valid FK             |
| amount, payment\_date, payment\_method | payment\_id      | ❌ None                 |

✅ Payment table is in 3NF.

---

### 5️⃣ **Review Table**

| Attribute                    | Depends on        | Transitive Dependency? |
| ---------------------------- | ----------------- | ---------------------- |
| property\_id                 | FK → property\_id | ❌ Valid FK             |
| user\_id                     | FK → user\_id     | ❌ Valid FK             |
| rating, comment, created\_at | review\_id        | ❌ None                 |

✅ Review table is in 3NF.

---

### 6️⃣ **Message Table**

| Attribute               | Depends on    | Transitive Dependency? |
| ----------------------- | ------------- | ---------------------- |
| sender\_id              | FK → user\_id | ❌ Valid FK             |
| recipient\_id           | FK → user\_id | ❌ Valid FK             |
| message\_body, sent\_at | message\_id   | ❌ None                 |

✅ Message table is in 3NF.

---

## Step 5: **Potential Redundancy Considerations (Optional Optimization)**

While the schema meets 3NF, for optimization and clarity:

* **location** in Property table could optionally be normalized into a separate **Location** table (if detailed location management is required). However, for an MVP or smaller scope, leaving it as-is is acceptable.

---

## Conclusion ✅

All entities in the AirBnB Clone schema meet the requirements of **Third Normal Form (3NF)**. No redundancies or transitive dependencies exist.
