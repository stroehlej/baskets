*! Data tests for Basket analysis

**********************
* Smart Analysis:
* THE BASKET
**********************

	* open data
	*use "C:\Users\Judith\Documents\Spaces\IN_00_INTERN\2016_Q3\02_Mashine_room\161118_IN_all_2016_Q3_Master_Data_Stata_JS_1545.dta", clear
	use "C:\Users\Judith\Documents\Spaces\ES_00_INTERN\2016_Q3\02_Mashine_room\161119_ES_all_2016_Q3_Master_Data_Stata_JS_1315.dta", clear
	

	* prepare data
		* keep test cp
		keep if t_CP_ID=="ES_03" // cp
		drop if level_0==14		 // Others
		drop if quantity < 0	 // negative values 
		keep if rolling12 != .	 // timeframe	
