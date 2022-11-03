package kr.bike.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.bike.entity.Analysis;
import kr.bike.entity.Board;
import kr.bike.entity.Original;
import kr.bike.entity.User;
import kr.bike.mapper.BikeMapper;

@RestController
public class BikeRestController {
	@Autowired
	private BikeMapper bikemapper;

	@PostMapping("/fileload")
	public @ResponseBody Analysis fileLoad(String vr_title, HttpServletRequest request) {
		vr_title = vr_title.substring(vr_title.lastIndexOf("\\") + 1);
		Analysis avo = bikemapper.fileLoad(vr_title);
		System.out.println(vr_title);
		return avo;

	}

	@GetMapping("/boardList")
	public @ResponseBody List<Board> boardList() {

		List<Board> list = bikemapper.boardList();

		return list;
	}

	@GetMapping("/cloud")
	public @ResponseBody List<Original> cloudList() {
		List<Original> clist = bikemapper.cloudList();
		return clist;

	}

	@PostMapping("/idCheck")
	public User idCheck(String id, HttpServletRequest request) {
		User uid = bikemapper.idCheck(id);
		return uid;
	}
	
	@PostMapping("/insert")
	public void boardAjaxInsert(Board vo) {
		bikemapper.boardInsert(vo);
	}

}
