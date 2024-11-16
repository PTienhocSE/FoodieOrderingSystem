/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author phuct
 */
public class WithdrawalRequest {

    private int id;
    private int shopId;
    private double requestedAmount;
    private Date requestDate;
    private String status;
    private String bankAccount;
    private String bankName;

    public WithdrawalRequest() {
    }

    public WithdrawalRequest( int shopId, double requestedAmount, Date requestDate, String status, String bankAccount, String bankName) {
        this.id = id;
        this.shopId = shopId;
        this.requestedAmount = requestedAmount;
        this.requestDate = requestDate;
        this.status = status;
        this.bankAccount = bankAccount;
        this.bankName = bankName;
    }

    public WithdrawalRequest(int id, int shopId, double requestedAmount, Date requestDate, String status, String bankAccount, String bankName) {
        this.id = id;
        this.shopId = shopId;
        this.requestedAmount = requestedAmount;
        this.requestDate = requestDate;
        this.status = status;
        this.bankAccount = bankAccount;
        this.bankName = bankName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getShopId() {
        return shopId;
    }

    public void setShopId(int shopId) {
        this.shopId = shopId;
    }

    public double getRequestedAmount() {
        return requestedAmount;
    }

    public void setRequestedAmount(double requestedAmount) {
        this.requestedAmount = requestedAmount;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

}
