package kr.bike.entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Original {
	private String id;
	private String vo_num;
	private String vo_title;
	private String vo_time;
	private String vo_date;
	private String vo_path;
	
}
