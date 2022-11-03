package kr.bike.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {

	private String id;
	private String pw;
	private String bb_num;
	private String name;
	private String rrn;
	private String phone;
	private String address;
	
	
	
}
