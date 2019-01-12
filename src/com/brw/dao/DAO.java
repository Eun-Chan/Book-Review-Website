package com.brw.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.brw.dto.BookBasketDTO;
import com.brw.dto.NoticeDTO;
import com.brw.dto.OneLineReviewDTO;
import com.brw.dto.ReviewBoardComment;
import com.brw.dto.ReviewBoardDTO;
import com.brw.dto.ReviewBoardLikeDTO;
import com.brw.dto.ReviewBoardReportDTO;
import com.brw.dto.ReviewBoardViewDTO;
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
	
	/*
	 * 1
	 * 작성자 : 김은찬
	 * 내용 : 회원가입
	 */
	public void createUser(UserDTO user) throws SQLException {
		int result = 0;
		String query = "insert into tempUserTable(userid,userpassword,username,useremail,userNickName,userPoint,userGrade) values(?,?,?,?,?,default,default)";
		
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
			pstmt.setString(5, user.getUserNickName());
			
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
	/*
	 * 2
	 * 작성자 : ?
	 * 내용 : ?
	 */
	public boolean changePwdCheck(Connection con, String userId) {
		boolean result = false;
		String query = "B"
				+ "p"
				+ "";
		
		PreparedStatement pstmt = null;

		return true;
	}

	/**
	 * 3
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

	/*
	 * 4
	 * 작성자 : 정명훈
	 * 내용 : 리뷰리스트 페이징
	 */
	public List<ReviewBoardViewDTO> reivewPagination(int cPage, int numPerPage) {
		List<ReviewBoardViewDTO> list = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select r.*, to_char(r.rb_date, 'YYYY-MM-DD HH24:MI') as strdate, to_char(sysdate, 'YYYY-MM-DD') sysday, to_char(r.rb_date, 'YYYY-MM-DD') rbday, to_char(r.rb_date, 'HH24:MI') as todaytime, (sysdate - r.rb_date) as passingtime from (select rownum rnum, r.* from (select * from reviewboard a join tempusertable b on a.rb_writer = b.userid where del_flag = 'N' order by rb_no desc) r) r where rnum between ? and ?";
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
				ReviewBoardViewDTO rbv = new ReviewBoardViewDTO();
				
				// 리뷰보드DTO에 있는 것들
				rbv.setRbNo(rset.getInt("rb_no"));
				rbv.setRbTitle(rset.getString("rb_title"));
				rbv.setRbWriter(rset.getString("rb_writer"));
				rbv.setRbBookTitle(rset.getString("rb_booktitle"));
				rbv.setRbContent(rset.getString("rb_content"));
				rbv.setRbStarscore(rset.getInt("rb_starscore"));
				rbv.setRbReadCnt(rset.getInt("rb_readcnt"));
				rbv.setRbRecommend(rset.getInt("rb_recommend"));
				rbv.setRbReport(rset.getInt("rb_report"));
				
				// new : 작성한지 만 하루가 지나지 않은 것들
				// 현재일(day)과 같은 날에 쓴 글은 작성일에 시간만 띄우기 (HH24:MI)
				boolean dateNew = false;
				int passingTime = rset.getInt("passingtime");
				String sysDay = rset.getString("sysday");
				String rbDay = rset.getString("rbday");
				
				if(passingTime <= 1) {
					dateNew = true;
					if(rbDay.equals(sysDay)) {
						rbv.setRbDate(rset.getString("todaytime"));
					}
					else {
						rbv.setRbDate(rset.getString("strdate"));
					}
				}
				else {
					rbv.setRbDate(rset.getString("strdate"));
				}
				rbv.setDateNew(dateNew);
				rbv.setUserNickName(rset.getString("usernickname"));
				rbv.setUserGrade(rset.getInt("usergrade"));
				
				list.add(rbv);
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

	/*
	 * 5
	 * 작성자 : 정명훈
	 * 내용 : 리뷰리스트 페이징용 카운터
	 */
	public int countReviewAll() {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) from reviewboard where del_flag = 'N' order by rb_no desc";
		
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

	/*
	 * 6
	 * 작성자 : 정명훈
	 * 내용 : 리뷰검색 리스트 페이징
	 */
	public List<ReviewBoardViewDTO> reivewSearch(String searchType, String searchKeyword, int cPage, int numPerPage) {
		List<ReviewBoardViewDTO> list = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select r.*, to_char(r.rb_date, 'YYYY-MM-DD HH24:MI') as strdate, to_char(sysdate, 'YYYY-MM-DD') sysday, to_char(r.rb_date, 'YYYY-MM-DD') rbday, to_char(r.rb_date, 'HH24:MI') as todaytime, (sysdate - r.rb_date) as passingtime from (select rownum rnum, r.* from (select * from reviewboard a join tempusertable b on a.rb_writer = b.userid where del_flag = 'N' and searchType like '%'||?||'%' order by rb_no desc) r) r where rnum between ? and ?";
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
				ReviewBoardViewDTO rbv = new ReviewBoardViewDTO();
				
				rbv.setRbNo(rset.getInt("rb_no"));
				rbv.setRbTitle(rset.getString("rb_title"));
				rbv.setRbWriter(rset.getString("rb_writer"));
				rbv.setRbBookTitle(rset.getString("rb_booktitle"));
				rbv.setRbContent(rset.getString("rb_content"));
				rbv.setRbStarscore(rset.getInt("rb_starscore"));
				rbv.setRbReadCnt(rset.getInt("rb_readcnt"));
				rbv.setRbRecommend(rset.getInt("rb_recommend"));
				rbv.setRbReport(rset.getInt("rb_report"));
				
				boolean dateNew = false;
				int passingTime = rset.getInt("passingtime");
				String sysDay = rset.getString("sysday");
				String rbDay = rset.getString("rbday");
				
				if(passingTime <= 1) {
					dateNew = true;
					if(rbDay.equals(sysDay)) {
						rbv.setRbDate(rset.getString("todaytime"));
					}
					else {
						rbv.setRbDate(rset.getString("strdate"));
					}
				}
				else {
					rbv.setRbDate(rset.getString("strdate"));
				}
				rbv.setDateNew(dateNew);
				rbv.setUserNickName(rset.getString("usernickname"));
				rbv.setUserGrade(rset.getInt("usergrade"));
				
				list.add(rbv);
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
	
	/*
	 * 7
	 * 작성자 : 정명훈
	 * 내용 : 리뷰검색 리스트용 카운터
	 */
	public int countReviewSearch(String searchType, String searchKeyword) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) from reviewboard a join tempusertable b on a.rb_writer = b.userid where del_flag = 'N' and searchType like '%'||?||'%' order by rb_no desc";
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


	/*
	 * 8
	 * 작성자 : 장선웅
	 * 내용 : 게시판 디테일 
	 */
	public ReviewBoardViewDTO getReviewSelectOne(int reviewNo) {
		Connection conn = null;
		ReviewBoardViewDTO review = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		String query = "select * from reviewboard a join tempusertable b on a.rb_writer = b.userid where del_flag = 'N'  and rb_no = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, reviewNo);

			res = pstmt.executeQuery();
			if(res.next()) {
				review = new ReviewBoardViewDTO();
				review.setRbNo(res.getInt("rb_no"));
				review.setRbTitle(res.getString("rb_title"));
				review.setRbWriter(res.getString("rb_writer"));
				review.setRbBookTitle(res.getString("rb_booktitle"));
				review.setRbIsbn(res.getString("rb_isbn"));
				review.setRbContent(res.getString("rb_content"));
				review.setRbDate(res.getString("rb_date"));
				review.setRbReadCnt(res.getInt("rb_readcnt"));
				review.setRbRecommend(res.getInt("rb_recommend"));
				review.setRbStarscore(res.getDouble("rb_starscore"));
				review.setUserNickName(res.getString("usernickname"));
				review.setUserGrade(res.getInt("usergrade"));
				int rb_readcnt = res.getInt("rb_readcnt");
				review.setRbReadCnt(rb_readcnt);
				rb_readcnt++;
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

	/*
	 * 9
	 * 작성자 : 장선웅
	 * 내용 : 댓글 입력
	 */
	public int insertComment(ReviewBoardComment comment) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "insert into reviewboard_comment values(seq_rb_comment_no.nextval,?,default,?,?,null,default,default,?)";
		int result = 0;
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, comment.getRbCommentWriter());
			pstmt.setString(2, comment.getRbCommentContent());
			pstmt.setInt(3, comment.getRbRef());
			pstmt.setString(4, comment.getRbCommentWriterNickName());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	/*
	 * 10
	 * 작성자 : 장선웅
	 * 내용 : 댓글 리스트 가져오기
	 */
	public List<ReviewBoardComment> getReviewBoardCommentList(int reviewNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "select a.*, b.* ,to_char(a.rb_comment_date,'YYYY-MM-DD HH24:MI')as rdate from reviewboard_comment a join tempusertable b on a.rb_comment_writer = b.userid where rb_ref = ? and rb_comment_level=1 order by rb_comment_no";
		ResultSet res = null;
		List<ReviewBoardComment> reviewComment = null;
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD hh:mm:ss");
		
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
				comment.setRbCommentDate(res.getString("rb_comment_date"));
				comment.setRbCommentDelflag(res.getString("rb_comment_delflag"));
				comment.setRbCommentWriterNickName(res.getString("rb_commentwriter_nickname"));
				comment.setUserGrade(res.getInt("usergrade"));
				comment.setUserPoint(res.getInt("userpoint"));
				reviewComment.add(comment);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				res.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return reviewComment;
	}

	/**
	 * 11
	 * 작성자 : 박광준
	 * 내용 : 최근리뷰 5개 가져오기
	 */
	public List<ReviewBoardDTO> selectReviewRecentList()
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ReviewBoardDTO> rbList = new ArrayList<>();
		String query = "SELECT rb_readcnt, rb_recommend, rb_title, rb_writer, rb_booktitle, rb_starscore, to_char(rb_date, 'YYYY-MM-DD HH24:MI:SS') AS rb_date,  rb_no FROM (SELECT * FROM reviewboard ORDER BY rb_date DESC) WHERE rownum < 6";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			while(rset.next())
			{
				ReviewBoardDTO rb = new ReviewBoardDTO();
				
				rb.setRbTitle(rset.getString("rb_title"));
				rb.setRbWriter(rset.getString("rb_writer"));
				rb.setRbBookTitle(rset.getString("rb_booktitle"));
				rb.setRbDate(rset.getString("rb_date"));
				rb.setRbStarscore(rset.getInt("rb_starscore"));
				rb.setRbNo(rset.getInt("rb_no"));
				rb.setRbReadCnt(rset.getInt("rb_readCnt"));
				rb.setRbRecommend(rset.getInt("rb_recommend"));
				rbList.add(rb);
			}
		} catch (SQLException e) {
			System.out.println("DAO_selectReviewRecentList_광준@쿼리요청이 실패했습니다.");
			e.printStackTrace();
		} finally {
			try {
				rset.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				System.out.println("DAO_selectReviewRecentList_광준@자원반납에 실패했습니다.");
				e.printStackTrace();
			}
		}		
		return rbList;
	}
	/**
	 * 12
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
	 * 13
	 * 작성자 : 장선웅
	 * 내용 : 댓글 갯수 가져오기
	 */
//	public int getReivewBoardCommentAllCount(int rbNo) {
//		int count = 0;
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet res = null;
//		String query = "select count(*)count  from reviewboard_comment where rb_ref=? and rb_comment_level=1";
//		
//		try {
//			conn = dataSource.getConnection();
//			pstmt = conn.prepareStatement(query);
//			pstmt.setInt(1, rbNo);
//			res = pstmt.executeQuery();
//			if(res.next()) {
//				count = res.getInt("count");
//			}
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} finally {
//			try {
//				res.close();
//				pstmt.close();
//				conn.close();
//			} catch (SQLException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
//		
//		return count;
//	}
	/**
	 * 14
	 * 작성자 : 장선웅
	 * 내용 : 마지막 댓글 가져오기
	 */
	public ReviewBoardComment getReviewBoardCommentLast(int rbNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		ReviewBoardComment lastComment = null;
		String query ="SELECT * FROM (SELECT * FROM reviewboard_comment where rb_ref=? ORDER BY rb_comment_no DESC) WHERE ROWNUM = 1";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, rbNo);
			res = pstmt.executeQuery();
			lastComment = new ReviewBoardComment();
			if(res.next()) {
				lastComment.setRbCommentNo(res.getInt("rb_comment_no"));
				lastComment.setRbCommentWriter(res.getString("rb_comment_writer"));
				lastComment.setRbCommentContent(res.getString("rb_comment_content"));
				lastComment.setRbRef(res.getInt("rb_ref"));
				lastComment.setRbCommentDate(res.getString("rb_comment_date"));
				lastComment.setRbCommentWriterNickName(res.getString("rb_commentwriter_nickName"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				res.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return lastComment;
	}

	/**
	 * 15
	 * 작성자 : 장선웅
	 * 내용 : 리댓글 인서트 
	 * @param rbCommentWriterNickName 
	 */
	public int insertReComment(int rbCommentNo, String rbCommentContent, String rbCommentWriter, int rbNo, String rbCommentWriterNickName) {
		Connection conn = null;
		PreparedStatement pstmt =null;
		int result = 0;
		String query = "insert into reviewboard_comment values(seq_rb_comment_no.nextval,?,2,?,?,?,default,default,?)";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, rbCommentWriter);
			pstmt.setString(2, rbCommentContent);
			pstmt.setInt(3, rbNo);
			pstmt.setInt(4, rbCommentNo);
			pstmt.setString(5, rbCommentWriterNickName);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
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
	 * 16
	 * 작성자 : 김은찬
	 * 내용 : 로그인 메소드 ㅇㅈ? ㅇ ㅇ
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
	/**
	 * 17
	 * 작성자 : 박세준
	 * 내용 : bookreview갖고오기
	 */
	public List<ReviewBoardViewDTO> getbookreview(String iSBN13) {
		List<ReviewBoardViewDTO> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		//String query = "select * from reviewboard where rb_isbn = ? order by rb_no desc";
		String query = "select r.*, to_char(r.rb_date, 'YYYY-MM-DD HH24:MI') as strdate, to_char(r.rb_date, 'HH24:MI') as datenew, (sysdate - r.rb_date) as passingtime from (select rownum rnum, r.* from (select * from reviewboard a join tempusertable b on a.rb_writer = b.userid where del_flag = 'N' and Rb_isbn = ? order by rb_no desc) r) r";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, iSBN13);

			
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			while(rset.next()) {
				ReviewBoardViewDTO rbv = new ReviewBoardViewDTO();
				
				// 리뷰보드DTO에 있는 것들
				rbv.setRbNo(rset.getInt("rb_no"));
				rbv.setRbTitle(rset.getString("rb_title"));
				rbv.setRbWriter(rset.getString("rb_writer"));
				rbv.setRbBookTitle(rset.getString("rb_booktitle"));
				rbv.setRbContent(rset.getString("rb_content"));
				rbv.setRbStarscore(rset.getInt("rb_starscore"));
				rbv.setRbReadCnt(rset.getInt("rb_readcnt"));
				rbv.setRbRecommend(rset.getInt("rb_recommend"));
				rbv.setRbReport(rset.getInt("rb_report"));
				
				// 리뷰보드뷰DTO에 있는 것들
				boolean dateNew = false;
				int passingTime = rset.getInt("passingtime");
				if(passingTime <= 1) {
					dateNew = true;
					rbv.setRbDate(rset.getString("datenew"));
				}
				else {
					rbv.setRbDate(rset.getString("strdate"));
				}
				rbv.setDateNew(dateNew);
				rbv.setUserNickName(rset.getString("usernickname"));
				rbv.setUserGrade(rset.getInt("usergrade"));
				
				list.add(rbv);
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
		return	list;
	}
	/**
	 * 18
	 * 작성자 : 장선웅
	 * 내용 : 대댓글 리스트 가져오기
	 */
	public List<ReviewBoardComment> getReviewBoardReCommentList(int rbNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "select * from reviewboard_comment a join tempusertable b on a.rb_comment_writer = b.userid where a.rb_ref = ? and a.rb_comment_level =2 order by rb_comment_no";
		ResultSet res = null;
		List<ReviewBoardComment> reviewReComment = null;
		
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, rbNo);
			
			res = pstmt.executeQuery();
			reviewReComment = new ArrayList<>();
			
			while(res.next()) {
				ReviewBoardComment reComment = new ReviewBoardComment();
				reComment.setRbCommentNo(res.getInt("rb_comment_no"));
				reComment.setRbCommentWriter(res.getString("rb_comment_writer"));
				reComment.setRbCommentContent(res.getString("rb_comment_content"));
				reComment.setRbRef(res.getInt("rb_ref"));
				reComment.setRbCommentRef(res.getInt("rb_comment_ref"));
				reComment.setRbCommentDate(res.getString("rb_comment_date"));
				reComment.setRbCommentWriterNickName(res.getString("rb_commentwriter_nickname"));
				reComment.setUserPoint(res.getInt("userpoint"));
				reComment.setUserGrade(res.getInt("usergrade"));
				
				reviewReComment.add(reComment);
			}
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				res.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return reviewReComment;
	}
	/**
	 * 19
	 * 작성자 : 장선웅
	 * 내용 : 마지막으로 입력한 대댓글 가져오기 
	 */
	public ReviewBoardComment getReviewBoardReCommentLast(int rbCommentNo, int rbNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		ReviewBoardComment lastReComment= null;
		String query= "SELECT * FROM (SELECT * FROM reviewboard_comment where rb_ref=? and rb_comment_level = 2 and rb_comment_ref=? ORDER BY rb_comment_no DESC) WHERE ROWNUM = 1";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rbNo);
			pstmt.setInt(2, rbCommentNo);
			
			res = pstmt.executeQuery();
			lastReComment = new ReviewBoardComment();
			if(res.next()) {
				lastReComment.setRbCommentNo(res.getInt("rb_comment_no"));
				lastReComment.setRbCommentWriter(res.getString("rb_comment_writer"));
				lastReComment.setRbCommentContent(res.getString("rb_comment_content"));
				lastReComment.setRbRef(res.getInt("rb_ref"));
				lastReComment.setRbCommentRef(res.getInt("rb_comment_ref"));
				lastReComment.setRbCommentDate(res.getString("rb_comment_date"));
				lastReComment.setRbCommentWriterNickName(res.getString("rb_commentwriter_nickname"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				res.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		return lastReComment;
	}

	/**
	 * 20
	 * 작성자 : 김은찬
	 * 내용 : 1명의 회원 정보를 가져오기
	 */
	public UserDTO selectOneUser(String userId) {
		UserDTO userDTO = null;
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from tempusertable where userid = ?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				userDTO = new UserDTO();
				userDTO.setUserId(rset.getString("userId"));
				userDTO.setUserName(rset.getString("userName"));
				userDTO.setUserEmail(rset.getString("userEmail"));
				userDTO.setUserNickName(rset.getString("userNickName"));
				userDTO.setUserGrade(rset.getInt("usergrade"));
				userDTO.setUserPoint(rset.getInt("userpoint"));
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
		return userDTO;
		
		
	}
	
	
	/**
	 * 21. 선웅 : 해당 게시판 다음글 게시판 번호 가져오기
	 * 
	 */
	
	public int selectReviewBoardNextNumber(int rbNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		String query = "SELECT rb_no nextnumber FROM reviewboard WHERE rb_no IN ((SELECT  MIN(rb_no)FROM    reviewboard WHERE   rb_no > ? and del_flag like 'N' ))";
		int nextNumber = 0;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rbNo);
			
			res = pstmt.executeQuery();
			if(res.next()) {
				nextNumber = res.getInt("nextnumber");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				res.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		return nextNumber;
	}

	/**
	 * 22. 선웅 : 해당 리뷰 게시판 이전글 번호 구하는 쿼리
	 * @param rbNo
	 * @return
	 */
	
	public int selectReviewBoardPrevNumber(int rbNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		int prevNumber = 0;
		String query = "SELECT rb_no prevnumber FROM reviewboard WHERE rb_no IN ((SELECT  max(rb_no)FROM    reviewboard WHERE   rb_no < ? and del_flag like 'N' ))";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rbNo);
			res = pstmt.executeQuery();
			if(res.next()) {
				prevNumber = res.getInt("prevnumber");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				res.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return prevNumber;
	}

	/**
	 * 23 . 선웅 : 처음 좋아요 버튼을 눌럿을 때 좋아요 테이블에 인서트 해주는곳
	 * @param rbNo
	 * @param userId
	 * @return
	 */
	
	public int insertReviewBoardLike(int rbNo, String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert into reviewboard_like values(seq_likeNo.nextval,?,?,1)";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rbNo);
			pstmt.setString(2, userId);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
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
	 * 24 선웅 : 좋아요 테이블 전체 조회
	 * @param rbNo
	 * @param userId
	 * @return
	 */
	public List<ReviewBoardLikeDTO> selectAllReviewBoardLike(int rbNo, String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		String query = "select * from reviewboard_like where like_userid like ? and like_rbNo = ? and like_counter = 1";
		List<ReviewBoardLikeDTO> likeList = null;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setInt(2, rbNo);
			
			res = pstmt.executeQuery();

			likeList = new ArrayList<>();
			while(res.next()) {
				ReviewBoardLikeDTO like = new ReviewBoardLikeDTO();
				like.setLikeNo(res.getInt("likeno"));
				like.setLikeRbNo(res.getInt("like_rbno"));
				like.setLikeUserId(res.getString("like_userid"));
				like.setLikeCounter(res.getInt("like_counter"));
				
				likeList.add(like);
			}
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				res.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		return likeList;
	}

	
	/**
	 * 25. 선웅 : 좋아요 테이블 카운터가 0으로 업데이트 되면 해당 컬럼 삭제
	 * @param rbNo
	 * @param userId
	 * @return
	 */
	public int deleteReviewBoardLike(int rbNo, String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "delete from reviewboard_like where like_userid like ? and like_rbno = ? and like_counter= 1";
		int result = 0;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setInt(2, rbNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return result;
	}


	/*
	 * 26
	 * 작성자 : 정명훈
	 * 내용 : 리뷰 db에 등록
	 */
	public int reviewWrite(ReviewBoardDTO rb) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "insert into reviewboard (rb_no,rb_booktitle,rb_title,rb_writer,rb_isbn,rb_content,rb_starscore) " + 
						"values (seq_review_no.nextval,?,?,?,?,?,?)";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, rb.getRbBookTitle());
			pstmt.setString(2, rb.getRbTitle());
			pstmt.setString(3, rb.getRbWriter());
			pstmt.setString(4, rb.getRbIsbn());
			pstmt.setString(5, rb.getRbContent());
			pstmt.setDouble(6, rb.getRbStarscore());
			
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				conn.commit();
			}
			else {
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	
		
	return result;
	}
			
	/*
	 * 27
	 * 작성자 : 정명훈
	 * 내용 : 작성한 리뷰글 번호 가져오기 (마지막 리뷰글 가져오기)
	 */
	public int getLastReviewBoardNo() {
		int lastReviewBoardNo = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select max(rb_no) from reviewboard";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				lastReviewBoardNo = rset.getInt(1);
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
	
	return lastReviewBoardNo;
	}
	
	/*
	 * 28
	 * 작성자 : 정명훈
	 * 내용 : book테이블에 해당 isbn이 있는지 검사 후 boolean 리턴
	 */
	public boolean isIsbnExist(String rbIsbn) {
		boolean isIsbnExist = false;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from book where isbn = ?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, rbIsbn);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				isIsbnExist = true;
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
		
		System.out.println(isIsbnExist);
		return isIsbnExist;
	}

	/*
	 * 29
	 * 작성자 : 정명훈
	 * 내용 : book테이블에 도서 정보 추가
	 */
	public int insertBook(String rbBookTitle, String bookAuthor, String rbIsbn, int bookPriceStandard, String bookPublisher) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "insert into book (booktitle, author, isbn, pricestandard, publisher) values (?, ?, ?, ?, ?)";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			
			
			pstmt.setString(1, rbBookTitle);
			pstmt.setString(2, bookAuthor);
			pstmt.setString(3, rbIsbn);
			pstmt.setInt(4, bookPriceStandard);
			pstmt.setString(5, bookPublisher);
			
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				conn.commit();
			}
			else {
				conn.rollback();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	/*
	 * 30
	 * 작성자 : 김민우
	 * 내용 : 즐겨찾기 클릭 시 basket 테이블에 값 저장
	 */
	public int insertBasket(UserDTO user, String isbn, String title, int price) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "insert into basket (basketNo, userId, userName, isbn, bookTitle, price) values (seq_basket.nextval, ?, ?, ?, ?, ?)";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, isbn);
			pstmt.setString(4, title);
			pstmt.setInt(5, price);
			
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				conn.commit();
			}
			else {
				conn.rollback();
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	/*
	 * 31
	 * 작성자 : 김민우
	 * 내용 : 로그인 한 유저가 즐겨찾기를 한 책인지 검색
	 */
	public boolean isChecked(UserDTO user, String isbn13) {
		boolean basketCheck = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from basket where userid = ? and isbn = ?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, isbn13);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				basketCheck = true;
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
		return basketCheck;
	}
	/*
	 * 32
	 * 작성자 : 김민우
	 * 내용 : 이미 즐겨찾기를 한 경우 basket테이블에서 삭제
	 */
	public void deleteBasket(UserDTO user, String isbn) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "delete from basket where userId = ? and isbn = ?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, isbn);
			
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				conn.commit();
			}
			else {
				conn.rollback();
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}
	
	/**
	 * 33.
	 * @광준 : 도서의 isbn별 별점을 조회하기 위한 처리
	 * @param bookIsbn_Array
	 * @return
	 */
	public List<String> selectStarScoreList(String[] bookIsbn_Array) {
		List<String> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "SELECT AVG(rb_starscore) AS rb_starscore FROM reviewboard WHERE rb_isbn = ?";
		ResultSet rset = null;
		int result = 0;
		
		for(int i=0; i<bookIsbn_Array.length; i++) 
		{
			try {
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, bookIsbn_Array[i]);
				rset = pstmt.executeQuery();
				rset.next();
				
				if((rset.getString("rb_starscore"))!=null) list.add((rset.getString("rb_starscore")));
				else list.add("");
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
		}
		
		return list;
	}
	
	/**
	 * 34
	 * 작성자 : 정명훈
	 * 내용 : 댓글 갯수 모두(level에 상관없이) 다 가져오기
	 */
	public int getComment(int rbNo) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		String query = "select count(*) cnt from reviewboard_comment where rb_comment_delflag = 'N' and rb_ref=?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rbNo);
			res = pstmt.executeQuery();
			if(res.next()) {
				count = res.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				res.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		
		
		
		return count;
	}
	/**
	 * 35. 좋아요 총 갯수 구하기!
	 * @param rbNo 
	 * @return
	 */
	public int selectLikeCount(int rbNo) {
		int maxLike = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		String query = "select  count(distinct like_userId)maxLike from reviewboard_like where like_counter = 1 and like_rbNo=?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rbNo);
			res=  pstmt.executeQuery();
			if(res.next()) {
				maxLike = res.getInt("maxlike");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				res.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		return maxLike;
	}


	/**
	 * 36. 선웅 : 해당 댓글에 대댓글이 있는지 확인하기
	 * @param rbCommentNo
	 * @param rbNo 
	 * @return
	 */
	public List<ReviewBoardComment> checkRecommend(int rbCommentNo, int rbNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		String query = "select * from reviewboard_comment where rb_ref = ? and rb_comment_ref =?";
		List<ReviewBoardComment> commentList = null;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rbNo);
			pstmt.setInt(2, rbCommentNo);
			commentList = new ArrayList<>();
			res = pstmt.executeQuery();
			while(res.next()) {
				ReviewBoardComment rc = new ReviewBoardComment();
				rc.setRbCommentNo(res.getInt("rb_comment_No"));
				rc.setRbCommentWriter(res.getString("rb_comment_writer"));
				rc.setRbCommentContent(res.getString("rb_comment_content"));
				rc.setRbRef(res.getInt("rb_ref"));
				rc.setRbCommentRef(res.getInt("rb_comment_ref"));
				rc.setRbCommentDate(res.getString("rb_comment_date"));
				commentList.add(rc);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				res.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return commentList;
	}

	/**
	 * 37. 선웅 : 리뷰글 조회수 1 증가시키는 쿼리
	 * @param rbNo
	 * @return
	 */
	public int updateReadCnt(int rbNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int updateReadCount = 0;
		String query = "update reviewboard set rb_readcnt = rb_readcnt+1 where rb_no =?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rbNo);
			
			updateReadCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return updateReadCount;
	}

	/**
	 * 38. 선웅 : 대댓글이 있으면 업데이트 , 없으면 댓글 삭제하기
	 * @param rbCommentNo
	 * @param rbNo
	 * @param ud
	 * @return
	 */
	public int udReviewBoardComment(int rbCommentNo, int rbNo, int ud) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "";
		//ud 가 1일 경우 업데이트 2일 경우 딜리트
		if(ud==1) {
			query ="update reviewboard_comment set rb_comment_content = '[삭제된 댓글 입니다.]',rb_comment_delflag='Y' where rb_comment_no = ? and rb_ref = ?";
		}else if(ud==2) {
			query ="delete from reviewboard_comment where rb_comment_no = ? and rb_ref = ?";
		}
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rbCommentNo);
			pstmt.setInt(2, rbNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
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
	 * 39. 작성자 : 박세준
	 * 내용 : 즐겨찾기 check된거 삭제
	 */
	public int checkeddelete(UserDTO user, String isbn) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "delete from basket where userId = ? and isbn = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, isbn);
			
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				conn.commit();
			}
			else {
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	/*
	 * 40. 작성자 : 박세준
	 * 내용 : 즐겨찾기 보여주는 결과
	 */
	public List<BookBasketDTO> showBookBasket(String userId, int cPage, int numPerPage) {
		List<BookBasketDTO> list = new ArrayList();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select basketno,userid,username,isbn,booktitle,price,quantity,totalprice,to_char(pickdate,'YYYY-MM-DD HH24:MI') as pickdate from(select rownum as rnum,v.* from (select * from basket where userid = ? order by pickdate desc)v)v where rnum between ? and ?";
		int startRnum = (cPage - 1) * numPerPage + 1;
		int endRnum = cPage * numPerPage;
			try {
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, userId);
				pstmt.setInt(2, startRnum);
				pstmt.setInt(3, endRnum);
				rset = pstmt.executeQuery();
				
				while(rset.next()) {
					BookBasketDTO bb = new BookBasketDTO(); 
					bb.setBasketNo(rset.getInt("basketNo"));
					bb.setUserId(rset.getString("userid"));
					bb.setUserName(rset.getString("username"));
					bb.setISBN(rset.getString("isbn"));
					bb.setBookTitle(rset.getString("booktitle"));
					bb.setPrice(rset.getInt("price"));
					bb.setQuantity(rset.getInt("quantity"));
					bb.setTotalPrice(rset.getInt("totalprice"));
					bb.setPickDate(rset.getString("pickdate"));
				
					list.add(bb);
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
			return list;
		}

	/**
	 * 작성자 : 김은찬
	 * 41. 이메일을 통해 아이디 찾아보리기
	 */
	public String searchIdForEmail(String userEmail) {
		String userId = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select userId from tempusertable where userEmail = ?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);

			pstmt.setString(1, userEmail);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				userId = rset.getString("userId");
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
		return userId;
	}
	/**
	 * @광준
	 * 42. 하루기준으로 조회수가 가장 높은 글  5개 가져오기
	 */
	public List<ReviewBoardDTO> selectReviewBestList()
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ReviewBoardDTO> rbList = new ArrayList<>();
		String query = "SELECT rb_readcnt, rb_recommend, rb_title, rb_writer, rb_booktitle, rb_starscore, to_char(rb_date, 'YYYY-MM-DD') AS rb_date,  rb_no FROM (SELECT * FROM reviewboard ORDER BY rb_readcnt DESC) WHERE rb_date > SYSDATE-7";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();

			while(rset.next())
			{
				ReviewBoardDTO rb = new ReviewBoardDTO();
				
				rb.setRbTitle(rset.getString("rb_title"));
				rb.setRbWriter(rset.getString("rb_writer"));
				rb.setRbBookTitle(rset.getString("rb_booktitle"));
				rb.setRbDate(rset.getString("rb_date"));
				rb.setRbStarscore(rset.getInt("rb_starscore"));
				rb.setRbNo(rset.getInt("rb_no"));
				rb.setRbReadCnt(rset.getInt("rb_readCnt"));
				rb.setRbRecommend(rset.getInt("rb_recommend"));
				rbList.add(rb);
			}
		} catch (SQLException e) {
			System.out.println("DAO_selectReviewRecentList_광준@쿼리요청이 실패했습니다.");
			e.printStackTrace();
		} finally {
			try {
				rset.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {

				System.out.println("DAO_selectReviewRecentList_광준@자원반납에 실패했습니다.");
				e.printStackTrace();
			}
		}		
		return rbList;
	}

	/*
	 * 43. 작성자 : 김민우
	 * 내용 : 한 줄 리뷰 등록
	 */

	public int insertOneLineRV(String userId, double starScore, String oneLineRV, String isbn13) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "insert into onelinereview(no, isbn, content, starScore, userId) values(seq_oneLine.nextval, ?, ?, ?, ?)";

		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, isbn13);
			pstmt.setString(2, oneLineRV);
			pstmt.setDouble(3, starScore);
			pstmt.setString(4, userId);
			
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				conn.commit();
			}
			else {
				conn.rollback();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
				
		return result;
	}
	
	/*
	 * 44. 작성자 : 김민우
	 * 내용 : 현재 보고 있는 책에 모든 한 줄 리뷰 조회
	 */

	public List<OneLineReviewDTO> selectAllOneLineRV(String isbn13) {
		List<OneLineReviewDTO> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from onelinereview where isbn = ? and delflag = 'N' order by now desc";

		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, isbn13);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				OneLineReviewDTO o = new OneLineReviewDTO();
				o.setNo(rset.getInt("no"));
				o.setIsbn(rset.getString("isbn"));
				o.setContent(rset.getString("content"));
				o.setStarScore(rset.getDouble("starScore"));
				o.setUserId(rset.getString("userId"));
				o.setNow(rset.getDate("now"));
				o.setDelFlag(rset.getString("delFlag"));
				
				list.add(o);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
						
		return list;
		}

	/* 45. 작성자 : 장선웅
	 *     내용 : 닉네임 중복 검사*/
	public int nickNameCheck(String userNickName) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select count(*) as cnt from tempusertable where userNickName = ?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userNickName);
			
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
	
	/*
	 * 46. 작성자 : 정명훈
	 * 내용 : 공지사항 게시판에 보여줄 리스트 가져오기 (삭제되지 않았고 ntc_allowview은 상관없음.) 
	 */
	public List<NoticeDTO> noticeList(int cPage, int numPerPage) {
		List<NoticeDTO> list = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select n.*, to_char(ntc_date, 'YYYY-MM-DD HH24:MI') strdate, to_char(sysdate, 'YYYY-MM-DD') sysday, to_char(n.ntc_date, 'YYYY-MM-DD') ntcday, to_char(n.ntc_date, 'HH24:MI') as todaytime, (sysdate - n.ntc_date) as passingtime from (select rownum rnum, n.* from (select * from notice n where ntc_delflag = 'N' order by ntc_no desc) n) n where rnum between ? and ?";
		
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
				NoticeDTO n = new NoticeDTO();
				
				n.setNtcNo(rset.getInt("ntc_no"));
				n.setNtcTitle(rset.getString("ntc_title"));
				n.setNtcContent(rset.getString("ntc_content"));
				n.setNtcReadcnt(rset.getInt("ntc_readcnt"));
				n.setNtcAllowview(rset.getString("ntc_allowview"));
				
				boolean dateNew = false;
				double passingTime = rset.getDouble("passingtime");
				String sysDay = rset.getString("sysday");
				String ntcDay = rset.getString("ntcday");
				
				if(passingTime <= 1.0) {
					dateNew = true;
					if(ntcDay.equals(sysDay)) {
						n.setNtcDate(rset.getString("todaytime"));
					}
					else {
						n.setNtcDate(rset.getString("strdate"));
					}
				}
				else {
					n.setNtcDate(rset.getString("strdate"));
				}
				
				n.setDateNew(dateNew);
				
				list.add(n);
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
		return list;
	}
	/*
	 * 47. 작성자 : 정명훈
	 * 내용 : 공지사항 조회수 1 올리기 
	 */
	public int noticeReadcntUp(int ntcNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "update notice set ntc_readcnt = ntc_readcnt+1 where ntc_no =?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);

			pstmt.setInt(1, ntcNo);
			
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				conn.commit();
			}
			else {
				conn.rollback();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	/*
	 * 48. 작성자 : 정명훈
	 * 내용 : 공지사항 번호로 공지사항 하나 가져오기
	 */
	public NoticeDTO selectNoticeOne(int ntcNo) {
		NoticeDTO n = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select n.*, to_char(ntc_date, 'YYYY-MM-DD HH24:MI') strdate from notice n where ntc_no = ?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, ntcNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				n = new NoticeDTO();
				n.setNtcNo(ntcNo);
				n.setNtcTitle(rset.getString("ntc_title"));
				n.setNtcContent(rset.getString("ntc_content"));
				n.setNtcDate(rset.getString("strdate"));
				n.setNtcReadcnt(rset.getInt("ntc_readcnt"));
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
		
		
		return n;
	}
	
	/* 
	 * 49. 한 줄 리뷰 삭제: 김민우
	 * */
	public int deleteOneLineReview(String userId, int oneLineNo) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "delete from onelinereview where userId = ? and no = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setInt(2, oneLineNo);
			
			result = pstmt.executeUpdate();
			
			if(result > 1) {
				conn.commit();
			}else {
				conn.rollback();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;

	}
	/*
	 * 50. 작성자 : 정명훈
	 * 내용 : 공지사항 총 개수 구하기
	 */
	public int countNoticeAll() {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) from notice where ntc_delflag = 'N' order by ntc_no desc";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
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
	/*
	 * 51. 작성자 : 정명훈
	 * 내용 : 각 게시판에 보여줄 공지사항 가져오기 (allowview = Y 인 것만 가져오기) 
	 */
	public List<NoticeDTO> noticeListAllow() {
		List<NoticeDTO> list = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select n.*, to_char(ntc_date, 'YYYY-MM-DD HH24:MI') strdate, to_char(sysdate, 'YYYY-MM-DD') sysday, to_char(n.ntc_date, 'YYYY-MM-DD') ntcday, to_char(n.ntc_date, 'HH24:MI') as todaytime, (sysdate - n.ntc_date) as passingtime from notice n where ntc_allowview = 'Y' and ntc_delflag = 'N' order by ntc_no desc";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			while(rset.next()) {
				NoticeDTO n = new NoticeDTO();
				
				n.setNtcNo(rset.getInt("ntc_no"));
				n.setNtcTitle(rset.getString("ntc_title"));
				n.setNtcContent(rset.getString("ntc_content"));
				n.setNtcReadcnt(rset.getInt("ntc_readcnt"));
				
				boolean dateNew = false;
				Double passingTime = rset.getDouble("passingtime");
				String sysDay = rset.getString("sysday");
				String ntcDay = rset.getString("ntcday");
				
				if(passingTime <= 1.0) {
					dateNew = true;
					if(ntcDay.equals(sysDay)) {
						n.setNtcDate(rset.getString("todaytime"));
					}
					else {
						n.setNtcDate(rset.getString("strdate"));
					}
				}
				else {
					n.setNtcDate(rset.getString("strdate"));
				}
				
				n.setDateNew(dateNew);
				
				list.add(n);
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
		return list;
	}
	/*52. 작성자 : 박세준
	 * 내용 : 즐겨찾기한 개수 찾기*/
	public int countBasketAll(String userId) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) from basket where userId = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
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
	
	/*
	 * 53. 작성자 : 정명훈
	 * 내용 : 공지글 db 컬럼 ntc_allowview 수정 (공지게시판 제외한 게시판에서 보여줄 공지 목록)
	 */
	public int noticeUpdateAllowView(String ntcAllowView, int ntcNo) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "update notice set ntc_allowview = ? where ntc_no = ?";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, ntcAllowView);
			pstmt.setInt(2, ntcNo);
			
			result = pstmt.executeUpdate();
			
			if(result > 0) {
				conn.commit();
			}
			else {
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	
		
		return result;	
	}
	
	/*장선웅 : 46.신고테이블에 인서트*/
	public int insertReviewBoardReport(ReviewBoardReportDTO report) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query ="insert into reviewboard_report  values(seq_rb_reportno.nextval,?,?,?,?,?,?)";
		int result = 0;
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, report.getRbReportRbNo());
			pstmt.setString(2, report.getRbReportTitle());
			pstmt.setString(3, report.getRbReportSuspect());
			pstmt.setString(4, report.getRbReportWriter());
			pstmt.setString(5, report.getRbReportContent());
			pstmt.setString(6, report.getRbReportClasses());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			
		}
		return result;
	}

	/*장선웅 : 47. 신고내용이 insert 되면 리뷰보드 테이블에 rb_report를 +1 업데이트 해주기*/
	public int updateReviewBoardReport(int rbReportNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "update reviewboard set rb_report = rb_report+1 where rb_no= ?";
		int result = 0;
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rbReportNo);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return result;
	}



	/*
	 * 48.	장선웅 : 입력한 비밀번호와 알맞는 유저 찾기.
	 */
	public UserDTO checkedUserPassword(String userId, String userPassword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet res = null;
		String query ="select * from tempusertable where userid = ? and userpassword=?";
		UserDTO user = null;
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPassword);
			res= pstmt.executeQuery();
			user = new UserDTO();
			while(res.next()) {
				user.setUserId(res.getString("userId"));
				user.setUserName(res.getString("userName"));
				user.setUserEmail(res.getString("userEmail"));
				user.setUserNickName(res.getString("userNickName"));
				user.setUserGrade(res.getInt("usergrade"));
				user.setUserPoint(res.getInt("userpoint"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return user;
	}

	
	public int updateUser(String userId, String userPassword, String userEmail, String userNickName) {
		Connection conn = null;
		PreparedStatement pstmt =null;
		int result = 0;
		String query ="UPDATE  tempusertable SET userpassword = ?, useremail = ?, changedate = SYSDATE, usernickname = ? WHERE userid = ?";
		System.out.println("userId" + userId);
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userEmail);
			pstmt.setString(3, userNickName);
			pstmt.setString(4, userId);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
}

