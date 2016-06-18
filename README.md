# CustomArkLootDrops

Improved, yet not OverPowered, Beacons  
The goal here is to improve the default beacons and crates in ARK, and yet not make them Crazy Overpowered. I do not wish to replace/make useless the Sea Crates or Cave loot crates. 
##How to Use?  
* Take the compiled one line version and put it in your game.ini file.  One line per crate, must be under the game [ ... ] header.  
* For the double crates, I changed a few numbers and thats it.  You need to have the double in your game file as well or you'll occassionally get a stock spawn
	* For Example  
		* ConfigOverrideSupplyCrateItems=(SupplyCrateClassString="SupplyCrate_Level25_C", MinItemSets=1,MaxItemSets=2, NumItemSetsPower=1.0, ...  
		  changes to
		* ConfigOverrideSupplyCrateItems=(SupplyCrateClassString="SupplyCrate_Level25_Double_C", MinItemSets=2,MaxItemSets=3, NumItemSetsPower=1.3, ... [rest the same]  
		  and add it in as a new line