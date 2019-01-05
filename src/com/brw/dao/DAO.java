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

import com.brw.dto.ReviewBoardComment;
import com.brw.dto.ReviewBoardDTO;
import com.brw.dto.UserDTO;import sun.security.krb5.internal.ccache.CCacheOutputStream;

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
		String query = "insert into tempUserTable(userid,userpassword,username,useremail) values(?,?,?,?)";
		
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

	/**
	 * 작성자 : 김은찬
	 * 회원가입때 아이디 중복 버튼 클릭시
	 * 중복 검사 확인용 메소드
	 * @param userId
	 */
	public int idCheck(String userId) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) as cnt from tempusertable where userId = ?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				result = rset.getInt("cnt");
			}
			System.out.println("dao - cnt = "+result);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				rset.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
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


	public ReviewBoardDTO getReviewSelectOne(int reviewNo) {
		Connection conn = null;
		ReviewBoardDTO review = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		String query = "select * from reviewboard where rb_no = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, reviewNo);

			res = pstmt.executeQuery();
			if(res.next()) {
				review = new ReviewBoardDTO();
				review.setRbNo(res.getInt("rb_no"));
				review.setRbTitle(res.getString("rb_title"));
				review.setRbWriter(res.getString("rb_writer"));
				review.setRbBookTitle(res.getString("rb_booktitle"));
				review.setRbContent(res.getString("rb_content"));
				review.setRbDate(res.getDate("rb_date"));
				review.setRbReadCnt(res.getInt("rb_readcnt"));
				review.setRbRecommend(res.getInt("rb_recommend"));
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

	public int insertComment(ReviewBoardComment comment) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "insert into reviewboard_comment values(seq_rb_comment_no.nextval,?,?,?,default)";
		int result = 0;
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, comment.getRbCommentWriter());
			pstmt.setString(2, comment.getRbCommentContent());
			pstmt.setInt(3, comment.getRbRef());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	public List<ReviewBoardComment> getReviewBoardCommentList(int reviewNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "select * from reviewboard_comment where rb_ref = ?";
		ResultSet res = null;
		List<ReviewBoardComment> reviewComment = null;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, reviewNo);
			res= pstmt.executeQuery();
			reviewComment = new ArrayList<>();
			while(res.next()) {
				ReviewBoardComment comment = new ReviewBoardComment();
				comment.setRbCommentNo(res.getInt("rb_comment_no"));
				comment.setRbCommentWriter(res.getString("rb_comment_writer"));
				comment.setRbCommentContent(res.getString("rb_comment_content"));
				comment.setRbRef(res.getInt("rb_ref"));
				comment.setRbCommentDate(res.getDate("rb_comment_date"));
				
				reviewComment.add(comment);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return reviewComment;
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

	/**
	 * 작성자 : 김은찬
	 * 회원가입 때 이메일 인증 버튼 클릭시
	 * 이미 가입된 이메일인지 확인하는 메소드
	 * @param email
	 * @return
	 */
	public int emailCheck(String email) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) as cnt from tempusertable where useremail = ?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, email);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				result = rset.getInt("cnt");
			}
			System.out.println("dao - cnt = "+result);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				rset.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}
	/**
	 * 로그인 메소드 ㅇㅈ? ㅇ ㅇ
	 * @param userId
	 * @param userPassword
	 * @return
	 */
	public int loginCheck(String userId, String userPassword) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select case (select count(*) from tempusertable where userid = ? and userpassword = ?) when 1 then 1 else (case(select count(*) from tempusertable where userid = ?) when 1 then 0 else -1 end) end as login_check from dual";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt("login_check");
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
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return result;
	}
}
