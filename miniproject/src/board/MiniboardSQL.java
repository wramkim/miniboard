package board;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import common.DB;
import common.Global;

public class MiniboardSQL extends Global {

	public SimpleDateFormat sdf = new SimpleDateFormat();

	public MiniboardSQL() {
		CN = DB.getConnection();
	}

	public boolean loginCheck(String uid, String pwd) throws Exception {

		// uid와 pwd 유효성 체크 필요

		qry = "select count(*) as cnt from miniboard_member where id = ? and pwd = ?";
		PST = CN.prepareStatement(qry);
		PST.setString(1, uid);
		PST.setString(2, pwd);
		RS = PST.executeQuery();
		RS.next();
		if (RS.getInt(1) == 1)
			return true;
		else
			return false;
	}

	public int getTotal(String bid) throws Exception {
		String boardName = "miniboard_" + bid;

		qry = "select count(*) from " + boardName;
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);

		RS.next();

		return RS.getInt(1);
	}

	public int getSearchedTotal(String bid, String keyfield, String keyword) throws Exception {
		String boardName = "miniboard_" + bid;

		qry = "select count(*) from " + boardName + " where " + keyfield + " like " + "'%" + keyword + "%'";
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);

		RS.next();

		return RS.getInt(1);
	}
	
	public ArticleDTO getNotice() throws Exception {
		
		ArticleDTO dto = new ArticleDTO();
		
		qry = "select t.*, to_char(t.wdate,'yyyy/mm/dd hh24:mi:ss') as wdate2 from miniboard_notice t";
		
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);
		
		RS.next();
		
		dto.setNum(RS.getInt("num"));
		dto.setWid(RS.getString("wid"));
		dto.setWname(RS.getString("wname"));
		dto.setTitle(RS.getString("title"));
		dto.setContent(RS.getString("content"));
		dto.setAttatch(RS.getString("attatch"));
		dto.setWdate(RS.getString("wdate2"));
		
		return dto;
		
	}

	public ArticleDTO getArticle(String bid, int num, String hit) throws Exception {

		String boardName = "miniboard_" + bid;

		ArticleDTO dto = new ArticleDTO();
		qry = "select t.*, to_char(wdate,'yyyy/mm/dd hh24:mi:ss') as wdate2 from " + boardName + " t where num = "
				+ num;
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);

		RS.next();

		int hitcnt = RS.getInt("hit");

		// 조회수 증가
		if (hit.equals("true")) {
			qry = "update " + boardName + " set hit = ? where num = ?";
			PST = CN.prepareStatement(qry);
			hitcnt++;
			PST.setInt(1, hitcnt);
			PST.setInt(2, num);
			PST.executeUpdate();
		}

		// num, wid, wname, title, content, attatch, wdate, hit
		dto.setNum(num);
		dto.setWid(RS.getString("wid"));
		dto.setWname(RS.getString("wname"));
		dto.setTitle(RS.getString("title"));
		dto.setContent(RS.getString("content"));
		dto.setAttatch(RS.getString("attatch"));
		dto.setWdate(RS.getString("wdate2"));
		dto.setHit(hitcnt);

		return dto;
	}

	public ArrayList<ReplyDTO> getReply(String bid, int anum, int sup, int step) throws Exception {

		ArrayList<ReplyDTO> list = new ArrayList<ReplyDTO>();

		String boardName = "miniboard_" + bid + "_reply";
		qry = "select t.*, to_char(wdate,'yyyy/mm/dd hh24:mi:ss') as wdate2 from " + boardName
				+ " t where anum = ? and sup = ? and step = ?";
		PST = CN.prepareStatement(qry);

		PST.setInt(1, anum);
		PST.setInt(2, sup);
		PST.setInt(3, step);

		RS = PST.executeQuery();
		// num, anum, wid, content, sup, step, wdate
		while (RS.next()) {
			ReplyDTO dto = new ReplyDTO();

			dto.setNum(RS.getInt("num"));
			dto.setAnum(anum);
			dto.setWid(RS.getString("wid"));
			dto.setContent(RS.getString("content"));
			dto.setSup(sup);
			dto.setStep(step);
			dto.setWdate(RS.getString("wdate2"));

			list.add(dto);
		}

		return list;

	}

	public ArrayList<ArticleDTO> getList(String bid, int page, String keyfield, String keyword, int start, int end)
			throws Exception {

		ArrayList<ArticleDTO> list = new ArrayList<ArticleDTO>();
		String boardName = "miniboard_" + bid;
		qry = "select num, wname, wid, title, to_char(wdate,'yyyy/mm/dd hh24:mi:ss') as wdate2, hit, rcnt, attatch from (select rownum rn, g.*, (select count(*) from "
				+ boardName + "_reply r where g.num = r.anum) as rcnt from (select * from " + boardName + " where "
				+ keyfield + " like " + "'%" + keyword + "%' order by wdate desc) g) where rn between " + start
				+ " and " + end;

		ST = CN.createStatement();
		RS = ST.executeQuery(qry);

		while (RS.next()) {
			ArticleDTO dto = new ArticleDTO();
			dto.setAttatch(RS.getString("attatch"));
			dto.setNum(RS.getInt("num"));
			dto.setWname(RS.getString("wname"));
			dto.setWid(RS.getString("wid"));
			dto.setTitle(RS.getString("title"));
			dto.setWdate(RS.getString("wdate2"));
			dto.setHit(RS.getInt("hit"));
			dto.setRcnt(RS.getInt("rcnt"));

			list.add(dto);
		}

		return list;

	}

	public void insertArticle(String bid, ArticleDTO dto) throws SQLException {
		// num, wid, wname, title, content, attatch, wdate, hit
		qry = "insert into miniboard_" + bid + " values (miniboard_" + bid + "_seq.nextval, ?, ?, ?, ?, ?, sysdate, 0)";
		
		PST = CN.prepareStatement(qry);

		PST.setString(1, dto.getWid());
		PST.setString(2, dto.getWname());
		PST.setString(3, dto.getTitle());
		PST.setString(4, dto.getContent());
		PST.setString(5, dto.getAttatch());

		PST.executeUpdate();

	}

	public void updateArticle(String bid, ArticleDTO dto, int num) throws SQLException {
		// num, wid, wname, title, content, attatch, wdate, hit
		qry = "update miniboard_" + bid + " set title = ?, content = ? where num = ?";
		
		PST = CN.prepareStatement(qry);

		PST.setString(1, dto.getTitle());
		PST.setString(2, dto.getContent());
		PST.setInt(3, num);

		PST.executeUpdate();

	}

	public void deleteArticle(String bid, int num) throws Exception {
		qry = "delete from miniboard_" + bid + " where num = ?";
		
		PST = CN.prepareStatement(qry);

		PST.setInt(1, num);

		PST.executeUpdate();

	}

	public void modifyReply(String bid, ReplyDTO dto) throws Exception {
		// num, anum, wid, content, sup, step, wdate
		qry = "update miniboard_" + bid + "_reply set content=? where num = ?";
		
		PST = CN.prepareStatement(qry);

		PST.setString(1, dto.getContent());
		PST.setInt(2, dto.getNum());

		PST.executeUpdate();

	}

	public void deleteReply(String bid, int num) throws Exception {
		qry = "delete from miniboard_" + bid + "_reply where num = ?";
		
		PST = CN.prepareStatement(qry);

		PST.setInt(1, num);

		PST.executeUpdate();

	}

	public void insertReply(String bid, ReplyDTO dto) throws Exception {
		// num, anum, wid, content, sup, step, wdate
		qry = "insert into miniboard_" + bid + "_reply values (miniboard_" + bid
				+ "_reply_seq.nextval, ?, ?, ?, ?, ?, sysdate)";
		
		PST = CN.prepareStatement(qry);

		PST.setInt(1, dto.getAnum());
		PST.setString(2, dto.getWid());
		PST.setString(3, dto.getContent());
		PST.setInt(4, dto.getSup());
		PST.setInt(5, dto.getStep());

		PST.executeUpdate();

	}

	public void insertBoard(BoardsDTO dto) throws Exception {

		// 설정에 넣기
		qry = "insert into miniboard_config values(?,?,?,?,?,?)";
		PST = CN.prepareStatement(qry);

		PST.setInt(1, dto.getNum());
		PST.setString(2, dto.getBid());
		PST.setString(3, dto.getBname());
		PST.setString(4, dto.getBdesc());
		PST.setInt(5, dto.getWlevel());
		PST.setInt(6, dto.getInlist());

		PST.executeUpdate();

		// 게시판 테이블 생성
		String boardName = "miniboard_" + dto.getBid();

		qry = "create table " + boardName + " as select * from miniboard_default where 1=2";
		
		ST = CN.createStatement();
		ST.executeUpdate(qry);

		// 게시판 시퀀스 생성

		qry = "create sequence " + boardName + "_seq";
		
		ST = CN.createStatement();
		ST.executeUpdate(qry);

		// 댓글 테이블 생성
		qry = "create table " + boardName + "_reply as select * from miniboard_default_reply where 1=2";
		
		ST = CN.createStatement();
		ST.executeUpdate(qry);

		// 댓글 시퀀스 생성

		qry = "create sequence " + boardName + "_reply_seq";
		
		ST = CN.createStatement();
		ST.executeUpdate(qry);
	}

	public void updateBoard(BoardsDTO dto) throws Exception {

		qry = "update miniboard_config set bname=?, bdesc=?, wlevel=?, inlist=? where bid=?";
		PST = CN.prepareStatement(qry);

		PST.setString(1, dto.getBname());
		PST.setString(2, dto.getBdesc());
		PST.setInt(3, dto.getWlevel());
		PST.setInt(4, dto.getInlist());
		PST.setString(5, dto.getBid());

		PST.executeUpdate();
	}

	public void deleteBoard(String bid) throws Exception {

		String boardName = "miniboard_" + bid;

		qry = "delete from miniboard_config where bid = ?";
		PST = CN.prepareStatement(qry);
		PST.setString(1, bid);
		PST.executeUpdate();

		// 게시판 테이블 삭제

		qry = "drop table ?";
		PST = CN.prepareStatement(qry);
		PST.setString(1, boardName);
		PST.executeUpdate();

		// 게시판 시퀀스 삭제

		qry = "drop sequence " + boardName + "_seq";
		ST = CN.createStatement();
		ST.executeUpdate(qry);

		// 댓글 테이블 삭제
		qry = "drop table ?";
		PST = CN.prepareStatement(qry);
		PST.setString(1, boardName + "_reply");
		PST.executeUpdate();

		// 댓글 시퀀스 삭제

		qry = "drop sequence " + boardName + "_reply_seq";
		ST = CN.createStatement();
		ST.executeUpdate(qry);
	}

	public String getBoardName(String bid) throws Exception {

		qry = "select * from miniboard_config where bid ='" + bid + "'";
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);

		RS.next();

		return RS.getString("bname");
	}

	public String getBoardDesc(String bid) throws Exception {

		qry = "select * from miniboard_config where bid ='" + bid + "'";
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);

		RS.next();

		return RS.getString("bdesc");
	}
	
	public int getBoardWlevel(String bid) throws Exception {
		
		qry = "select * from miniboard_config where bid ='" + bid + "'";
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);

		RS.next();

		return RS.getInt("wlevel");
	}

	public ArrayList<BoardsDTO> getBoards() throws Exception {

		ArrayList<BoardsDTO> list = new ArrayList<BoardsDTO>();

		qry = "select * from miniboard_config order by num";
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);

		while (RS.next()) {
			BoardsDTO dto = new BoardsDTO();

			dto.setNum(RS.getInt("num"));
			dto.setBid(RS.getString("bid"));
			dto.setBname(RS.getString("bname"));
			dto.setBdesc(RS.getString("bdesc"));
			dto.setWlevel(RS.getInt("wlevel"));
			dto.setInlist(RS.getInt("inlist"));

			list.add(dto);
		}

		return list;

	}

	public MemberDTO getMember(String uid) throws Exception {

		qry = "select m.*, to_char(m.jdate,'yyyy/mm/dd hh24:mi:ss') as jdate2 from miniboard_member m where id = ?";
		System.out.println(qry + ", " + uid);
		PST = CN.prepareStatement(qry);
		PST.setString(1, uid);
		RS = PST.executeQuery();
		RS.next();

		// id, pwd, name, email, zipcode, address1, address2, profile, jdate, lev
		MemberDTO dto = new MemberDTO();
		dto.setId(RS.getString("id"));
		dto.setPwd(RS.getString("pwd"));
		dto.setName(RS.getString("name"));
		dto.setEmail(RS.getString("email"));
		dto.setZipcode(RS.getString("zipcode"));
		dto.setAddress1(RS.getString("address1"));
		dto.setAddress2(RS.getString("address2"));
		dto.setProfile(RS.getString("profile"));
		dto.setJdate(RS.getString("jdate2"));
		dto.setLevel(RS.getInt("lev"));

		return dto;

	}

	public void createMember(MemberDTO dto) throws Exception {
		// id, pwd, name, email, zipcode, address1, address2, profile, jdate, lev
		qry = "insert into miniboard_member values(?, ?, ?, ?, ?, ?, ?, ?, sysdate, 2)";


		PST = CN.prepareStatement(qry);
		PST.setString(1, dto.getId());
		PST.setString(2, dto.getPwd());
		PST.setString(3, dto.getName());
		PST.setString(4, dto.getEmail());
		PST.setString(5, dto.getZipcode());
		PST.setString(6, dto.getAddress1());
		PST.setString(7, dto.getAddress2());
		PST.setString(8, dto.getProfile());
		PST.executeUpdate();
	}

	public boolean checkBID(String bid) throws Exception {

		qry = "select count(*) as cnt from miniboard_config where bid = '" + bid + "'";
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);

		RS.next();
		if (RS.getInt("cnt") == 0) {
			return true;
		} else
			return false;
	}
	
