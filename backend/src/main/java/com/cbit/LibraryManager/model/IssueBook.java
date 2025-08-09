package com.cbit.LibraryManager.model;

public class IssueBook {
private int sid;
private int bid;
public IssueBook() {
	super();
	// TODO Auto-generated constructor stub
}
public IssueBook(int sid, int bid) {
	super();
	this.sid = sid;
	this.bid = bid;
}
public int getSid() {
	return sid;
}
public void setSid(int sid) {
	this.sid = sid;
}
public int getBid() {
	return bid;
}
public void setBid(int bid) {
	this.bid = bid;
}
}
