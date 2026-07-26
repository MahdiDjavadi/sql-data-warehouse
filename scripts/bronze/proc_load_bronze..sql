/*

		Purpose of this script is to load the bronze layer tables from the source csv files.
	It performs the following steps:
		1. Truncate the bronze layer tables
		2. Load the data from the source csv files into the bronze layer tables using bulk insert.

	Parameters:
		None
	This stored procedure does not take any parameters.

	Usage:
		To execute this stored procedure, use the following command:
		EXEC [bronze].[load_bronze];

*/
USE [data_warehouse]
GO

create or alter procedure [bronze].[load_bronze] as
begin
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	BEGIN TRY
		SET @batch_start_time = GETDATE();
		print ' ───────────────────────────────────────────── ';
		print ' Loading Bronze Layer ';
		print ' ───────────────────────────────────────────── ';

		PRINT ' ';
		print ' ============================================= ';
		print ' loading CRM Tables ';
		print ' ============================================= ';

		SET @start_time = GETDATE();
		print '>> Truncating Table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;
		print '>> Inserting Data into: crm_cust_info';
		bulk insert bronze.crm_cust_info
		from  'C:\github_clone\sql-data-warehouse\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
			);
		SET @end_time = GETDATE();
		print '>> Time Taken to Load Table: crm_cust_info : ' + cast(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' seconds';
		PRINT ' -------------------------------- ';

		SET	 @start_time = GETDATE();
		print '>> Truncating Table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;
		print '>> Inserting Data into: crm_prd_info';
		bulk insert bronze.crm_prd_info
		from  'C:\github_clone\sql-data-warehouse\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
			);
		SET @end_time = GETDATE();
		print '>> Time Taken to Load Table: crm_prd_info : ' + cast(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' seconds';
		PRINT ' -------------------------------- ';
		
		SET	 @start_time = GETDATE();
		print '>> Truncating Table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;
		print '>> Inserting Data into: crm_sales_details';
		bulk insert bronze.crm_sales_details
		from  'C:\github_clone\sql-data-warehouse\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
			);
		SET @end_time = GETDATE();
		print '>> Time Taken to Load Table: crm_sales_details : ' + cast(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' seconds';

			
		print ' ============================================= ';
		print ' loading ERP Tables ';
		print ' ============================================= ';
	
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
		print '>> Inserting Data into: erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from  'C:\github_clone\sql-data-warehouse\datasets\source_erp\cust_az12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
			);
		SET @end_time = GETDATE();
		print '>> Time Taken to Load Table: erp_cust_az12 : ' + cast(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' seconds';
		PRINT ' -------------------------------- ';
		SET @start_time = GETDATE();
		print '>> Truncating Table: bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;
		print '>> Inserting Data into: erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from  'C:\github_clone\sql-data-warehouse\datasets\source_erp\loc_a101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
			);
		SET @end_time = GETDATE();
		print '>> Time Taken to Load Table: erp_loc_a101 : ' + cast(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' seconds';
		PRINT ' -------------------------------- ';
		SET @start_time = GETDATE();
		print '>> Truncating Table: bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data into: erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from  'C:\github_clone\sql-data-warehouse\datasets\source_erp\px_cat_g1v2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
			);
		SET @end_time = GETDATE();
		print '>> Time Taken to Load Table: erp_px_cat_g1v2 : ' + cast(DATEDIFF(SECOND, @start_time, @end_time) as NVARCHAR) + ' seconds';
		PRINT ' -------------------------------- ';
		SET @batch_end_time = GETDATE();
		print ' ───────────────────────────────────────────── ';
		print ' Total Time Taken to Load Bronze Layer : ' + cast(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) as NVARCHAR) + ' seconds';
		print ' ───────────────────────────────────────────── ';
		PRINT ' ';
	end TRY
	BEGIN CATCH
		print ' ───────────────────────────────────────────── ';
		print ' Error Occured while loading Bronze Layer ';
		print ' Error Occured: ' + ERROR_MESSAGE();
		print ' error Number: ' + cast(ERROR_NUMBER() as NVARCHAR);
		print ' error state: ' + cast(ERROR_STATE() as NVARCHAR);
		print ' ───────────────────────────────────────────── ';
	end CATCH
end;