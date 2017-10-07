/*
 * This is order database access class. This class connects to customer_order and cart table in the database.
 */
package com.tastyBurger.DAO;

import com.tastyBurger.bean.cartBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VBlue
 */
public class cartDAO {
    
    private Connection connection;
    private PreparedStatement addToCart;
    private PreparedStatement deleteFromCart;
    private PreparedStatement deleteCart;
    private PreparedStatement getCart;
    private PreparedStatement countRowsOld;
    private PreparedStatement countRowsNew;
    private PreparedStatement getItemName;
    private PreparedStatement updateQuantity;
    private PreparedStatement updateCart;
    private PreparedStatement getCartId;
    private PreparedStatement countMaxRows;
    private PreparedStatement getCartByNo;

    
    public int addToCart(cartBean cart) {
        int result = 0;
        
        try {
            connection = connectionDAO.getConnection();
            addToCart = connection.prepareStatement("insert into cart(cart_no, item_name, item_price, item_quantity, customer_id) values(?,?,?,?,?)");
            
            addToCart.setInt(1, cart.getCart_no());
            addToCart.setString(2, cart.getName());
            addToCart.setInt(3, cart.getPrice());
            addToCart.setInt(4, cart.getQuantity());
            addToCart.setInt(5, cart.getCustomer_id());
            
            result = addToCart.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return result;
    }
    
    public int deleteFromCart(cartBean cart) {
        int result = 0;
        
        try {
            connection = connectionDAO.getConnection();
            deleteFromCart = connection.prepareStatement("delete from cart where customer_id=? and item_name=?");
            
            deleteFromCart.setInt(1, cart.getCustomer_id());
            deleteFromCart.setString(2, cart.getName());
            
            result = deleteFromCart.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return result;
    }
    
    public int deleteCart(cartBean cart) {
        int result = 0;
        int rows = 0;
        
        try {
            connection = connectionDAO.getConnection();
            countRowsNew = connection.prepareStatement("select count(customer_id) as numberOfRows FROM cart where customer_id=? and cart_status='n'");
            countRowsNew.setInt(1, cart.getCustomer_id());
            
            ResultSet rs = countRowsNew.executeQuery();
            
            while (rs.next()) {
                rows = rs.getInt(1);
            }
            
            deleteCart = connection.prepareStatement("delete from cart where customer_id=?");
            
            for (int i = 0; i < rows; i++) {
                deleteCart.setInt(1, cart.getCustomer_id());
                result = deleteCart.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return result;
    }
    
    public List<cartBean> getCart(int cus_id) {
        List<cartBean> cart = new ArrayList<cartBean>();
        cartBean cartitem;
        
        try {
            connection = connectionDAO.getConnection();
            getCart = connection.prepareStatement("select * from cart where customer_id=? and cart_status='n'");
            
            getCart.setInt(1, cus_id);
            ResultSet rs = getCart.executeQuery();
            
            while (rs.next()) {
                cartitem = new cartBean();
                
                cartitem.setCart_id(rs.getInt("cart_id"));
                cartitem.setCart_no(rs.getInt("cart_no"));
                cartitem.setName(rs.getString("item_name"));
                cartitem.setPrice(rs.getInt("item_price"));
                cartitem.setQuantity(rs.getInt("item_quantity"));
                cartitem.setCart_status(rs.getString("cart_status"));
                cartitem.setCustomer_id(rs.getInt("customer_id"));
                
                cart.add(cartitem);
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return cart;
    }
    
    public int getNumberofRowsOfOld(int cus_id) {
        int rows = 0;
        
        try {
            connection = connectionDAO.getConnection();
            countRowsOld = connection.prepareStatement("select count(customer_id) as numberOfRows FROM cart where customer_id=? and cart_status='o'");
            
            countRowsOld.setInt(1, cus_id);
            
            ResultSet rs = countRowsOld.executeQuery();
            
            while (rs.next()) {
                rows = rs.getInt("numberOfRows");
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return rows;
    }
    
    public int getNumberofRowsOfNew(int cus_id) {
        int rows = 0;
        
        try {
            connection = connectionDAO.getConnection();
            countRowsNew = connection.prepareStatement("select count(customer_id) as numberOfRows FROM cart where customer_id=? and cart_status='n'");
            
            countRowsNew.setInt(1, cus_id);
            
            ResultSet rs = countRowsNew.executeQuery();
            
            while (rs.next()) {
                rows = rs.getInt("numberOfRows");
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return rows;
    }
    
    public String getItemName(int cus_id, String itemName) {
        String name = null;
        
        try {
            connection = connectionDAO.getConnection();
            getItemName = connection.prepareStatement("select item_name from cart where customer_id=? and cart_status='n' and item_name=?");
            getItemName.setInt(1, cus_id);
            getItemName.setString(2, itemName);
            
            ResultSet rs = getItemName.executeQuery();
            while (rs.next()) {
                name = rs.getString("item_name");
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return name;
    }
    
    public int updateQuantity(String name, int quantity, int cus_id) {
        int result = 0;
        
        try {
            connection = connectionDAO.getConnection();
            updateQuantity = connection.prepareStatement("update cart set item_quantity=? where item_name=? and customer_id=?");
            
            updateQuantity.setInt(1, quantity);
            updateQuantity.setString(2, name);
            updateQuantity.setInt(3, cus_id);
            
            result = updateQuantity.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return result;
    }
    
    public int updateCart(int cart_no, int cus_id) {
        int result = 0;
        List<Integer> ids = new ArrayList<Integer>();
        
        try {
            connection = connectionDAO.getConnection();
            getCartId = connection.prepareStatement("select cart_id from cart where cart_no=?");
            getCartId.setInt(1, cart_no);
            
            ResultSet rs = getCartId.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("cart_id");
                System.out.println("id : "+id);
                ids.add(id);
            }
            
            updateCart = connection.prepareStatement("update cart set cart_status='o' where cart_no=? and customer_id=? and cart_id=?");

            for (int j = 0; j < ids.size() ; j++) {
                updateCart.setInt(1, cart_no);
                updateCart.setInt(2, cus_id);
                updateCart.setInt(3, ids.get(j));
                
                result = updateCart.executeUpdate();
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return result;
    }
    
    public List<cartBean> getLatestCart(int cart_no) {
        List<cartBean> cart = new ArrayList<cartBean>();
        cartBean cartitem;
        
        try {
            connection = connectionDAO.getConnection();
            getCart = connection.prepareStatement("select * from cart where cart_no=?");
            
            getCart.setInt(1, cart_no);
            
            ResultSet rs = getCart.executeQuery();
            
            while (rs.next()) {
                cartitem = new cartBean();
                
                cartitem.setCart_id(rs.getInt("cart_id"));
                cartitem.setCart_no(rs.getInt("cart_no"));
                cartitem.setName(rs.getString("item_name"));
                cartitem.setPrice(rs.getInt("item_price"));
                cartitem.setQuantity(rs.getInt("item_quantity"));
                cartitem.setCart_status(rs.getString("cart_status"));
                cartitem.setCustomer_id(rs.getInt("customer_id"));
                
                cart.add(cartitem);
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return cart;
    }
    
    public int getNumberofMaxRows(int cus_id) {
        int rows = 0;
        
        try {
            connection = connectionDAO.getConnection();
            countMaxRows = connection.prepareStatement("select max(cart_no) as numberOfRows FROM cart where customer_id=? and cart_status='o'");
            
            countMaxRows.setInt(1, cus_id);
            
            ResultSet rs = countMaxRows.executeQuery();
            
            while (rs.next()) {
                rows = rs.getInt("numberOfRows");
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return rows;
    }
    
    public List<cartBean> getCartByNo(int cus_id, int cart_no) {
        List<cartBean> cart = new ArrayList<cartBean>();
        cartBean cartitem;
        
        try {
            connection = connectionDAO.getConnection();
            getCartByNo = connection.prepareStatement("select * from cart where customer_id=? and cart_no=?");
            
            getCartByNo.setInt(1, cus_id);
            getCartByNo.setInt(2, cart_no);
            ResultSet rs = getCartByNo.executeQuery();
            
            while (rs.next()) {
                cartitem = new cartBean();
                
                cartitem.setCart_id(rs.getInt("cart_id"));
                cartitem.setCart_no(rs.getInt("cart_no"));
                cartitem.setName(rs.getString("item_name"));
                cartitem.setPrice(rs.getInt("item_price"));
                cartitem.setQuantity(rs.getInt("item_quantity"));
                cartitem.setCart_status(rs.getString("cart_status"));
                cartitem.setCustomer_id(rs.getInt("customer_id"));
                
                cart.add(cartitem);
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return cart;
    }
    
}
