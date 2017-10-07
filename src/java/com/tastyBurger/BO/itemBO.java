/*
 * This is the item business object. It performs all the operations related to item information.
 */
package com.tastyBurger.BO;

import com.tastyBurger.DAO.itemDAO;
import com.tastyBurger.bean.itemBean;
import java.util.List;

/**
 *
 * @author VBlue
 */
public class itemBO {
    
    itemDAO itemOps = new itemDAO();
    
    public List<itemBean> getItems() {
        List<itemBean> items = itemOps.getItems();
        return items;
    }
}
