Week 4 

Part 1. dbt Snapshots

Create a snapshot model using the orders source in the /snapshots/ directory of our dbt project

Run the snapshot model to create it in our database (dbt snapshot)
  make sure to add strategy and column checks to snapshot sql model

Run delivery-update.sh to update the delivery status of some (3) orders. 
  This updates data for order Ids ('914b8929-e04a-40f8-86ee-357f2be3a2a2', '05202733-0e17-4726-97c2-0520c024ab85', '939767ac-357a-4bec-91f8-a7b25edd46c9')

Run dbt snapshot again and see how the data has changed
  if the snapshot does not update, check snapshot logic
  
Part 2. Modeling challenge
![image](https://user-images.githubusercontent.com/20348624/161450807-52f74ce0-1c18-49e8-b298-ebb635e08c43.png)
