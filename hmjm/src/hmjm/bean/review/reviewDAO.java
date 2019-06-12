package hmjm.bean.review;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import java.util.*; 
import hmjm.bean.review.reviewVO;

public class reviewDAO {
	private static reviewDAO instance = new reviewDAO();
	public static reviewDAO getInstance() { return instance; }
	private reviewDAO() {}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/xe");
		return ds.getConnection();
	}
	
	public void insertArticle(reviewVO article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int number=0;
		String sql="";
		try {
			conn = getConnection(); 
			pstmt = conn.prepareStatement("select max(r_num) from review");
			rs = pstmt.executeQuery();
			if (rs.next()) 
				number=rs.getInt(1)+1;	
			else
				number=1; 
			sql = "insert into review(r_num, r_name, r_s_curr, r_s_pre, r_s_tk, r_s_deli, r_s_kind, r_re, r_reg, pr_num) "
					+ "values(review_seq.NEXTVAL,?,?,?,?,?,?,?,sysdate,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getR_name());
			pstmt.setInt(2, article.getR_s_curr());
			pstmt.setInt(3, article.getR_s_pre());
			pstmt.setInt(4, article.getR_s_tk());
			pstmt.setInt(5, article.getR_s_deli());
			pstmt.setInt(6, article.getR_s_kind());
			pstmt.setString(7, article.getR_re());
			pstmt.setInt(8, article.getPr_num());
			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
	}
	
	public int getArticleCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x=0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from review");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); //첫번째 컬럼 값
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

	public List getArticles(int prnum, int start, int end) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList=null;
		try {
			conn = getConnection();
/*
			pstmt = conn.prepareStatement(
					" select r_num,r_name,r_s_curr,r_s_pre,r_s_tk,r_s_deli,r_s_kind,r_re,r_reg, pr_num, r "+
					" from (select r_num,r_name,r_s_curr,r_s_pre,r_s_tk,r_s_deli,r_s_kind,r_re,r_reg,pr_num,rownum r " +
					" from (select r_num,r_name,r_s_curr,r_s_pre,r_s_tk,r_s_deli,r_s_kind,r_re,r_reg,pr_num " +
					" from review order by r_reg desc) order by r_reg desc) where r >= ? and r <= ? ");
					pstmt.setInt(1, start); 
					pstmt.setInt(2, end); 
*/
			pstmt = conn.prepareStatement(
					" select r_num,r_name,r_s_curr,r_s_pre,r_s_tk,r_s_deli,r_s_kind,r_re,r_reg,pr_num,r "
					+ " from (select r_num,r_name,r_s_curr,r_s_pre,r_s_tk,r_s_deli,r_s_kind,r_re,r_reg,pr_num,rownum r "
					+ " from (select * from review where pr_num=? order by r_reg desc)"
					+ " order by r_reg desc) where r>=? and r<=? ");
			pstmt.setInt(1, prnum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
					articleList = new ArrayList(end); 
					do{ 
						reviewVO article= new reviewVO();
						article.setR_num(rs.getInt("r_num"));
						article.setR_name(rs.getString("r_name"));
						article.setR_s_curr(rs.getInt("r_s_curr"));
						article.setR_s_pre(rs.getInt("r_s_pre"));
						article.setR_s_tk(rs.getInt("r_s_tk"));
						article.setR_s_deli(rs.getInt("r_s_deli"));
						article.setR_s_kind(rs.getInt("r_s_kind"));
						article.setR_re(rs.getString("r_re"));
						article.setR_reg(rs.getTimestamp("r_reg"));
						article.setPr_num(rs.getInt("pr_num"));
						articleList.add(article); 
					}while(rs.next());
				}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return articleList;
	}
	
	public reviewVO getArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		reviewVO article=null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from review where r_num = ?"); 
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new reviewVO();
				article.setR_num(rs.getInt("r_num"));
				article.setR_name(rs.getString("r_name"));
				article.setR_s_curr(rs.getInt("r_s_curr"));
				article.setR_s_pre(rs.getInt("r_s_pre"));
				article.setR_s_tk(rs.getInt("r_s_tk"));
				article.setR_s_deli(rs.getInt("r_s_deli"));
				article.setR_s_kind(rs.getInt("r_s_kind"));
				article.setR_re(rs.getString("r_re"));
				article.setR_reg(rs.getTimestamp("r_reg"));
				article.setPr_num(rs.getInt("pr_num"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return article;
	}
	
	public reviewVO updateGetArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		reviewVO article=null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from review where r_num = ?"); 
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new reviewVO();
				article.setR_num(rs.getInt("r_num"));
				article.setR_name(rs.getString("r_name"));
				article.setR_s_curr(rs.getInt("r_s_curr"));
				article.setR_s_pre(rs.getInt("r_s_pre"));
				article.setR_s_tk(rs.getInt("r_s_tk"));
				article.setR_s_deli(rs.getInt("r_s_deli"));
				article.setR_s_kind(rs.getInt("r_s_kind"));
				article.setR_re(rs.getString("r_re"));
				article.setR_reg(rs.getTimestamp("r_reg"));
				article.setPr_num(rs.getInt("pr_num"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return article;
	}

	public int updateArticle(reviewVO article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		String sql="";
		int x=-1;
		try {
			conn = getConnection();
			sql="update review set r_re=?, r_s_curr=?, r_s_pre=?, r_s_tk=?, r_s_deli=?, r_s_kind=? where r_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getR_re());
			pstmt.setInt(2, article.getR_s_curr());
			pstmt.setInt(3, article.getR_s_pre());
			pstmt.setInt(4, article.getR_s_tk());
			pstmt.setInt(5, article.getR_s_deli());
			pstmt.setInt(6, article.getR_s_kind());
			pstmt.setInt(7, article.getR_num());
			pstmt.executeUpdate();
			x= 1;
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}

	public int deleteArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		int x=-1;
		try {
			conn = getConnection();
					pstmt = conn.prepareStatement("delete from review where r_num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x= 1; 
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}
	
	public int checkArticle(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count (*) from review where r_name=?"); 
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				check = rs.getInt(1);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return check;
	}
	
}