package hmjm.bean.buy;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.util.List;
import hmjm.bean.buy.buyVO;


public class buyDAO {
	public static buyDAO instance = new buyDAO();
	public static buyDAO getInstance() {
		return instance;
	}
	private buyDAO() {}
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private Connection getConnection() {
		try {
			Context ctx = new InitialContext();
			Context env = (Context)ctx.lookup("java:comp/env");
			DataSource ds =(DataSource)env.lookup("jdbc/xe");
			conn = ds.getConnection();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public void insertBuy(buyVO vo) {
		try {
			conn = getConnection();
			String sql = "insert into buy values (buy_seq.nextval,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getB_email());
			pstmt.setInt(2, vo.getB_productnumber());
			pstmt.setString(3, vo.getB_classname());
			pstmt.setString(4, vo.getB_place());
			pstmt.setString(5, vo.getB_day());
			pstmt.setString(6, vo.getTutor_id());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
	}
	
	public buyVO getBuy(String b_email)
		throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		buyVO vo = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select * from buy where b_email = ?");
			pstmt.setString(1, b_email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new buyVO();
				vo.setB_num(rs.getInt("b_num"));
				vo.setB_email(rs.getString("b_email"));
				vo.setB_productnumber(rs.getInt("b_productnumber"));
				vo.setB_classname(rs.getString("b_classname"));
				vo.setB_place(rs.getString("b_place"));
				vo.setB_day(rs.getString("b_day"));
			}
	}catch(Exception ex) {
		ex.printStackTrace();
	}finally {
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
	return vo;
	}
	//주문받은거 확인위해
	public buyVO getBuyOrder(String tutor_id)
			throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			buyVO vo = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
						"select * from buy where tutor_id = ?");
				pstmt.setString(1, tutor_id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					vo = new buyVO();
					vo.setB_num(rs.getInt("b_num"));
					vo.setB_email(rs.getString("b_email"));
					vo.setB_productnumber(rs.getInt("b_productnumber"));
					vo.setB_classname(rs.getString("b_classname"));
					vo.setB_place(rs.getString("b_place"));
					vo.setB_day(rs.getString("b_day"));
					vo.setTutor_id(rs.getString("tutor_id"));
				}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return vo;
		}
	
	//상품번호로 검색하기 위해
	public buyVO getBuy2(int b_productnumber)
			throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			buyVO vo = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
						"select * from buy where b_productnumber = ?");
				pstmt.setInt(1, b_productnumber);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					vo = new buyVO();
					vo.setB_num(rs.getInt("b_num"));
					vo.setB_email(rs.getString("b_email"));
					vo.setB_productnumber(rs.getInt("b_productnumber"));
					vo.setB_classname(rs.getString("b_classname"));
					vo.setB_place(rs.getString("b_place"));
					vo.setB_day(rs.getString("b_day"));
				}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return vo;
		}
	//구매번호와 아이디 일치로 구매한 수업인지 구분하기 위해
	public buyVO getBuy3(String id, int num)
			throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			buyVO vo = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
						"select * from buy where b_email=? and b_productnumber = ?");
				pstmt.setString(1, id);
				pstmt.setInt(2, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					vo = new buyVO();
					vo.setB_num(rs.getInt("b_num"));
					vo.setB_email(rs.getString("b_email"));
					vo.setB_productnumber(rs.getInt("b_productnumber"));
					vo.setB_classname(rs.getString("b_classname"));
					vo.setB_place(rs.getString("b_place"));
					vo.setB_day(rs.getString("b_day"));
				}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return vo;
		}
	////저장된 구매 수 얻어냄//kunhoon
	public int buyCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x=0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from buy");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); //0번아니고 1번부터 시작
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x; 
	}
//개인 구매 카운팅 위해	
	public int buyCount2(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x=0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from buy where b_email=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); //0번아니고 1번부터 시작
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x; 
	}
	//신청받은 수 카운팅 위해서
		public int buyCount3(String id) throws Exception {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int x=0;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement("select count(*) from buy where tutor_id=?");
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					x= rs.getInt(1); //0번아니고 1번부터 시작
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				if (rs != null) try { rs.close(); } catch(SQLException ex) {}
				if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
				if (conn != null) try { conn.close(); } catch(SQLException ex) {}
			}
			return x; 
		}
	
	//구매리스트 위해 kunhoon
	public List getBuyList(String email, int start, int end)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List productbuyList= null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
				"select b_num,b_email,b_productnumber,b_classname,b_place,b_day,r"
				+ " from(select b_num,b_email,b_productnumber,b_classname,b_place,b_day,rownum r"
				+ " from(select * from buy where b_email =? order by b_num)"
				+ " order by b_num) where r>=? and r<=? ");
			pstmt.setString(1, email);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				productbuyList = new ArrayList(end);
				do {
					buyVO vo = new buyVO();
					vo.setB_num(rs.getInt("b_num"));
					vo.setB_email(rs.getString("b_email"));
					vo.setB_productnumber(rs.getInt("b_productnumber"));
					vo.setB_classname(rs.getString("b_classname"));
					vo.setB_place(rs.getString("b_place"));
					vo.setB_day(rs.getString("b_day"));
					productbuyList.add(vo);
				}while(rs.next());
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
					
		return productbuyList;		
					
		}
	
	
//주문리스트 위해??테스트중 kunhoon
	public List getBuyOrderList(String email, int start, int end)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List orderList= null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
				"select b_num,b_email,b_productnumber,b_classname,b_place,b_day,tutor_id,r"
				+ " from(select b_num,b_email,b_productnumber,b_classname,b_place,b_day,tutor_id,rownum r"
				+ " from(select * from buy where tutor_id =? order by b_num)"
				+ " order by b_num) where r>=? and r<=? ");
			pstmt.setString(1, email);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				orderList = new ArrayList(end);
				do {
					buyVO vo = new buyVO();
					vo.setB_num(rs.getInt("b_num"));
					vo.setB_email(rs.getString("b_email"));
					vo.setB_productnumber(rs.getInt("b_productnumber"));
					vo.setB_classname(rs.getString("b_classname"));
					vo.setB_place(rs.getString("b_place"));
					vo.setB_day(rs.getString("b_day"));
					vo.setTutor_id(rs.getString("tutor_id"));
					orderList.add(vo);
				}while(rs.next());
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
					
		return orderList;		
					
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

