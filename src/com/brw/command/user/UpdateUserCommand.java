package com.brw.command.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.UserDTO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;

public class UpdateUserCommand implements Command{

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) {
      //인코딩 처리
      try {
         request.setCharacterEncoding("utf-8");
      } catch (UnsupportedEncodingException e1) {
         // TODO Auto-generated catch block
         e1.printStackTrace();
      }
      response.setContentType("application/json; charset=utf-8");
      
      //파라미터 처리
      String userId = request.getParameter("userId");
      String userPassword= request.getParameter("userPassword");
      String userEmail = request.getParameter("userEmail");
      String userNickName = request.getParameter("userNickName");
      
      UserDTO pwd_result = DAO.getInstance().selectOneUser(userId);
      PrintWriter out = null;
      if(pwd_result.getUserPassword().equals(userPassword)) {
    	  try {
    		System.out.println("$UpdateUserCommand() 업데이트 수정 pwd_over 로 들어오니?");
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	  out.append("pwd_over");
          System.out.println("너 설마 여기오니?");
		  return;
      }
      
      DAO dao = DAO.getInstance();
      int result = dao.updateUser(userId,userPassword,userEmail,userNickName);
      
      Gson gson = new Gson();
   
      try {
         if(result>0) {//업데이트 성공            
            gson.toJson(userEmail,response.getWriter());
         }
      } catch (JsonIOException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } catch (IOException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }

      System.out.println("변경하면 여기까지오나? ㅇㅈ? ㅇ ㅇㅈ");
      
      // 현재 사용중인 세션을 반환
      HttpSession session = request.getSession(true);
      UserDTO user = (UserDTO)session.getAttribute("user");
      
      // 변경된 이메일과 닉네임을 세션에 저장
      user.setUserEmail(userEmail);
      user.setUserNickName(userNickName);
      
      session.setAttribute("user", user);
   }
}