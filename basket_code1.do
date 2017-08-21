*! Data tests for Basket analysis

******************************
* Smart Analysis: THE BASKET *
******************************

* open data
use "C:\directory\datafile.dta", clear
	
* prepare data
	* keep test cp
	keep if t_CP_ID=="ES_03" // cp
	drop if level_0==14		 // Others
	drop if quantity < 0	 // negative values 
	keep if rolling12 != .	 // timeframe	

* Create Level_1 and Level_0 Markers		
		
* "NEW BUSINESS": Level_1 items which identify 70% - 100% probability  	
gen new_bus_ident = .

	*100% certainty
		replace new_bus_ident = 100 if level_1==60
	*95% certainty
		replace new_bus_ident = 95 if level_1==10
	*90% certainty
		foreach i in 89 94 90 84 90 11 8 97 74 29 {
			replace new_bus_ident = 90 if level_1==`i'
		}
	*80% certainty
		foreach i in 88 28 32 21 20 37 51 47 4 {
			replace new_bus_ident = 80 if level_1==`i'
		}
	*70% certainty
		foreach i in 33 34 75 70 36 54 27 40 {
			replace new_bus_ident = 70 if level_1==`i'
		}
	
* Marker for new business products
	* No of marker products
	gen prod_n = 1 if new_bus_ident!=.
	bysort customer_id rolling12: egen l1_nb_prods = total(prod_n)
	drop prod_n
	* Value of marker products
	bysort customer_id rolling12: egen l1_prods_val = total(new_bus_ident)
	
	* Mean of likelihood that level_0 purchase "New Business" 
	bysort customer_id rolling12: gen l1_nb_mean = l1_prods_val / l1_nb_prods
					
* "SERVICE / REPAIRS": Level_1 items which identify 80% - 95% probability  	
gen serv_rep_ident = .
	
	*95% certainty
		replace serv_rep_ident = 95 if level_1==14
	*90% certainty
		foreach i in 3 83 18 {
			replace serv_rep_ident = 90 if level_1==`i'
			}
	*80% certainty
		replace serv_rep_ident = 80 if level_1==2
		
* Marker for service / repair products
	* No of marker products
	gen prod_n = 1 if serv_rep_ident!=.
	bysort customer_id rolling12: egen l1_sr_prods = total(prod_n)
	drop prod_n
	* Value of marker products
	drop l1_prods_val
	bysort customer_id rolling12: egen l1_prods_val = total(serv_rep_ident)
	
	* Mean of likelihood that level_0 purchase "New Business" 
	bysort customer_id rolling12: gen l1_sr_mean = l1_prods_val / l1_sr_prods	
	drop l1_prods_val
	
		