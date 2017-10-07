/*
 * This is order database access class. This class connects to customer table in the database.
 */
package com.tastyBurger.DAO;

import com.tastyBurger.bean.loginBean;
import com.tastyBurger.bean.customerBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VBlue
 */
public class customerDAO {
    
    private Connection connection;
    private PreparedStatement insertCustomer = null;
    private PreparedStatement setCode = null;
    private PreparedStatement loginDetails = null;
    private PreparedStatement getCode = null;
    private PreparedStatement allUsers = null;
    private PreparedStatement specificUser = null;
    private PreparedStatement getID = null;
    private PreparedStatement updateProfile = null;
    private PreparedStatement setRole = null;
    private PreparedStatement deleteCode = null;
    private PreparedStatement getEmails = null;
    
    public int getEmail(String email) {
        List<String> emails = new ArrayList<String>();
        int flag = 0;
        try {
            connection = connectionDAO.getConnection();
            
            getEmails = connection.prepareStatement("select email from customer");
            ResultSet rs = getEmails.executeQuery();
            while (rs.next()) {
                String emailTemp = rs.getString("email");
                emails.add(emailTemp);
            }
            
            for (String e: emails) {
                if (email.equals(e)) {
                    flag = 8;
                    break;
                } else {
                    flag = 0;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return flag;
    }
    
    public int addCustomer (customerBean cus) {
        int updateResult = 0;
        
        try {
            connection = connectionDAO.getConnection();
            
            insertCustomer = connection.prepareStatement("insert into customer(first_name, last_name, address, suburb, postcode, phone, email,                                                                                              password) values(?,?,?,?,?,?,?,?)");
            
            insertCustomer.setString(1, cus.getFname());
            insertCustomer.setString(2, cus.getLname());
            insertCustomer.setString(3, cus.getAddress());
            insertCustomer.setString(4, cus.getSuburb());
            insertCustomer.setString(5, cus.getPostcode());
            insertCustomer.setString(6, cus.getPhoneNumber());
            insertCustomer.setString(7, cus.getEmail());
            insertCustomer.setString(8, cus.getPassword());
            
            updateResult = insertCustomer.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        
        return updateResult;
    }
    
    public int setCode(int code, String email) {
	
	int j = 0;
	try {
            connection = connectionDAO.getConnection();
            
            setCode = connection.prepareStatement("update customer set code=? where email=?");
            
            setCode.setInt(1, code);
            setCode.setString(2, email);
            j = setCode.executeUpdate();
	} catch (SQLException ex) { 
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
    	return j;
    }
    
    public loginBean login(String email) {
        
        loginBean lb = new loginBean();
        ResultSet results = null;
        try {
            connection = connectionDAO.getConnection();
            
            loginDetails = connection.prepareStatement("select customer_id, first_name, email, password, role, code from customer where email=?");
            
            loginDetails.setString(1, email);
            results = loginDetails.executeQuery();
            
            while (results.next()) {
                lb.setId(results.getInt(1));
                lb.setName(results.getString(2));
                lb.setLoginEmail(results.getString(3));
                lb.setPassword(results.getString(4));
                lb.setRole(results.getString(5));
                
                String code = results.getString(6);
                if (code == null) {
                    lb.setCode(0);
                } else {
                    lb.setCode(Integer.parseInt(code));
                }
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return lb;
    }
    
    public String getCode(String email) {
        ResultSet result = null;
        String code = null;
        
        try {
            connection = connectionDAO.getConnection();
            
            getCode = connection.prepareStatement("select code from customer where email=?");
            
            getCode.setString(1, email);
            result = getCode.executeQuery();
            
            while (result.next()) {
                code = result.getString(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return code;
    } 
    
    public List<customerBean> getAllUsers() {
        List<customerBean> users = new ArrayList<customerBean>();
        customerBean user;
        
        try {
            connection = connectionDAO.getConnection();
            
            allUsers = connection.prepareStatement("select * from customer where role='c'");
            
            ResultSet results = allUsers.executeQuery();
            
            while (results.next()) {
                user = new customerBean();
                
                user.setId(results.getInt(1));
                user.setFname(results.getString(2));
                user.setLname(results.getString(3));
                user.setAddress(results.getString(4));
                user.setSuburb(results.getString(5));
                user.setPostcode(results.getString(6));
                user.setPhoneNumber(results.getString(7));
                user.setEmail(results.getString(8));
                user.setPassword(results.getString(9));
                
                users.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        
        return users;
    }
    
    public customerBean getUser(String email) {
        customerBean user = new customerBean();
        
        try {
            connection = connectionDAO.getConnection();
            specificUser = connection.prepareStatement("select * from customer where email=?");
            
            specificUser.setString(1, email);
            ResultSet results = specificUser.executeQuery();
            
            while (results.next()) {
                user.setId(results.getInt(1));
                user.setFname(results.getString(2));
                user.setLname(results.getString(3));
                user.setAddress(results.getString(4));
                user.setSuburb(results.getString(5));
                user.setPostcode(results.getString(6));
                user.setPhoneNumber(results.getString(7));
                user.setEmail(results.getString(8));
                user.setPassword(results.getString(9));
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        
        return user;
    }
    
    public int getID(String oldEmail) {
        int id = 0;
        
        try {
            connection = connectionDAO.getConnection();
            getID = connection.prepareStatement("select customer_id from customer where email=?");
            
            getID.setString(1, oldEmail);
            ResultSet rs = getID.executeQuery();
            
            while (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        
        return id;
    }
    
    public int setRole(String email, String role) {
        
        int result = 0;
        int id = 0;
        ResultSet rs1 = null;
        
        try {
            connection = connectionDAO.getConnection();
            getID = connection.prepareStatement("select customer_id from customer where email=?");
            
            getID.setString(1, email);
            
            rs1 = getID.executeQuery();
            
            while (rs1.next()) {
                id = rs1.getInt(1);
            }
            
            setRole = connection.prepareStatement("update customer set role=? where email=?");
            
            setRole.setString(1, role);
            setRole.setString(2, email);
            
            result = setRole.executeUpdate();
            
            if (result > 0) {
                deleteCode = connection.prepareStatement("update customer set code=null where customer_id=?");
                
                deleteCode.setInt(1, id);
                deleteCode.execute();
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        
        return result;
    }
    
    public int updateProfileInfo(customerBean cus, int id) {
        
        int result = 0;
        
        try {
            connection = connectionDAO.getConnection();
            updateProfile = connection.prepareStatement("update customer set first_name=?, last_name=?, address=?, suburb=?, postcode=?, phone=?,                                                                                                   email=? where customer_id=?");
            
            updateProfile.setString(1, cus.getFname());
            updateProfile.setString(2, cus.getLname());
            updateProfile.setString(3, cus.getAddress());
            updateProfile.setString(4, cus.getSuburb());
            updateProfile.setString(5, cus.getPostcode());
            updateProfile.setString(6, cus.getPhoneNumber());
            updateProfile.setString(7, cus.getEmail());
            updateProfile.setInt(8, id);
            
            result = updateProfile.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return result;
    }
   
}
