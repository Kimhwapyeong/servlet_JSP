package model2.mvcboard;

import dto.Criteria;

public class PageDto {
	
	int startNo;
	int endNo;
	int realEnd;
	
	boolean prev, next;
	
	int total;
	Criteria criteria;
	
	
	public PageDto(int total, Criteria criteria) {
		this.total = total;
		this.criteria = criteria;
		
		endNo = (int)((Math.ceil(criteria.getPageNo()/10.0)) * 10);
		startNo = endNo - (10 - 1);
		
		realEnd = (int)(Math.ceil((total*1.0)/criteria.getAmount()));
		
		endNo = realEnd > endNo ? endNo : realEnd;
		
		prev = startNo == 1 ? false : true;
		next = endNo == realEnd ? false : true;
	}
	
	
	public PageDto() {
		// TODO Auto-generated constructor stub
	}


	public int getStartNo() {
		return startNo;
	}


	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}


	public int getEndNo() {
		return endNo;
	}


	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}


	public int getRealEnd() {
		return realEnd;
	}


	public void setRealEnd(int realEnd) {
		this.realEnd = realEnd;
	}


	public boolean isPrev() {
		return prev;
	}


	public void setPrev(boolean prev) {
		this.prev = prev;
	}


	public boolean isNext() {
		return next;
	}


	public void setNext(boolean next) {
		this.next = next;
	}


	public int getTotal() {
		return total;
	}


	public void setTotal(int total) {
		this.total = total;
	}


	public Criteria getCriteria() {
		return criteria;
	}


	public void setCriteria(Criteria criteria) {
		this.criteria = criteria;
	}
	
	
}
