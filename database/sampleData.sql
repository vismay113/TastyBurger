/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  comuser
 * Created: 06/09/2017
 */

INSERT INTO tastyburger.category (category_name) 
	VALUES ('Beef Burger');
INSERT INTO tastyburger.category (category_name) 
	VALUES ('Chicken Burger ');
INSERT INTO tastyburger.category (category_name) 
	VALUES ('Fish Burger ');
INSERT INTO tastyburger.category (category_name) 
	VALUES ('Vegetarian burger ');
INSERT INTO tastyburger.category (category_name) 
	VALUES ('Drink ');
INSERT INTO tastyburger.category (category_name) 
	VALUES ('Chips ');
	
INSERT INTO tastyburger.customer (first_name, last_name, address, suburb, postcode, phone, email, password, `role`, code) 
	VALUES ('Jessica', 'Simpson', '123 New St', 'Sunnybank', '4109', '0430 430 567', 'jessica.simpson@email.com', '123', 'C', '');
INSERT INTO tastyburger.customer (first_name, last_name, address, suburb, postcode, phone, email, password, `role`, code) 
	VALUES ('John ', 'Kim', '3/4 Oliver Rd', 'Newmarket', '4051', '0411 908 123', 'john.kim@email.com', '321', 'C', '');
INSERT INTO tastyburger.customer (first_name, last_name, address, suburb, postcode, phone, email, password, `role`, code) 
	VALUES ('Bart', 'Legend', '9 Old Northern Rd', 'Brisbane', '4000', '0433 789 987', 'bart.legend@email.com', '456', 'C', '');
INSERT INTO tastyburger.customer (first_name, last_name, address, suburb, postcode, phone, email, password, `role`, code) 
	VALUES ('Employee', 'A', '5 Kent St', 'Brisbane', '4000', '07 3321 4567', 'EmployeeA', '789', 'E', '');

INSERT INTO tastyburger.deliverer (deliverer_name, deliverer_contact_number) 
	VALUES ('Jon Smith', '0412 123 123');
INSERT INTO tastyburger.deliverer (deliverer_name, deliverer_contact_number) 
	VALUES ('Drake Richard', '0422 234 456');

INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Burger Man', 5.00, 'Burger Buns, Beef, Cheese, Lettuce, Tomato, Onion, Pickle, Mustard, Mayonnaise, Tomato sauce', '4/09/2017 8:50:38 ', 1);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Passion Burger', 4.50, 'Burger Buns, Beef, Cheese, Lettuce, Bacon, Caramelised Onions, Pickle, BBQ Sauce, Mayonnaise', '4/09/2017 8:50:38 ', 1);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Cheese Burger', 4.00, 'Burger Buns, Beef, Cheese, Bacon, Onion Rings, Chilli Mayo & Jalapenos', '4/09/2017 8:50:38 ', 1);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Chicken Double', 4.50, 'Burger Buns, Double Chicken, Double Cheese, Lettuce, Tomato, Onion, Pickle, Trucker sauce', '4/09/2017 8:50:38 ', 2);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Chicken Fire', 4.00, 'Burger Buns, Fried Chicken, Lettuce, Ranch Sauce & Pickles', '4/09/2017 8:50:38 ', 2);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Chicken House', 4.00, 'Burger multi-grain Buns, Lettuce, Tomato, Pickles, Red onion, Mayonnaise, Choice of tender marinated grilled or crispy chicken.', '4/09/2017 8:50:38 ', 2);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Fish Lover', 6.00, 'Burger Buns, Fresh fish fillet, Eggs, Butter, Lettuce, Tomato, Avocado, Tartare sauce', '4/09/2017 8:50:38 ', 3);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Fish King', 5.50, 'Burger Turkish Buns, Two fish fillets, Tartare sauce, Sweet Smoked Paprika, Onion powder, Salt', '4/09/2017 8:50:38 ', 3);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Fish Long', 5.00, 'Burger Buns, Fresh fish fillet, Eggs, Olive oil, Lettuce, Tomato, Tartare sauce, Finely chopped flat leaf parsley', '4/09/2017 8:50:38 ', 3);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Vegetarian Burger', 5.00, 'Burger Buns, Falafel, Cheese, Lettuce, Tomato, Onion, Pickle, Mustard, Mayonnaise, Tomato sauce', '4/09/2017 8:50:38 ', 4);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Coke', 2.00, 'Coke', '4/09/2017 8:50:38 ', 5);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Fanta', 1.50, 'Orange Juice', '4/09/2017 8:50:38 ', 5);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Soda', 1.50, 'Cyder', '4/09/2017 8:50:38 ', 5);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Small', 1.00, 'Chips, Cajun Salt', '4/09/2017 8:50:38 ', 6);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Medium', 1.50, 'Chips, Cajun Salt', '4/09/2017 8:50:38 ', 6);
INSERT INTO tastyburger.item (item_name, price, ingredients, last_update, category_category_id) 
	VALUES ('Large', 2.00, 'Chips, Cajun Salt', '4/09/2017 8:50:38 ', 6);
