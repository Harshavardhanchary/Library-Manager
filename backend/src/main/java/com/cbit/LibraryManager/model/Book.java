package com.cbit.LibraryManager.model;

import java.sql.Date;
import java.util.Objects;

import org.springframework.context.annotation.Scope;
@Scope("prototype")
public class Book {
    private int bid;
    private String bName;
    private String bAuthor;
    private String bCategory;
    private Date idate;
    public Book() {
        super();
    }
    public Book(int bid, String bName, String bCategory, String bAuthor, Date idate) {
        this.bid = bid;
        this.bName = bName;
        this.bAuthor = bAuthor;
        this.bCategory = bCategory;
        this.idate = idate;
    }
 public int getBid() {
        return bid;
    }

    public void setBid(int bid) {

        this.bid = bid;
    }

    public String getbName() {
        return bName;
    }

    public void setbName(String bName) {

        this.bName = bName;
    }

    public String getbCategory() {
        return bCategory;
    }

    public void setbCategory(String bCategory) {
        this.bCategory = bCategory;
    }

    public String getbAuthor() {
        return bAuthor;
    }

    public void setbAuthor(String bAuthor) {
        this.bAuthor = bAuthor;
    }

    public Date getIdate() {
        return idate;
    }

    public void setIdate(Date idate) {
        this.idate = idate;
    }

    @Override
    public String toString() {
        return "Book [bid=" + bid + ", bName=" + bName + ", bCategory=" + bCategory +
               ", bAuthor=" + bAuthor + ", idate=" + idate + "]";
    }
}

