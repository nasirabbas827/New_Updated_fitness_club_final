# New_Updated_fitness_club_final  

A modern, PHP‑based web application for managing a fitness club – members, subscriptions, class schedules, and automated email communications.

---

## Overview  

`New_Updated_fitness_club_final` provides a clean, extensible foundation for a fitness‑club management system. It includes:

* Member registration and profile handling  
* Subscription & payment tracking (placeholder – integrate your preferred gateway)  
* Class schedule CRUD operations  
* Automated email notifications powered by **PHPMailer** (welcome emails, password resets, reminders, etc.)  
* A ready‑to‑import MySQL schema (`Database/member_db.sql`)  

The project is deliberately lightweight, making it easy to adapt to small gyms or larger health‑club chains.

---

## Features  

| ✅ | Feature |
|---|---------|
| ✔️ | **Member Management** – add, edit, deactivate members; view activity logs |
| ✔️ | **Class Scheduling** – create recurring classes, assign instructors |
| ✔️ | **Email Integration** – PHPMailer with multilingual language packs |
| ✔️ | **Database Schema** – pre‑built tables for members, subscriptions, classes |
| ✔️ | **Configurable** – environment variables for DB and SMTP settings |
| ✔️ | **Extensible Architecture** – MVC‑style separation for easy customization |

---

## Tech Stack  

| Layer | Technology |
|-------|------------|
| **Backend** | PHP 8.1+ |
| **Database** | MySQL / MariaDB (SQL script in `Database/member_db.sql`) |
| **Email** | PHPMailer (bundled in `PHPMailer/` – see its own README for details) |
| **Package Management** | Composer (`composer.json` in `PHPMailer/`) |
| **Front‑end** | HTML5, CSS3 (Bootstrap optional) |
| **Version Control** | Git |

---

## Installation  

> **Prerequisites**  
> * PHP 8.1 or newer with PDO MySQL extension  
> * MySQL / MariaDB server  
> * Composer (global)  

1. **Clone the repository**  
   ```bash
   git clone https://github.com/yourusername/New_Updated_fitness_club_final.git
   cd New_Updated_fitness_club_final
   ```

2. **Import the database**  
   ```bash
   mysql -u <db_user> -p < Database/member_db.sql
   ```

3. **Configure environment variables**  
   Create a `.env` file in the project root (or edit `config.php`) with at least the following keys:

   ```dotenv
   DB_HOST=localhost
   DB_NAME=fitness_club
   DB_USER=your_db_user
   DB_PASS=your_db_password

   SMTP_HOST=smtp.example.com
   SMTP_PORT=587
   SMTP_USER=your_smtp_user
   SMTP_PASS=YOUR_OWN_API_KEY   # replace with your real SMTP password / API key
   SMTP_FROM=info@yourclub.com
   ```

4. **Install PHPMailer dependencies** (the PHPMailer folder already contains a `composer.json`):
   ```bash
   cd PHPMailer
   composer install
   cd ..
   ```

5. **Set proper file permissions** (if using a Linux server):
   ```bash
   sudo chown -R www-data:www-data .
   sudo chmod -R 755 .
   ```

6. **Start the built‑in PHP server**