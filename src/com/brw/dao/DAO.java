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

import com.brw.dto.ReviewDTO;
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

	public List<ReviewDTO> getReviewList() {
		List<ReviewDTO> list = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from tempreviewtable order by review_no desc";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			while(rset.next()) {
				ReviewDTO r = new ReviewDTO();
				r.setReviewNo(rset.getInt("review_no"));
				r.setReviewTitle(rset.getString("review_title"));
				r.setReviewWriter(rset.getString("review_writer"));
				r.setReviewBookId(rset.getString("review_bookid"));
				r.setReviewContent(rset.getString("review_content"));
				r.setReviewDate(rset.getDate("review_date"));
				r.setReviewReadCnt(rset.getInt("review_readcnt"));
				r.setReviewRecommend(rset.getInt("review_recommend"));
				
				list.add(r);
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
<<<<<<< .merge_file_a01164
=======

	public ReviewDTO getReviewSelectOne(String reviewBookId) {
		Connection conn = null;
		ReviewDTO review = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		String query = "select * from tempreviewtable where reviewBookId = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, reviewBookId);

			res = pstmt.executeQuery();
			if(res.next()) {
				review = new ReviewDTO();
				review.setReviewNo(res.getInt("review_no"));
				review.setReviewTitle(res.getString("review_title"));
				review.setReviewWriter(res.getString("review_writer"));
				review.setReviewBookId(res.getString("review_bookid"));
				review.setReviewContent(res.getString("review_content"));
				review.setReviewDate(res.getDate("review_date"));
				review.setReviewReadCnt(res.getInt("review_readcnt"));
				review.setReviewRecommend(res.getInt("review_recommend"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				res.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		return review;
	}
	
	
>>>>>>> .merge_file_a13164
}
