import java.io.IOException;
import java.util.StringTokenizer;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.Reducer.Context;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
public class AvgClosingPrice {
	public static class MappingClass extends Mapper<LongWritable, Text, Text,DoubleWritable>{
		public void map(LongWritable Key, Text value, Context context) throws IOException, InterruptedException {
			 String[] str= value.toString().split(",");
			 double closing = Double.parseDouble(str[6]);
			 context.write(new Text(str[1]),new DoubleWritable(closing));
		}
	}

	public static class ReducingClass extends Reducer<Text,DoubleWritable,Text,DoubleWritable> {
		public void reduce(Text key, Iterable<DoubleWritable> values,Context context) throws IOException, InterruptedException {
			DoubleWritable resultval = new DoubleWritable();
			double sum = 0;
			double count = 0;
			for (DoubleWritable val : values) {
				sum +=val.get();
				count++;
			}
			double avg = sum/count;
			resultval.set(avg);
			context.write(key, resultval);
		}
	}

	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		Job job = Job.getInstance(conf, " Average Closing Price ");
		job.setJarByClass(AvgClosingPrice.class);
		job.setMapperClass(MappingClass.class);
		job.setReducerClass(ReducingClass.class);
		job.setNumReduceTasks(1);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(DoubleWritable.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(DoubleWritable.class);
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}