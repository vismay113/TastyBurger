/*
 * This is the customer business object. It performs all the operations related to customers..
 */
package com.tastyBurger.BO;

import com.tastyBurger.DAO.customerDAO;
import com.tastyBurger.bean.loginBean;
import com.tastyBurger.bean.customerBean;
import java.sql.SQLException;
import java.util.List;
import java.util.Random;

/**
 *
 * @author VBlue
 */
public class customerBO {
    
    customerDAO cusOperations = new customerDAO();
    
    public int addCustomer (customerBean customer) {
        
        int flag = cusOperations.getEmail(customer.getEmail());
        
        if (flag == 0) {
            int addCus = cusOperations.addCustomer(customer);
        
            return addCus;
        } else {
            return flag;
        }
    }
    
    public int randomNumber() throws Exception {
		
	// create random object
	Random randomNumber = new Random();
	 
	// check next int value  
	int code = randomNumber.nextInt(10000);
	System.out.println("Code value: " + code);
	return code;
    }
    
    public int setCode(int code, String email) throws SQLException, Exception {
	
        int j = cusOperations.setCode(code, email);
        return j;
    }
    
    public loginBean getLbean(String email) {
        loginBean lbean = cusOperations.login(email);
        return lbean;
    }
    
    public int login(String email, String password) {
        loginBean lbean = getLbean(email);
        int flag;
        
        if (lbean == null) {
            flag = 1;
        } else if (password.equals(lbean.getPassword())) {
            if (lbean.getCode() != 0) {
                flag = 2;
            } else {
                if (null == lbean.getRole()) {
                    flag = 7;
                } else switch (lbean.getRole()) {
                    case "a":
                        flag = 5;
                        break;
                    case "e":
                        flag = 4;
                        break;
                    default:
                        flag = 3;
                        break;
                }
            }
        } else {
            flag = 6;
        }
        
        return flag;
    }
    
    public int firstLogin(String email, String code) {
        String DBcode = cusOperations.getCode(email);
        int result;
        
        if (code.equals(DBcode)) {
            result = cusOperations.setRole(email, "c");
            
            if (result > 0) {
                return 0;
            } else {
                return 1;
            }
        } else {
            return 2;
        }
    }
    
    public customerBean getUser(String email) {
        
        customerBean user = cusOperations.getUser(email);
        return user;
    }
    
    public int updateProfileInfo(customerBean cus, int id) {
        
        int flag = cusOperations.getEmail(cus.getEmail());
        
        if (flag == 0) {
            int result = cusOperations.updateProfileInfo(cus, id);
            return result;
        } else {
            return flag;
        }
    }
    
    public int updateProfileInfoForOld(customerBean cus, int id) {
        
        int result = cusOperations.updateProfileInfo(cus, id);
        return result;
    }
    
    public List<customerBean> getAllUsers() {
        List<customerBean> users = cusOperations.getAllUsers();
        return users;
    }
    
}
