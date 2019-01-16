package com.brw.command.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.brw.command.Command;
import com.brw.dao.DAO;
import com.brw.dto.UserDTO;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

public class AdminMemberGradeUpdateCommand implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		
		DAO dao = DAO.getInstance();
		int result = 0;
		List<UserDTO> user = dao.selectMemberAll(1, 10000);
		if(!user.isEmpty()) {
			for(int i = 0; i<user.size(); i++) {
				result = dao.updateGrade(user.get(i).getUserId() , user.get(i).getUserPoint());
			}
		}
		
		Gson gson = new Gson();
		
		try {
			gson.toJson(result,response.getWriter());
		} catch (JsonIOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
