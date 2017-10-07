/*
 * This is the deliverer entity class to handle information with deliverer objects.
 */
package com.tastyBurger.bean;

/**
 *
 * @author Heracles
 */
public class delivererBean {
    
    private int id;
    private String name;
    private String contactNumber;

    public delivererBean() {
    }

    public delivererBean(int id, String name, String cNumber) {
        this.id = id;
        this.name = name;
        this.contactNumber = cNumber;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String cNumber) {
        this.contactNumber = cNumber;
    }
    
    
}
