package kr.bike.controller;

import java.awt.print.Book;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.bike.mapper.BikeMapper;
import kr.bike.entity.Analysis;
import kr.bike.entity.User;
import kr.bike.mapper.BikeMapper;

@Controller
public class BikeController {
	@Autowired
	private BikeMapper bikemapper;
	
	@GetMapping("/main.do")
	public String main() {
		return "main";
	}
	
	
	@PostMapping("/join.do")
	public String userJoin(User uvo, HttpServletRequest request) {
		bikemapper.userJoin(uvo);
		return "redirect:/main.do";
	}
	
	@PostMapping("/login.do")
	public String userLogin(User uvo, HttpServletRequest request) {
		User vo = bikemapper.userLogin(uvo);
		if(vo!=null) {
		HttpSession session = request.getSession();
		session.setAttribute("uvo", vo);
		}
		return "redirect:/main.do";
	}
	
	@PostMapping("/logout.do")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/main.do";
	}
	

}
