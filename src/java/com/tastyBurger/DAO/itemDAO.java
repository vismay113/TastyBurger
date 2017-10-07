/*
 * This is item database access class. This class connects to item table in the database.
 */
package com.tastyBurger.DAO;

import com.tastyBurger.bean.itemBean;
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
public class itemDAO {
    
    private Connection connection;
    private PreparedStatement getItems;
    
    public List<itemBean> getItems() {
        List<itemBean> items = new ArrayList<itemBean>();
        itemBean item;
        
        try {
            connection = connectionDAO.getConnection();
            getItems = connection.prepareStatement("select * from item");
            
            ResultSet rs = getItems.executeQuery();
            while (rs.next()) {
                item = new itemBean();
                
                item.setItem_id(rs.getInt("item_id"));
                item.setCategory_name(rs.getString("category_name"));
                item.setName(rs.getString("item_name"));
                item.setPrice(rs.getString("price"));
                item.setIngredients(rs.getString("ingredients"));
                
                items.add(item);
            }
        } catch (SQLException ex) {
            Logger.getLogger(customerDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connectionDAO.closeConnection(connection);
        }
        return items;
    }
    
}
