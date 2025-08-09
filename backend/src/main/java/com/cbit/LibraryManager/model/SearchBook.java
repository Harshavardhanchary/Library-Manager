package com.cbit.LibraryManager.model;

public class SearchBook {
	private int bid;
	private String bname;  // ADD THIS
	private String bauthor; // ADD THIS
	private String bcategory; // ADD THIS
	private int rid; // ADD THIS
	private boolean available; // ADD THIS

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	// ADD GETTERS AND SETTERS FOR THE NEW FIELDS
	public String getBname() { return bname; }
	public void setBname(String bname) { this.bname = bname; }
	
	public String getBauthor() { return bauthor; }
	public void setBauthor(String bauthor) { this.bauthor = bauthor; }
	
	public String getBcategory() { return bcategory; }
	public void setBcategory(String bcategory) { this.bcategory = bcategory; }
	
	public int getRid() { return rid; }
	public void setRid(int rid) { this.rid = rid; }
	
	public boolean isAvailable() { return available; }
	public void setAvailable(boolean available) { this.available = available; }

	public SearchBook(int bid) {
		super();
		this.bid = bid;
	}

	@Override
	public String toString() {
		return "SearchBook [bid=" + bid + "]";
	}

	public SearchBook() {
		super();
	}
}