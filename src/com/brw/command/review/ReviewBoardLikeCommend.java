package com.brw.command.review;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.ReviewBoardLikeDTO;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class ReviewBoardLikeCommend implements Command{

	@Override
	//좋아요 처리 하는곳
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		//인코딩 처리 
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		response.setContentType("application/json; charset=utf-8");
		//파라미터 처리
		int rbNo =Integer.parseInt(request.getParameter("rbNo"));
		String userId = request.getParameter("userId");
		//좋아요 총갯수
		int maxLike = 0;
		
		DAO dao = DAO.getInstance();
		//셀렉트 리스트를 가져옴
		List<ReviewBoardLikeDTO> likeList = dao.selectAllReviewBoardLike(rbNo,userId);
		//인서트 , 업데이트 결과값에 쓸 변수
		System.out.println(likeList);
		int result = 0;
		//셀렉트한 테이블의 값이 비엇으면이면 인서트 , 그게아니라면 카운터를 0으로 업데이트
		if(likeList.isEmpty()) {
			System.out.println("왓니?");
			result = dao.insertReviewBoardLike(rbNo, userId);
		}else {
			System.out.println("아아");
			result = dao.deleteReviewBoardLike(rbNo, userId);
		}
		maxLike = dao.selectLikeCount();
		Gson gson = new Gson();
		
		try {
			gson.toJson(maxLike,response.getWriter());
		} catch (JsonIOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}

}
