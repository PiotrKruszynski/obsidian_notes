---
title: "Overcoming Limitations: Creating Custom Views in Trino Connectors (JDBC) without Native Support"
source: "https://shanoj.medium.com/overcoming-limitations-creating-custom-views-in-trino-connectors-jdbc-without-native-support-2057480ea74c"
author:
  - "[[Shanoj]]"
published: 2023-08-08
created: 2026-06-13
description: "During a feasibility test using distributed SQL (Trino/Starburst) for handling large volume Adhoc SQL queries, a common challenge arose. Tri"
tags:
  - "clippings"
---
![](https://miro.medium.com/v2/resize:fit:1400/format:webp/0*3OoRfKvFTKEebr61)

During a feasibility test using distributed SQL (Trino/Starburst) for handling large volume Adhoc SQL queries, a common challenge arose. Trino, an open-source distributed SQL query engine, supports various connectors for interacting with different data sources. However, we discovered that creating views/tables on Oracle-based connectors was not directly supported by Trino. In this article, we will explore a solution to overcome this limitation by leveraging a dummy connector to create custom views in Trino.

Solution Steps:

- Create a Dummy Connector:

To enable the creation of custom views in Trino, we need to set up a dummy connector. This connector will serve as a catalog for storing the custom views and tables.

Create a new file named dummy.properties and add the following content:

```c
connector.name=memory
```
- Restart Trino:

Restart the Trino server to apply the configuration changes and make the dummy connector available.

- Verify and Select the Catalog:

Check the available catalogs using the following command:

```c
trino> show catalogs;
atalog
---------
 dummy
 jmx…
```
```c
trino> use dummy.default;
USE
```
- Create Custom Views:

Now that the dummy connector is set up and selected, we can create custom views using SQL statements. Let’s assume we want to create custom views based on tables from the oracle.hr schema. Note oracle is the connector for the Oracle database in this example.

```c
-- Create custom view
CREATE VIEW cust_emp_v AS SELECT * FROM oracle.hr.emp;
CREATE VIEW cust_dept_v AS SELECT * FROM oracle.hr.dept;
```

This solution enables us to perform complex analytics and join data from multiple connectors seamlessly, creating tables/views in Trino. By sharing this article, I aim to assist others who may face similar challenges when working with Trino and Oracle databases.