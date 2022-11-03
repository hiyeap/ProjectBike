package kr.bike.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Analysis {
	private String vo_num;
	private String vr_ill;
	private String vr_illtime;
	private String vr_long;
	private String vr_lati;
	private String vr_plate;
	private String vr_path;
	private String vr_title;
	private String vr_start;
	private String vr_end;
}
