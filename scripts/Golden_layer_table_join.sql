create view gold.dim_customer as
SELECT 
	row_number() over(order by cst_id) as customer_key,
    ci.cst_id as Customer_id,
    ci.cst_key as Customer_no,
    ci.cst_firstname as firstname,
    ci.cst_lastname as lastname,
    ci.cst_marital_status as marital_status,
	Case when ci.cst_gndr != 'n/a' then ci.cst_gndr 
		 else coalesce(ca.gen,'n/a')
	end as gender,
    ci.cst_create_date as create_date,
    ca.bdate as birthdate,
    la.cntry as country
FROM silver.crm_cust_info AS ci
left join silver.erp_cust_az12 as ca
on ci.cst_key = ca.cid
left join silver.erp_loc_a101 as la
on ci.cst_key = ca.cid
