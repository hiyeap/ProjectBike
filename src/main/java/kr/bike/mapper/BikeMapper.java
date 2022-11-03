package kr.bike.mapper;

import java.util.List;

import kr.bike.entity.Analysis;
import kr.bike.entity.Board;
import kr.bike.entity.Original;
import kr.bike.entity.User;

public interface BikeMapper {

	public User userLogin(User uvo);

	public int userJoin(User uvo);

	public Analysis fileLoad(String vr_title);

	public List<Board> boardList();

	public List<Original> cloudList();

	public User idCheck(String id);
	
	public void boardInsert(Board vo);
}
