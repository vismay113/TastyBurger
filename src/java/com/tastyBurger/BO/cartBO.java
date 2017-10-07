/*
 * This is the cart business object. It performs all the operations related to carts.
 */
package com.tastyBurger.BO;

import com.tastyBurger.DAO.cartDAO;
import com.tastyBurger.bean.cartBean;
import java.util.List;

/**
 *
 * @author VBlue
 */
public class cartBO {
    
    cartDAO cartOperations = new cartDAO();
    
    public int getNumberofRowsOfOld(int cus_id) {
        int rows = cartOperations.getNumberofRowsOfOld(cus_id);
        return rows;
    }
    
    public int getNumberofRowsOfNew(int cus_id) {
        int rows = cartOperations.getNumberofRowsOfNew(cus_id);
        return rows;
    }
    
    public List<cartBean> getCart(int cus_id) {
        List<cartBean> cart = cartOperations.getCart(cus_id);
        return cart;
    }
    
    public List<cartBean> getLatestCart(int cart_no) {
        List<cartBean> cart = cartOperations.getLatestCart(cart_no);
        return cart;
    }
    
    public int addToCart(cartBean cart) {
        int result = cartOperations.addToCart(cart);
        return result;
    }
    
    public int deleteFromCart(cartBean cart) {
        int result = cartOperations.deleteFromCart(cart);
        return result;
    }
    
    public int deleteCart (cartBean cart) {
        int result = cartOperations.deleteCart(cart);
        return result;
    }
    
    public String getItemName(int cus_id, String itemName) {
        String name = cartOperations.getItemName(cus_id, itemName);
        return name;
    }
    
    public int updateQuantity(String name, int quantity, int cus_id) {
        int result = cartOperations.updateQuantity(name, quantity, cus_id);
        return result;
    }
    
    public int getNumberofMaxRows(int cus_id) {
        int rows = cartOperations.getNumberofMaxRows(cus_id);
        return rows;
    }
    
    public List<cartBean> getCartByNo(int cus_id, int cart_no) {
        List<cartBean> cart = cartOperations.getCartByNo(cus_id, cart_no);
        return cart;
    }
    
}
