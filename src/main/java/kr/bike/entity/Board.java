package kr.bike.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board {
	private int bo_num;
	private String vr_ill;
	private String bo_date;
	private String name;
}
