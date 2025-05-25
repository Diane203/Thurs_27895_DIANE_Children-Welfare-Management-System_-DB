Designer: IGIRANEZA DIANE

ID:27895

Project Name:

![image](https://github.com/user-attachments/assets/a8267382-8855-4aa9-9f63-3e0714dee1ed)    HOPE HAVEN   CHILDREN WELFARE MANAGEMENT SYSTEM



                                          
---
I.Phase:Problem Statement and Presentation
-
INTRODUCTION

The Children Welfare Management System is an Oracle PL/SQL-based database solution designed to manage the welfare, care, and development of orphaned and vulnerable children under the age of 18, with a special focus on those with disabilities. The system categorizes children into different sections (e.g., disabled, non-disabled) and supports their daily activities, medical care, education, and service tracking through centralized data management.


📌Problem Definition:

Many child welfare centers (especially those caring for orphaned or abandoned children with disabilities) rely on manual record-keeping, resulting in data loss, inconsistent tracking, and poor coordination among caregivers, educators, and medical staff. There is a lack of a centralized, secure, and efficient system to manage children’s welfare data — from medical history and educational progress to daily services received.



🔹 Context:


This system will be used in child welfare centers, such as orphanages and social care institutions, where children under 18 — especially those with disabilities — receive long-term care, education, and health services. It replaces manual processes and fragmented records with a unified digital database managed through Oracle PL/SQL.



🔹 Target Users:


⚫Social workers

⚫Healthcare providers

⚫Educators

⚫System administrators

⚫Orphanage management teams


These users will interact with the system to manage, update, and retrieve welfare-related information for each child.




🔹 Project Goals:


⚫Automate workflows such as admission, section placement, service tracking, and education monitoring.

⚫Improve accuracy in record-keeping, ensuring all child-related data is stored consistently and reliably.

⚫Enhance data security through role-based access and auditing mechanisms.

⚫Increase efficiency in managing large volumes of information and reporting.

⚫Prevent scheduling conflicts, such as inserting records on public holidays, using intelligent triggers.






 Phase II: BUSINESS PROCESS MODELING
--
✅ Scope of the Business Process: Child Admission Process


This business process models the admission of a child into a child welfare center using a Management Information System (MIS). It outlines how data is collected, stored, and reviewed before a child is officially admitted into the system. The process ensures that all information is verified and approved through structured interaction between social workers, the MIS database, and administrators.




✅ Objectives and Expected Outcomes:
OBJECTIVES:

⚫Ensure accurate collection of child information.

⚫Digitally store all admission data into the MIS database.

⚫Verify and approve admissions through a structured review process.



EXPECTED OUTCOMES:




⚫A validated, complete record of each child in the system.

⚫Proper classification of children into appropriate care sections.

⚫Enhanced decision-making based on accurate and accessible data.





✅ Brief Description of the BPMN Diagram:


The diagram visualizes the Child Admission Process across three swimlanes:

⚫Social Worker: Begins the process by collecting the child’s information and submitting it to the system.

⚫Database (MIS): Stores the information and initiates a check for admission approval. If the data is incomplete or invalid, the system generates a report for review.

⚫Administrator: Reviews the report and makes a final decision. If approved, the child is admitted; if not, the process loops back for correction.





**BPMN DIAGRAM**

![BPMN 2](https://github.com/user-attachments/assets/37f7122c-86a6-4598-aaba-e32f7367ae9c)













**III. Phase: LOGICAL MODEL DESIGN**





**This is a logical model design of my system.**



![conceptual diagram](https://github.com/user-attachments/assets/e7524606-f66f-4663-a38b-5c64422c9f10)




**This is a ERD design of this system**

![ERD](https://github.com/user-attachments/assets/981a8199-eac1-4f76-abd0-b64132c95585)








1.Entity-Relationship (ER) Model



1.1.🔹 Entities, Attributes, Data Types, and Keys


🟩 sections

| Attribute     | Data Type    | Key / Constraint |
| ------------- | ------------ | ---------------- |
| section\_id   | NUMBER       | Primary Key (PK) |
| section\_name | VARCHAR2(50) | NOT NULL, UNIQUE |




🟩 children
| Attribute          | Data Type     | Key / Constraint                           |
| ------------------ | ------------- | ------------------------------------------ |
| child\_id          | NUMBER        | Primary Key (PK)                           |
| full\_name         | VARCHAR2(100) | NOT NULL                                   |
| date\_of\_birth    | DATE          | NOT NULL                                   |
| gender             | VARCHAR2(10)  | CHECK (gender IN ('Male','Female'))        |
| disability\_status | VARCHAR2(3)   | CHECK (disability\_status IN ('Yes','No')) |
| section\_id        | NUMBER        | Foreign Key (FK → sections.section\_id)    |




🟩 education

| Attribute          | Data Type     | Key / Constraint                      |
| ------------------ | ------------- | ------------------------------------- |
| education\_id      | NUMBER        | Primary Key (PK)                      |
| child\_id          | NUMBER        | Foreign Key (FK → children.child\_id) |
| school\_name       | VARCHAR2(100) | NOT NULL                              |
| grade\_level       | VARCHAR2(30)  |                                       |
| performance\_notes | VARCHAR2(200) |                                       |





🟩 staff

| Attribute       | Data Type     | Key / Constraint |
| --------------- | ------------- | ---------------- |
| staff\_id       | NUMBER        | Primary Key (PK) |
| full\_name      | VARCHAR2(100) | NOT NULL         |
| position        | VARCHAR2(50)  | NOT NULL         |
| contact\_number | VARCHAR2(15)  | UNIQUE           |





🟩 support_services

| Attribute     | Data Type     | Key / Constraint                      |
| ------------- | ------------- | ------------------------------------- |
| service\_id   | NUMBER        | Primary Key (PK)                      |
| service\_type | VARCHAR2(50)  | NOT NULL                              |
| description   | VARCHAR2(200) |                                       |
| child\_id     | NUMBER        | Foreign Key (FK → children.child\_id) |
| staff\_id     | NUMBER        | Foreign Key (FK → staff.staff\_id)    |
| service\_date | DATE          | DEFAULT SYSDATE                       |






✅ 2. Relationships & Constraints

| Relationship                      | Type | Description                                            |
| --------------------------------- | ---- | ------------------------------------------------------ |
| One section → many children       | 1\:M | One section contains multiple children                 |
| One child → one education record  | 1:1  | Each child has one main education record               |
| One child → many support services | 1\:M | A child can receive many services                      |
| One staff → many support services | 1\:M | One staff member can provide services to many children |





🔒 Constraints Used:


🟢NOT NULL for essential fields (e.g., child names, gender)

🟢UNIQUE for section names and staff contact numbers

🟢CHECK constraints for valid gender and disability_status

🟢DEFAULT value for service_date (set to SYSDATE)





✅ 3. Normalization (to 3NF)



| Normal Form | How It’s Achieved                                         |
| ----------- | --------------------------------------------------------- |
| **1NF**     | All attributes hold atomic values; no repeating groups    |
| **2NF**     | All non-key attributes fully dependent on the primary key |
| **3NF**     | No transitive dependencies; all fields depend only on PK  |


✅ Result: All tables are fully normalized to 3NF




  ![image](https://github.com/user-attachments/assets/fa61bf68-3fa1-472f-aa49-a8ff4b68e23f)
🔹We used 3rd Normal Form (3NF) in the design of your tables to:


⚫Eliminate redundancy (e.g., sections are stored in a separate sections table)

⚫Ensure each table has one purpose (e.g., children, staff, education, etc.)

⚫Support clean relationships through foreign keys

✅ This makes your system easier to maintain, query, and scale.





✅ 4. Handling Data Scenarios


This model can handle:

🟢Children assigned to specific sections (disabled, non-disabled)

🟢Children with or without disabilities

🟢Children enrolled in different schools and grade levels

🟢Staff assigned to children for various support services

🟢Logging multiple services per child

🟢Restricting insertions on public holidays using triggers

🟢Generating reports via packages/procedures





**IV. Phase: Database (Pluggable Database) Creation and Naming**



 **OVERVIEW ON CREATING PDB:**

 ![container pl pdb2](https://github.com/user-attachments/assets/b423bba6-ab88-42c4-ad58-c1428db0fded)



**Oracle Enterprise Manager (OEM) Overview Meaning**



**Oracle Enterprise Manager (OEM)** is Oracle's comprehensive database and systems management platform that provides centralized monitoring, administration, and automation capabilities for Oracle databases and IT infrastructure.


**Core Purpose**
OEM serves as a unified management console that allows database administrators and IT teams to monitor, manage, and optimize Oracle database environments from a single web-based interface.


**Screenshots from OEM**



**FIGURE**


These screenshot clearly shows my progress so far in OEM



![IEOM](https://github.com/user-attachments/assets/0854f86d-075a-4253-83e3-246d1d6ea961)

![IEOM2](https://github.com/user-attachments/assets/d7952a42-176e-443d-adc5-c47043c17499)






 **V. Phase: Table Implementation and Data Insertion**
 

 ❇️OVERVIEW ON CREATING TABLES THAT WE USED IN THIS SYSTEM

 
 
**1. Table Creation**

❇️OVERVIEW ON CREATING TABLES:

![table creation1](https://github.com/user-attachments/assets/f30ccec7-6986-4fa2-9eea-7eed241a0790)


![table creation2](https://github.com/user-attachments/assets/1f606404-38f9-4734-8309-a310ddab173f)


    



   **2. Data Insertion:**

   ❇️OVERVIEW ON INSERTING DATA:

   

 🟦FIGURE 1:  
 
![insertation](https://github.com/user-attachments/assets/eb70e95d-1ebc-446b-89cf-91ddb163fd9a)

    
🟦FIGURE 2     

![insertation 2](https://github.com/user-attachments/assets/dfeb2b3d-15e0-439c-bdd7-b2c0b49786a2)


🟦FIGURE 3 


![insertation 3](https://github.com/user-attachments/assets/85529573-d1cc-4501-a86e-373929660cc3)


🟦FIGURE 4


![insertation 4](https://github.com/user-attachments/assets/b21e291b-8ac9-4034-9558-af3b39c2b366)





.**⚠️These are clear querries and output on how we created and inserted data in our system**





**VI. Phase: DATABASE INTERACTIONS and TRANSACTIONS** 


**1. Database Operations:**



**DDL and DML Operations**

![ddl dml](https://github.com/user-attachments/assets/95ba0ab3-3a87-48a2-a21e-9ae4d56127e7)


**Window Functions**



**Window Function Usage**

![window function usage](https://github.com/user-attachments/assets/a1395b05-0d30-432c-a3c7-138a970fa7d0)


**Window Function Testing**

![WINDOW FUNCTION TESTING](https://github.com/user-attachments/assets/894ce236-7d59-4a9c-a3bd-f8af7e3ff2e7)


![image](https://github.com/user-attachments/assets/eeac4839-dfa3-49eb-8a68-69665a7e7d2e)

✅ Why we used it:

⚫Helps administrators identify high-needs children

⚫Supports data-driven decisions for resource allocation




**procedure example**


![procedure example](https://github.com/user-attachments/assets/60b8eaa2-3ede-4e7d-99db-390e05bb6eaa)



**procedure testing**


![testing procedure](https://github.com/user-attachments/assets/510e6ace-3d4a-46e8-be12-b29bcd6331c5)




**Function Usage**


![function](https://github.com/user-attachments/assets/09e337e4-b2ee-439e-a4c9-1e39ed74766b)


**Function Testing**


![fuction testing](https://github.com/user-attachments/assets/4a2c7b82-3597-46b5-9725-044d3ac56a29)






This function returns the number of support services a child has received.


![image](https://github.com/user-attachments/assets/df0a00cc-fae7-4b18-8fa4-b027c59c3443) ✅ Why it's helpful:

⚫Supports analytics and reporting

⚫Can be reused in procedures or even in SELECT queries 




**Package Usage**
![package xxx1](https://github.com/user-attachments/assets/bce41cab-3e4f-44fc-afaa-166311a56040)
![package xxx2](https://github.com/user-attachments/assets/894ef044-5ed1-4acf-8a14-acf2d9152da3)



**Testing Package**

![TESTING PACKAGE](https://github.com/user-attachments/assets/1847aac3-b108-4d56-8562-76d1f245b490)




🔷Contains:

⚫A procedure to list services per child

⚫A function to count total services


![image](https://github.com/user-attachments/assets/71dad8cb-6543-4e91-8410-cd6ca9d8891a)

✅ Why we used a package:

⚫Groups related logic in one reusable unit

⚫Improves organization, readability, and maintainability

⚫Allows better modular programming




**CURSOR CREATION AND TESTING**


![CURSOR CREATION AND TESTING](https://github.com/user-attachments/assets/deda89a2-e8a1-449f-ab6b-a6c0e77b2b35)


![image](https://github.com/user-attachments/assets/df74e8b6-f56e-4c5b-9d46-c5dbddca6a72)

✅ Why it was used:

⚫To loop through all children in a section dynamically

⚫Useful for report generation, data review, and batch processing


**VII. 	Phase: Advanced Database Programming and Auditing** 


**Simple Trigger**

![trigger screenshot](https://github.com/user-attachments/assets/5b8b5f5a-05d0-4ca1-9d32-ebe866af926a)



🔎 Purpose:
Log every successful INSERT into the children table.

![image](https://github.com/user-attachments/assets/496061f5-d670-4292-9c60-e07a6b5bc4d0)

✅ Why it was used:

⚫To keep a permanent audit trail of when children are added.

⚫Essential for accountability, especially in welfare systems where transparency is key.



**Compound Trigger**

![image](https://github.com/user-attachments/assets/3e7080e1-fe51-44b3-b31e-ba44e5f63d13)

PROBLEM STATEMENT:


 The Children Welfare Management System handles sensitive records such as child profiles, medical details, and service history.To maintain data integrity and ensure security, the system must restrict table manipulations (INSERT, UPDATE, DELETE) during weekdays and on upcoming public holidays (next 30 days only). This prevents unauthorized or accidental changes during official closure periods.
 We will implement auditing to log all attempts to manipulate data and enforce these restrictions using triggers and a holiday table
 

✅STEP 1: Reference Table to Store Upcoming Public Holiday

![table public holidays](https://github.com/user-attachments/assets/ac6baaa2-7093-4213-b92d-2e3351111495)



✅STEP 2: Insert into public Holiday


![insert on public holiday](https://github.com/user-attachments/assets/09e142f3-13f8-458d-b64e-af5f6606cbbd)



✅ STEP 3: Audit Table to Track User Activity



![Audit logs](https://github.com/user-attachments/assets/c596d64c-ce69-4e8e-aab3-c518cdbc7798)




✅ STEP 3: Security Trigger to Prevent Manipulation on Weekdays and Holidays



![trigger holidays](https://github.com/user-attachments/assets/9dab4778-bd3c-4a64-b51f-116c8253355b)
![trigger holidays end](https://github.com/user-attachments/assets/a9440feb-2477-4c24-9c80-fbb8c3e4266c)




🔎 Purpose:

✅ Prevent INSERT, UPDATE, or DELETE on children:

✅During weekdays (Mon–Fri)

✅On public holidays within the next 30 days

![image](https://github.com/user-attachments/assets/1ed35734-0c98-4693-9ff1-1edc522ccfbe)

✅ Why it's critical:

⚫Protects the data from being changed during non-operational hours or days

⚫Enforces operational policies of a welfare center

⚫Logs both allowed and denied attempts, adding security + audit tracking





















       

    



      





























                   
                   
                   
