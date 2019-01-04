package com.brw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.brw.dto.ReviewBoardDTO;
import com.brw.dto.UserDTO;

public class DAO {
	
	private static DAO instance;
	DataSource dataSource;
	static String test;
	
	private DAO() {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/oracle_rds");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public static DAO getInstance() {
		if(instance == null) {
			instance = new DAO();
		}
		return instance;
	}
	
	public void createUser(UserDTO user) throws SQLException {
		int result = 0;
		String query = "insert into tempUserTable values(?,?,?,?)";
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		
		try{
			
			connection = dataSource.getConnection();
			pstmt = connection.prepareStatement(query);
			
			connection.setAutoCommit(false);
			
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			
			result = pstmt.executeUpdate();
			
			System.out.println("user create commit()");
			connection.commit();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("user create rollback()");
			connection.rollback();
		} finally {
			pstmt.close();
			connection.close();
			//close 추가
		}
		
		// return result;
	}
	
	public boolean changePwdCheck(Connection con, String userId) {
		boolean result = false;
		String query = "B"
				+ "p"
				+ "";
		
		PreparedStatement pstmt = null;
		

		return true;
	}

	public List<ReviewBoardDTO> reivewPagination(int cPage, int numPerPage) {
		List<ReviewBoardDTO> list = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from (select rownum rnum, r.* from (select * from reviewboard order by rb_no desc) r) where rnum between ? and ?";
		int startRnum = (cPage - 1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, startRnum);
			pstmt.setInt(2, endRnum);
			
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			while(rset.next()) {
				ReviewBoardDTO rb = new ReviewBoardDTO();
				
				rb.setRbNo(rset.getInt("rb_no"));
				rb.setRbTitle(rset.getString("rb_title"));
				rb.setRbWriter(rset.getString("rb_writer"));
				rb.setRbBookTitle(rset.getString("rb_booktitle"));
				rb.setRbContent(rset.getString("rb_content"));
				rb.setRbDate(rset.getDate("rb_date"));
				rb.setRbStarscore(rset.getInt("rb_starscore"));
				rb.setRbReadCnt(rset.getInt("rb_readcnt"));
				rb.setRbRecommend(rset.getInt("rb_recommend"));
				rb.setRbOriginalFilename(rset.getString("rb_original_filename"));
				rb.setRbRenamedFilename(rset.getString("rb_renamed_filename"));
				rb.setRbReport(rset.getInt("rb_report"));
				
				list.add(rb);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				rset.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
		return list;
	}

	public int countReviewAll() {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) from reviewboard order by rb_no desc";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				rset.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}

	public List<ReviewBoardDTO> reivewSearch(String searchType, String searchKeyword, int cPage, int numPerPage) {
		List<ReviewBoardDTO> list = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from (select rownum rnum, r.* from (select * from reviewboard where searchType like '%'||?||'%' order by rb_no desc) r) where rnum between ? and ?";
		query = query.replace("searchType", searchType);
		int startRnum = (cPage - 1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, searchKeyword);
			pstmt.setInt(2, startRnum);
			pstmt.setInt(3, endRnum);
			
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			while(rset.next()) {
				ReviewBoardDTO rb = new ReviewBoardDTO();
				
				rb.setRbNo(rset.getInt("rb_no"));
				rb.setRbTitle(rset.getString("rb_title"));
				rb.setRbWriter(rset.getString("rb_writer"));
				rb.setRbBookTitle(rset.getString("rb_booktitle"));
				rb.setRbContent(rset.getString("rb_content"));
				rb.setRbDate(rset.getDate("rb_date"));
				rb.setRbStarscore(rset.getInt("rb_starscore"));
				rb.setRbReadCnt(rset.getInt("rb_readcnt"));
				rb.setRbRecommend(rset.getInt("rb_recommend"));
				rb.setRbOriginalFilename(rset.getString("rb_original_filename"));
				rb.setRbRenamedFilename(rset.getString("rb_renamed_filename"));
				rb.setRbReport(rset.getInt("rb_report"));
				
				list.add(rb);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				rset.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
		return list;
	}

	public int countReviewSearch(String searchType, String searchKeyword) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) from reviewboard where searchType like '%'||?||'%' order by rb_no desc";
		query = query.replace("searchType", searchType);
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, searchKeyword);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				rset.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	/*광준:최근리뷰 5개 가져오기*/
	public List<ReviewBoardDTO> selectReviewRecentList()
	{
		System.out.println("dao 접속성공");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ReviewBoardDTO> rbList = new ArrayList<>();
		String query = "SELECT * FROM (SELECT * FROM reviewboard ORDER BY rb_date DESC) WHERE rownum < 6";
		
		try {
			System.out.println("쿼리실행시작");
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			System.out.println("쿼리실행완료");
			while(rset.next())
			{
				ReviewBoardDTO rb = new ReviewBoardDTO();
				
				rb.setRbNo(rset.getInt("rb_no"));
				rb.setRbTitle(rset.getString("rb_title"));
				rb.setRbWriter(rset.getString("rb_writer"));
				rb.setRbBookTitle(rset.getString("rb_booktitle"));
				rb.setRbContent(rset.getString("rb_content"));
				rb.setRbDate(rset.getDate("rb_date"));
				rb.setRbStarscore(rset.getInt("rb_starscore"));
				rb.setRbReadCnt(rset.getInt("rb_readcnt"));
				rb.setRbRecommend(rset.getInt("rb_recommend"));
				rb.setRbOriginalFilename(rset.getString("rb_original_filename"));
				rb.setRbRenamedFilename(rset.getString("rb_renamed_filename"));
				rb.setRbReport(rset.getInt("rb_report"));
				System.out.println("데이터"+rset.getString("rb_title"));
				rbList.add(rb);
				
			}
			System.out.println("리스트 길이"+rbList.size());
		} catch (SQLException e) {
			System.out.println("쿼리실패");
			e.printStackTrace();
		} finally {
			try {
				System.out.println("자원반납시작");
				rset.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				System.out.println("자원반납 실패");
				e.printStackTrace();
			}
		}
		
		return rbList;
	}
}
