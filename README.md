Designer: IGIRANEZA DIANE

ID:27895

Project Name: 
                                                            CHILDREN WELFARE MANAGEMENT SYSTEM
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


**II. Phase: BUSINESS PROCESS MODELING
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





**III. Phase: LOGICAL MODEL DESIGN


This is a logical model design of my system.



![conceptual diagram](https://github.com/user-attachments/assets/e7524606-f66f-4663-a38b-5c64422c9f10)


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

 OVERVIEW ON CREATING PDB:

 ![container pl pdb2](https://github.com/user-attachments/assets/b423bba6-ab88-42c4-ad58-c1428db0fded)




 **V. Phase: Table Implementation and Data Insertion**
 

 OVERVIEW ON CREATING TABLES THAT WE USED IN THIS SYSTEM
 
**1. Table Creation**

OVERVIEW ON CREATING TABLES:

![table creation1](https://github.com/user-attachments/assets/f30ccec7-6986-4fa2-9eea-7eed241a0790)


![table creation2](https://github.com/user-attachments/assets/1f606404-38f9-4734-8309-a310ddab173f)


    



   **2. Data Insertion:**

   OVERVIEW ON INSERTING DATA:

   

 🟦FIGURE 1:  
 
![insertation](https://github.com/user-attachments/assets/eb70e95d-1ebc-446b-89cf-91ddb163fd9a)

    
🟦FIGURE 2     

![insertation 2](https://github.com/user-attachments/assets/dfeb2b3d-15e0-439c-bdd7-b2c0b49786a2)


🟦FIGURE 3 


![insertation 3](https://github.com/user-attachments/assets/85529573-d1cc-4501-a86e-373929660cc3)


🟦FIGURE 4


![insertation 4](https://github.com/user-attachments/assets/b21e291b-8ac9-4034-9558-af3b39c2b366)



.**These are clear querries and output on how we created and inserted data in our system**




**VI. Phase: Database Interaction and Transactions** 




       

    



      





























                   
                   
                   
