package hive;

import java.util.Date;
import java.text.DateFormat;
import org.apache.hadoop.hive.ql.exec.UDF; 
import org.apache.hadoop.io.Text;

public class UnixtimeToDate extends UDF{
	public Text evaluate(Text text){
		if(text==null) return null;
		long timestamp = Long.parseLong(text.toString());
		return new Text(toDate(timestamp));
	}
	private String toDate(long timestamp) {
		Date date = new Date (timestamp);
		return DateFormat.getInstance().format(date).toString();
	}
}