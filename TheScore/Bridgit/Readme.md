# Technical Interview Questionnaire

## Question 1 — Sorting Integers

Write a function that takes a list of integers and returns the integers sorted in ascending order. The list may contain negative numbers and duplicate values.

## Question 2 — Rate-Limiting Middleware

Write middleware that limits the number of requests a client can make within a configurable time window. When the limit is exceeded, it should return an HTTP `429 Too Many Requests` response.

## Question 3 — Top Three Departments

Given an `Employee` table with `EmployeeID`, `DepartmentID`, and `Salary`, and a `Department` table with `DepartmentID` and `DepartmentName`, write a SQL query that returns the three departments with the highest total employee salaries.

## Question 4 — Library Database Model

Design a relational database model for a library system containing customers, books, authors, physical book copies, and borrowing records. The model should support books with multiple authors, multiple copies of each book, due dates, returns, and determining whether a copy is currently available.

## Bonus Question — Finding Duplicates

Write a SQL query that finds duplicate records in a database table based on one or more selected columns, and returns each duplicated value along with the number of times it appears.

