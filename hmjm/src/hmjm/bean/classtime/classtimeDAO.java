package hmjm.bean.classtime;
/* 성민 작성  0611*/
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hmjm.bean.product.*;

public class classtimeDAO {
	public static classtimeDAO instance = new classtimeDAO();
	public static classtimeDAO getInstance() {
		return instance;
	}

	private classtimeDAO() {};

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String user="TEAM03", pass="TEAM03";
			String url="jdbc:oracle:thin:@nullmaster.iptime.org:1521:xe";
			conn = DriverManager.getConnection(url,user,pass);	
		}
		catch(Exception e){ e.printStackTrace(); }
		return conn;
	}

	// 상품 등록 2단계) Classtime Table에  정보 삽입
	public void insertClasstime(classtimeVO classtime) {	    
		String sql="";
		try {
			conn = getConnection(); 

			sql = "insert into classtime values(classtime_seq.nextval,?,?,?,?,?,?,?,?,?,?)"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, classtime.getCt_classnum());
			pstmt.setString(2, classtime.getCt_place());
			pstmt.setString(3, classtime.getCt_mon());
			pstmt.setString(4, classtime.getCt_tue());
			pstmt.setString(5, classtime.getCt_wed());
			pstmt.setString(6, classtime.getCt_thu());
			pstmt.setString(7, classtime.getCt_fri());
			pstmt.setString(8, classtime.getCt_sta());
			pstmt.setString(9, classtime.getCt_sun());
			pstmt.setString(10, classtime.getCt_day());

			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
	}


	//수정, TEST-not yet
	public void updateClasstime(classtimeVO vo) {
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update classtime set ct_place=?,ct_mon=?,ct_tue=?,"
					+ "ct_wed=?,ct_thu=?,ct_fri=?,ct_sta=?,ct_sun=?,ct_day=?  where ct_num=?");
			pstmt.setString(1, vo.getCt_place());
			pstmt.setString(2, vo.getCt_mon());
			pstmt.setString(3, vo.getCt_tue());
			pstmt.setString(4, vo.getCt_wed());
			pstmt.setString(5, vo.getCt_thu());
			pstmt.setString(6, vo.getCt_fri());
			pstmt.setString(7, vo.getCt_sta());
			pstmt.setString(8, vo.getCt_sun());
			pstmt.setString(9, vo.getCt_day());
			pstmt.setInt(10, vo.getCt_num());

			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
	}



	//0618.해당지역(번호)로 상품 갯수 알기-성민ok
	public int getRegionCount(String ct_place) {
		int resultCnt =0;
		String sql ="";
		try {
			conn = getConnection(); 

			sql = "select count(*)from classtime where ct_place=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,ct_place);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				resultCnt = rs.getInt(1);	//첫번째 칼럼 값 꺼내기
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
		return resultCnt;

	}
	

	//'xx'지역에서 하는 수업 번호 가져오기 (결과 값은 여러개일것)_성민ok
	public  List<String> getClassNumFromRegin(String ct_place) {
		List<String> classnum = null;

		String sql ="";
		try { 
			conn = getConnection(); 

			sql = "select ct_classnum from classtime where ct_place=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,ct_place);
			rs = pstmt.executeQuery();

			classnum = new ArrayList();
			while(rs.next()) {
				classnum.add(rs.getString(1));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
		return classnum;
	}

	//삭제
	//수정

	//조회 우선 제가 작성할게요 by건훈 
	public classtimeVO getClasstime(int ct_classnum)
			throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		classtimeVO vo = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from classtime where ct_classnum = ?");
			pstmt.setInt(1, ct_classnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo = new classtimeVO();
				vo.setCt_num(rs.getInt("ct_num"));
				vo.setCt_classnum(rs.getInt("ct_classnum"));
				vo.setCt_place(rs.getString("ct_place"));
				vo.setCt_mon(rs.getString("ct_mon"));
				vo.setCt_tue(rs.getString("ct_tue"));
				vo.setCt_wed(rs.getString("ct_wed"));
				vo.setCt_thu(rs.getString("ct_thu"));
				vo.setCt_fri(rs.getString("ct_fri"));
				vo.setCt_sta(rs.getString("ct_sta"));
				vo.setCt_sun(rs.getString("ct_sun"));
				vo.setCt_day(rs.getString("ct_day"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return vo;
	}

}
