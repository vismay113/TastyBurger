/*
 * This is order database access class. This class connects to customer_order and cart table in the database.
 */
package com.tastyBurger.DAO;

import com.tastyBurger.bean.cartBean;
import com.tastyBurger.bean.delivererBean;
import com.tastyBurger.bean.orderBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author natha
 */
public class orderDAO {
    
    private Connection connection;
    private PreparedStatement insertOrder;
    private PreparedStatement createPayment;
    private PreparedStatement getOrderId;
    private PreparedStatement getDeliveryPerson;
    private PreparedStatement setDeliverer;
    private PreparedStatement getNumberOfDrivers;
    private PreparedStatement getCart;
    private PreparedStatement getCartNo;
    private PreparedStatement getAmount;
    private PreparedStatement getOrdersByStatus;
    private PreparedStatement getName;
    private PreparedStatement updateStatus;
    
    public int addOrder(orderBean order) {
        int result = 0;SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
        try {
            connection = connectionDAO.getConnection();
            insertOrder = connection.prepareStatement("insert into customer_order(amount, comment_text, delivery_address, delivery_suburb, delivery_postcode, customer_id, cart_no) values(?,?,?,?,?,?,?)");
            
            insertOrder.setInt(1, order.getAmount());
            insertOrder.setString(2, order.getComment());
            insertOrder.setString(3, order.getDeliveryAddress());
            insertOrder.setString(4, order.getDeliverySuburb());
            insertOrder.setString(5, order.getDeliveryPostcode());
            insertOrder.setInt(6, order.getCustomerId());
            insertOrder.setInt(7, order.getCart_no());
            
            result = insertOrder.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        if (result > 0) {
            int id = getOrderId(order.getCart_no());
            if (id != 0) {
                result = createPayment(order.getAmount(), order.getCustomerId(), id);
            } else {
                result = 0;
            }
        } else {
            result = 0;
        }
        return result;
    }
    
    public int createPayment (int amount, int cus_id, int order_id) {
        int result = 0;
        
        try {
            connection = connectionDAO.getConnection();
            createPayment = connection.prepareStatement("insert into payment(payment_amount, customer_id, order_id) values(?,?,?)");
            
            createPayment.setInt(1, amount);
            createPayment.setInt(2, cus_id);
            createPayment.setInt(3, order_id);
            
            result = createPayment.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return result;
    }
    
    public int getOrderId(int cart_no) {
        int id = 0;
        
        try {
            connection = connectionDAO.getConnection();
            getOrderId = connection.prepareStatement("select order_id from customer_order where cart_no=?");
            
            getOrderId.setInt(1, cart_no);
            
            ResultSet rs = getOrderId.executeQuery();
            
            while (rs.next()) {
                id = rs.getInt("order_id");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return id;
    }
    
    public delivererBean getDeliveryPerson() {
        delivererBean deliverer = new delivererBean();
        
        try {
            connection = connectionDAO.getConnection();
            getDeliveryPerson = connection.prepareStatement("select * from deliverer where deliverer_id=?");
            
            ResultSet rs = getDeliveryPerson.executeQuery();
            while (rs.next()) {
                
                deliverer.setId(rs.getInt("deliverer_id"));
                deliverer.setName(rs.getString("deliverer_name"));
                deliverer.setContactNumber(rs.getString("deliverer_contact_number"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return deliverer;
    }
    
    public int setDeliverer(int cart_no, int deliverer_id) {
        int result = 0;
        int order_id = getOrderId(cart_no);
        
        try {
            connection = connectionDAO.getConnection();
            setDeliverer = connection.prepareStatement("update customer_order set deliverer_id=? where order_id=?");
            setDeliverer.setInt(1, deliverer_id);
            setDeliverer.setInt(2, order_id);
            
            result = setDeliverer.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return result;
    }
    
    public int getNumberOfDrivers() {
        int size = 0;
        
        try {
            connection = connectionDAO.getConnection();
            getNumberOfDrivers = connection.prepareStatement("select count(deliverer_name) as size from deliverer");
            
            ResultSet rs = getNumberOfDrivers.executeQuery();
            while (rs.next()) {
                size = rs.getInt("size");
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return size;
    }
    
    public List<List<cartBean>> getAllOrdersForCustomer(int cus_id) {
        List<cartBean> orderOne;
        List<List<cartBean>> orders = new ArrayList<List<cartBean>>();
        List<Integer> getCartNos = new ArrayList<Integer>();
        cartBean cartitem;
        
        try {
            connection = connectionDAO.getConnection();
            
            getCartNo = connection.prepareStatement("select cart_no from customer_order where customer_id=? and status='delivered'");
            getCartNo.setInt(1, cus_id);
            
            ResultSet rs1 = getCartNo.executeQuery();
            while (rs1.next()) {
                int no = rs1.getInt("cart_no");
                getCartNos.add(no);
            }
            
            getCart = connection.prepareStatement("select * from cart where customer_id=? and cart_no=?");
            for (Integer cartNo : getCartNos) {
                getCart.setInt(1, cus_id);
                getCart.setInt(2, cartNo);

                ResultSet rs = getCart.executeQuery();
                orderOne = new ArrayList<cartBean>();
                while (rs.next()) {
                    cartitem = new cartBean();
                    
                    cartitem.setCart_id(rs.getInt("cart_id"));
                    cartitem.setCart_no(rs.getInt("cart_no"));
                    cartitem.setName(rs.getString("item_name"));
                    cartitem.setPrice(rs.getInt("item_price"));
                    cartitem.setQuantity(rs.getInt("item_quantity"));
                    cartitem.setCart_status(rs.getString("cart_status"));
                    cartitem.setCustomer_id(rs.getInt("customer_id"));
                    
                    orderOne.add(cartitem);
                }
                orders.add(orderOne);
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return orders;
    }
    
    public List<Integer> getAmout(int cus_id) {
        List<Integer> amounts = new ArrayList<Integer>();
        List<Integer> getCartNos = new ArrayList<Integer>();
        try {
            connection = connectionDAO.getConnection();
            
            getCartNo = connection.prepareStatement("select cart_no from customer_order where customer_id=? and status='delivered'");
            getCartNo.setInt(1, cus_id);
            
            ResultSet rs1 = getCartNo.executeQuery();
            while (rs1.next()) {
                int no = rs1.getInt("cart_no");
                getCartNos.add(no);
            }
            
            getAmount = connection.prepareStatement("select amount from customer_order where cart_no=?");
            for (Integer cartNo : getCartNos) {
                
                getAmount.setInt(1, cartNo);
                ResultSet rs2 = getAmount.executeQuery();
                while (rs2.next()) {
                    int amt = ((rs2.getInt("amount"))+3);
                    amounts.add(amt);
                }
            }
            
            getCart = connection.prepareStatement("select * from cart where customer_id=? and cart_no=?");
            getAmount = connection.prepareStatement("select amount from customer_order where cart_no=?");
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return amounts;
    }
    
    public List<orderBean> getOrderByStatus(String status) {
        List<orderBean> orders = new ArrayList<orderBean>();
        orderBean order;
        
        try {
            connection = connectionDAO.getConnection();
            getName = connection.prepareStatement("select first_name, last_name from customer where customer_id=?");
            getOrdersByStatus = connection.prepareStatement("select * from customer_order where status=?");
            getOrdersByStatus.setString(1, status);
            
            ResultSet rs = getOrdersByStatus.executeQuery();
            while (rs.next()) {
                order = new orderBean();
                
                order.setId(rs.getInt("order_id"));
                order.setAmount(rs.getInt("amount")+3);
                order.setStatus(rs.getString("status"));
                order.setComment(rs.getString("comment_text"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setDeliverySuburb(rs.getString("delivery_suburb"));
                order.setDeliveryPostcode(rs.getString("delivery_postcode"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setDelivererId(rs.getInt("deliverer_id"));
                order.setCart_no(rs.getInt("cart_no"));
                
                getName.setInt(1, order.getCustomerId());
                ResultSet rs1 = getName.executeQuery();
                while (rs1.next()) {
                    order.setFname(rs1.getString("first_name"));
                    order.setLname(rs1.getString("last_name"));
                }
                
                orders.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return orders;
    }
    
    public int updateStatus(int order_id, String status) {
        int result = 0;
        
        try {
            connection = connectionDAO.getConnection();
            updateStatus = connection.prepareStatement("update customer_order set status=? where order_id=?");
            updateStatus.setString(1, status);
            updateStatus.setInt(2, order_id);
            
            result = updateStatus.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return result;
    }
}