public ArrayList<ArticleDTO> getRecentArticles() throws Exception {
		
		ArrayList<ArticleDTO> list = new ArrayList<ArticleDTO>();
		
		MiniboardSQL ms = new MiniboardSQL();
		
		ArrayList<BoardsDTO> blist = ms.getBoards();
		
		qry = "select g.bid, g.num, g.title, g.rcnt, to_char(g.wdate,'yyyy/mm/dd hh24:mi:ss') as wdate2, g.wid from (" + 
				"select rownum rn, u.* from (" + 
				"select  s.* from (";
		
		for (int i=0;i<blist.size();i++) {
			BoardsDTO bdto = blist.get(i);
			 //select t.*, 'qna' as bid, (select count(*) from miniboard_qna_reply r where r.anum = t.num) as rcnt from miniboard_qna t where wid = 'admin'
			qry += "select t.*, '"+bdto.getBid()+"' as bid, (select count(*) from miniboard_"+bdto.getBid()+"_reply r where r.anum = t.num) as rcnt from miniboard_"+bdto.getBid()+" t ";
			if (i < blist.size()-1)
				qry += "union ";
		}
		
		qry += ") s order by s.wdate desc) u" + 
				") g where rn < 15";
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);
		
		while (RS.next()) {
			ArticleDTO dto = new ArticleDTO();
			dto.setBid(RS.getString("bid"));
			dto.setWid(RS.getString("wid"));
			dto.setWdate(RS.getString("wdate2"));
			dto.setNum(RS.getInt("num"));
			dto.setTitle(RS.getString("title"));
			dto.setRcnt(RS.getInt("rcnt"));
			
			list.add(dto);
		}
		return list;
	}
	
	public ArrayList<ArticleDTO> getRecentArticles(String uid) throws Exception {
		
		ArrayList<ArticleDTO> list = new ArrayList<ArticleDTO>();
		
		MiniboardSQL ms = new MiniboardSQL();
		
		ArrayList<BoardsDTO> blist = ms.getBoards();
		
		qry = "select g.bid, g.num, g.title, g.rcnt from (" + 
				"select rownum rn, u.* from (" + 
				"select  s.* from (";
		
		for (int i=0;i<blist.size();i++) {
			BoardsDTO bdto = blist.get(i);
			 //select t.*, 'qna' as bid, (select count(*) from miniboard_qna_reply r where r.anum = t.num) as rcnt from miniboard_qna t where wid = 'admin'
			qry += "select t.*, '"+bdto.getBid()+"' as bid, (select count(*) from miniboard_"+bdto.getBid()+"_reply r where r.anum = t.num) as rcnt from miniboard_"+bdto.getBid()+" t where wid = '"+uid+"' ";
			if (i < blist.size()-1)
				qry += "union ";
		}
		
		qry += ") s order by s.wdate desc) u" + 
				") g where rn < 10";
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);
		
		while (RS.next()) {
			ArticleDTO dto = new ArticleDTO();
			dto.setWid(RS.getString("bid"));
			dto.setNum(RS.getInt("num"));
			dto.setTitle(RS.getString("title"));
			dto.setRcnt(RS.getInt("rcnt"));
			list.add(dto);
		}
		return list;
	}
	public boolean checkID(String uid) throws Exception {

		qry = "select count(*) as cnt from miniboard_member where id = '" + uid + "'";
		ST = CN.createStatement();
		RS = ST.executeQuery(qry);

		RS.next();
		if (RS.getInt("cnt") == 0) {
			return true;
		} else
			return false;
	}
}
