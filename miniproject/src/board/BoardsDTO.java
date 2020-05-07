package board;

public class BoardsDTO {
	private int num;
	private String bid;
	private String bname;
	private String bdesc;
	private int wlevel;
	private int inlist;
	
	public int getInlist() {
		return inlist;
	}
	public void setInlist(int inlist) {
		this.inlist = inlist;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getBid() {
		return bid;
	}
	public void setBid(String bid) {
		this.bid = bid;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getBdesc() {
		return bdesc;
	}
	public void setBdesc(String bdesc) {
		this.bdesc = bdesc;
	}
	public int getWlevel() {
		return wlevel;
	}
	public void setWlevel(int wlevel) {
		this.wlevel = wlevel;
	}
}
