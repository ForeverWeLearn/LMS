# **LIBRARY MANAGEMENT SYSTEM (LMS)**

## **BUSINESS LOGIC CORE**

* **Granular Inventory:** Tracks physical assets via BookItem (Barcode) instead of conceptual Book (ISBN).  
* **Borrowing Protocol:** Validates Member eligibility (Active/Ban status) before granting Loan.  
* **Return Pipeline:** Real-time status recovery \+ automated Overdue Fine calculation.

## **KEY SOLUTIONS**

* **Atomic Transactions:** Handled via Store Procedures (usp\_BorrowBook, usp\_ReturnBook) to ensure data consistency during state transitions.  
* **Reactive State Management:** Triggers automatically sync BookItem status (Available ↔ Loaned) based on Loan events.  
* **Fine Automation:** Auto-generates Fine records upon late returns using DATEDIFF logic.  
* **Schema Constraints:** Hard-coded CHECK constraints for Language and Account Status to prevent invalid data entry.

## **SCOPE & LIMITATIONS**

### **Covered**

* Core CRUD for Authors, Books, and Members.  
* Full Loan/Return lifecycle.  
* Basic Penalty system.

### **Not Covered (Out of Scope)**

* **Reservation System:** No queueing for currently borrowed books.  
* **Inventory Auditing:** No tracking of stock loss, damage assessments, or procurement history.  
* **Authentication:** No Role-Based Access Control (RBAC) at the DB level.

### **Current Constraints**

* **Static Policy:** Fixed fine rates ($3600/day) hard-coded in triggers.  
* **Loan Limit:** Current schema design supports 1:1 mapping between Loan and BookItem (no bulk check-outs).  
* **Compensation Logic:** No workflow for 'Lost' or 'Damaged' book replacement fees.