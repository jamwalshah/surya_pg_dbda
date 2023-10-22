import java.io.*;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.fs.*;
import org.apache.hadoop.mapreduce.lib.input.*;
import org.apache.hadoop.mapreduce.lib.output.*;

//data - student
public class CityAvg2 {
	
	public static class CityMapClass extends Mapper<LongWritable,Text,Text,Text>
	   {
	   // private final static FloatWritable score = new FloatWritable();

	      public void map(LongWritable key, Text value, Context context)
	      {	    	  
	         try{
	        	 String[] str = value.toString().split(",");
	        	 context.write(new Text(str[3]),new Text(str[2]));
	            
	         }
	         catch(Exception e)
	         {
	            System.out.println(e.getMessage());
	         }
	      }
	   }

	public static class CityCombineClass extends Reducer<Text,Text,Text,Text>
	   {

		private final static Text result = new Text();

		public void reduce(Text key, Iterable<Text> values,Context context) throws IOException, InterruptedException {
		      int sum = 0;
		      int total = 0;
		      
		      
		         for (Text val : values)
		         {       	
		        	 sum += Integer.parseInt(val.toString());
		        	 total ++;
		         }

		         String str = String.format("%d,%d", sum, total);
		         result.set(str);   		      
		         context.write(key, result);
		      
		    }
	   
}


	  public static class CityReduceClass extends Reducer<Text,Text,Text,DoubleWritable>
	   {
	
		  private DoubleWritable result = new DoubleWritable();
		    
		    public void reduce(Text key, Iterable<Text> values,Context context) throws IOException, InterruptedException {
		      int sum = 0;
		      int total = 0;
		      double myavg = 0;
		      
		         for (Text val : values)
		         {       	
		        	 String[] str = val.toString().split(",");

		        	 sum += Integer.parseInt(str[0]);
		        	 total += Integer.parseInt(str[1]);
		         }
		         myavg = ((double)sum / (double) total);
		      
		         result.set(myavg);
		         context.write(key, result);
		      
		    }
	   }

	  public static void main(String[] args) throws Exception {
		    Configuration conf = new Configuration();
			conf.set("mapreduce.output.textoutputformat.separator", ",");
			Job job = Job.getInstance(conf, "Student average scores in each city");
		    job.setJarByClass(CityAvg2.class);
		    job.setMapperClass(CityMapClass.class);
		    job.setCombinerClass(CityCombineClass.class);
		    job.setReducerClass(CityReduceClass.class);
		    job.setMapOutputKeyClass(Text.class);
		    job.setMapOutputValueClass(Text.class);
		    job.setOutputKeyClass(Text.class);
		    job.setOutputValueClass(DoubleWritable.class);
		    job.setNumReduceTasks(1);

		    FileInputFormat.addInputPath(job, new Path(args[0]));
		    FileOutputFormat.setOutputPath(job, new Path(args[1]));
		    System.exit(job.waitForCompletion(true) ? 0 : 1);
		  }
}
