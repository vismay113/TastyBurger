/*
 * This is the payment entity class to handle information with payment objects.
 */
package com.tastyBurger.bean;

/**
 *
 * @author Heracles
 */
public class paymentBean {
    
    private int id;
    private double amount;
    private String date;
    private String method;

    public paymentBean() {
    }

    public paymentBean(int id, double amount, String date, String method) {
        this.id = id;
        this.amount = amount;
        this.date = date;
        this.method = method;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }
    
    
}
