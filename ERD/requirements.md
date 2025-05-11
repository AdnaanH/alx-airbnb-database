# AirBnB Clone Project - Database Requirements

## Entities and Attributes

### User

* **user\_id**: UUID (Primary Key, Indexed)
* **first\_name**: VARCHAR, NOT NULL
* **last\_name**: VARCHAR, NOT NULL
* **email**: VARCHAR, UNIQUE, NOT NULL
* **password\_hash**: VARCHAR, NOT NULL
* **phone\_number**: VARCHAR, NULL
* **role**: ENUM('guest', 'host', 'admin'), NOT NULL
* **created\_at**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

### Property

* **property\_id**: UUID (Primary Key, Indexed)
* **host\_id**: UUID (Foreign Key → User.user\_id)
* **name**: VARCHAR, NOT NULL
* **description**: TEXT, NOT NULL
* **location**: VARCHAR, NOT NULL
* **pricepernight**: DECIMAL, NOT NULL
* **created\_at**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP
* **updated\_at**: TIMESTAMP, ON UPDATE CURRENT\_TIMESTAMP

### Booking

* **booking\_id**: UUID (Primary Key, Indexed)
* **property\_id**: UUID (Foreign Key → Property.property\_id)
* **user\_id**: UUID (Foreign Key → User.user\_id)
* **start\_date**: DATE, NOT NULL
* **end\_date**: DATE, NOT NULL
* **total\_price**: DECIMAL, NOT NULL
* **status**: ENUM('pending', 'confirmed', 'canceled'), NOT NULL
* **created\_at**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

### Payment

* **payment\_id**: UUID (Primary Key, Indexed)
* **booking\_id**: UUID (Foreign Key → Booking.booking\_id)
* **amount**: DECIMAL, NOT NULL
* **payment\_date**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP
* **payment\_method**: ENUM('credit\_card', 'paypal', 'stripe'), NOT NULL

### Review

* **review\_id**: UUID (Primary Key, Indexed)
* **property\_id**: UUID (Foreign Key → Property.property\_id)
* **user\_id**: UUID (Foreign Key → User.user\_id)
* **rating**: INTEGER, CHECK (rating >= 1 AND rating <= 5), NOT NULL
* **comment**: TEXT, NOT NULL
* **created\_at**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

### Message

* **message\_id**: UUID (Primary Key, Indexed)
* **sender\_id**: UUID (Foreign Key → User.user\_id)
* **recipient\_id**: UUID (Foreign Key → User.user\_id)
* **message\_body**: TEXT, NOT NULL
* **sent\_at**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

## Constraints

### User Table

* Unique constraint on **email**
* Non-null constraints on required fields

### Property Table

* Foreign key constraint on **host\_id**
* Non-null constraints on essential attributes

### Booking Table

* Foreign key constraints on **property\_id** and **user\_id**
* **status** must be one of 'pending', 'confirmed', or 'canceled'

### Payment Table

* Foreign key constraint on **booking\_id** (linked to valid bookings)

### Review Table

* Constraints on **rating** values (1-5)
* Foreign key constraints on **property\_id** and **user\_id**

### Message Table

* Foreign key constraints on **sender\_id** and **recipient\_id**

## Indexing

* Primary Keys: Indexed automatically
* Additional Indexes:

  * **email** in the User table
  * **property\_id** in Property and Booking tables
  * **booking\_id** in Booking and Payment tables
