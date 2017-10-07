/*
 * This is the order business object. It performs all the operations related to orders.
 */
package com.tastyBurger.BO;

import com.tastyBurger.DAO.cartDAO;
import com.tastyBurger.DAO.orderDAO;
import com.tastyBurger.bean.cartBean;
import com.tastyBurger.bean.delivererBean;
import com.tastyBurger.bean.orderBean;
import java.util.List;
import java.util.Random;

/**
 *
 * @author VBlue
 */
public class orderBO {
    
    orderDAO orderOperations = new orderDAO();
    cartDAO cartOps = new cartDAO();
    
    public int addOrder(orderBean order) throws Exception {
        int results = 0;
        int resultFinal = 0;
        int result = orderOperations.addOrder(order);
        int size = getDeliverersSize();
        if (result > 0) {
            int deliverer_id = randomNumber(size);
            results = orderOperations.setDeliverer(order.getCart_no(), deliverer_id);
        }
        if (results > 0) {
            resultFinal = cartOps.updateCart(order.getCart_no(), order.getCustomerId());
        }
        
        return resultFinal;
    }
    
    public delivererBean getDelivererPerson() {
        delivererBean deliverer = orderOperations.getDeliveryPerson();
        return deliverer;
    }
    
    public int getDeliverersSize() {
        int size = orderOperations.getNumberOfDrivers();
        return size;
    }
    
    public int randomNumber(int size) throws Exception {
		
	// create random object
	Random randomNumber = new Random();
	 
	// check next int value  
	int code = randomNumber.nextInt(size);
	return code;
    }
    
    public List<List<cartBean>> getAllOrdersForCustomer(int cus_id) {
        List<List<cartBean>> orders = orderOperations.getAllOrdersForCustomer(cus_id);
        return orders;
    }
    
    public List<Integer> getAmout(int cus_id) {
        List<Integer> amounts = orderOperations.getAmout(cus_id);
        return amounts;
    }
    
    public List<orderBean> getOrderByStatus (String status) {
        List<orderBean> orders = orderOperations.getOrderByStatus(status);
        return orders;
    }
    
    public int updateStatus(int order_id, String status) {
        int result = orderOperations.updateStatus(order_id, status);
        return result;
    }
}
