📌 Repository Usage Guide

📢 Prerequisites

To use this repository correctly, you must have XAMPP installed, an application that includes the Apache server and MySQL database.

🔹 Download and Install XAMPP

Download XAMPP from the official website: https://www.apachefriends.org/index.html

Install XAMPP following the instructions provided by the installer.

🚀 Server Configuration

🔥 Start Tomcat and MySQL

Open the XAMPP Control Panel.

Start the Apache and MySQL services by clicking the "Start" buttons.

📂 Place the Repository in the Correct Directory

For Apache to serve the files correctly:

Locate the XAMPP installation folder (default: C:\xampp\htdocs on Windows, /opt/lampp/htdocs/ on Linux, or /Applications/XAMPP/htdocs/ on macOS).

Copy or clone this repository into the htdocs folder.

# Example of cloning via Git
cd C:\xampp\htdocs   # Windows

cd /opt/lampp/htdocs  # Linux

git clone https://github.com/RodrigoSalvado/JSP.git

🛠️ Import the Database

To import the project database:

Access phpMyAdmin through your browser: http://localhost/phpmyadmin

Select the Import option on the homepage and choose the file basedados/criar_bd.sql.

Click Execute to complete the import.

🎯 Access the Project

Once everything is set up, you can access the project through your browser at:

http://localhost/Trabalho_PHP

If you encounter any issues, ensure that the XAMPP services are running and that the database has been imported correctly! 🚀
