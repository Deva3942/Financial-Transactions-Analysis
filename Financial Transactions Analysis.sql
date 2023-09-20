-- Retrieve all columns for transactions where the transaction amount is greater than 2000?
select * from dbo.fraud_dataset where transaction_amount > 2000;

-- Calculate the average transaction amount for each merchant?
select merchant, avg(transaction_amount) as "Average Transaction Amount" 
from dbo.fraud_dataset 
group by merchant;

-- Count the number of transactions for each location?
select location, count(*) as "Transaction Count" 
from dbo.fraud_dataset
group by location;

-- Find the total transaction amount for each gender?
select gender, sum(transaction_amount) as "Total Transaction Amount" 
from dbo.fraud_dataset
group by gender;

-- Calculate the percentage of fraudulent transactions for each merchant?
select merchant, 
sum(case when fraud_label = 1 then 1 else 0 end) / count(*) * 100 as "Fraud Percentage"
from dbo.fraud_dataset
group by merchant;

-- Retrieve the transactions where the transaction amount is in the range of 1000 to 2000 (inclusive)?
select * from dbo.fraud_dataset where transaction_amount between 1000 and 2000;

-- Find the average age of customers for each merchant in New York?
select merchant, avg(age) as "Average Age" from dbo.fraud_dataset
where location = 'New York'
group by merchant;

-- Count the number of transactions for each age group?
select 
case 
when age between 20 and 30 then '20-30'
when age between 31 and 40 then '31-40'
when age between 41 and 50 then '41-50'
else '51+'
end as "Age Group",
count(*) as "Transaction Count"
from dbo.fraud_dataset
group by 
case 
when age between 20 and 30 then '20-30'
when age between 31 and 40 then '31-40'
when age between 41 and 50 then '41-50'
else '51+'
end;

-- Find the total transaction amount and the number of transactions for each location?
select location, sum(transaction_amount) as "Total Transaction Amount", 
count(*) as transaction_count
from dbo.fraud_dataset 
group by location;

-- Calculate the average age of customers for each gender and location?
select gender, location, avg(age) as "Average Age"
from dbo.fraud_dataset
group by gender, location;

-- Determine the highest transaction amount for each merchant?
select merchant, max(transaction_amount) as "Highest Transaction Amount"
from dbo.fraud_dataset
group by merchant;

-- Identify the location with the highest total transaction amount?
select top 1 location
from (select location, sum(transaction_amount) as total_transaction_amount
from dbo.fraud_dataset
group by location) as location_totals
order by total_transaction_amount desc;

-- Calculate the total number of fraudulent transactions and the percentage of fraud for each location?
select location,
sum(case when fraud_label = 1 then 1 else 0 end) as "Total Fraudulent Transactions",
(sum(case when fraud_label = 1 then 1 else 0 end) / count(*)) * 100 as "Fraud Percentage"
from dbo.fraud_dataset
group by location;

-- Retrieve the transactions with a transaction amount greater than the average transaction amount
select * from dbo.fraud_dataset where transaction_amount > (select avg(transaction_amount) from dbo.fraud_dataset);

-- Calculate the average age of customers for transactions with fraud (fraud_label = 1) and without fraud (fraud_label = 0)?
select case when fraud_label = 1 then 'Fraudulent' else 'Non-Fraudulent' end as transaction_type,
avg(age) as average_age
from dbo.fraud_dataset
group by 
case when fraud_label = 1 then 'Fraudulent' else 'Non-Fraudulent' end;