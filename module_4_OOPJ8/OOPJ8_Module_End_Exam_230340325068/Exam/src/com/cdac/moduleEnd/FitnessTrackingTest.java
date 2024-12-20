package com.cdac.moduleEnd;

class ValueException extends Exception{
	public ValueException(String msg) {
		super(msg);
	}
}

class FitnessTracker{
	String WorkoutDuration;
	String Distance;
	

//	public FitnessTracker(String workoutDuration, String distance) throws NumberFormatException, NullPointerException, ValueException   
//	{
//		super();
//		this.ValidateValues(workoutDuration, distance);
//		try {
//			Double wod = Double.parseDouble(workoutDuration);
//			if(wod>0) {
//				this.WorkoutDuration = String.valueOf(wod);
//			}
//			else {
//				throw new ValueException("WorkoutDuration is negative or zero");
//			}
//
//		} catch (ValueException e) {
//			System.out.println("Exception caught in setWorkoutDuration: "+e.getMessage());
//		}
//		catch (NullPointerException npe) {
//			System.out.println("Exception caught in setWorkoutDuration: "+npe.getMessage());
//		}
//		catch (NumberFormatException nfe) {
//			System.out.println("Exception caught in setWorkoutDuration: "+nfe.getMessage());
//		}
////		this.setWorkoutDuration(workoutDuration);
////		WorkoutDuration = workoutDuration;
//		try {
//			Double dist = Double.parseDouble(distance);
//			if(dist>0) {
//				this.Distance = String.valueOf(dist);
//			}
//			else {
//				throw new ValueException("Distance is negative or zero");
//			}
//		}  catch (ValueException e) {
//			System.out.println("Exception caught in setDistance: "+e.getMessage());
//		}catch (NullPointerException npe) {
//			System.out.println("Exception caught in setDistance: "+npe.getMessage());
//		}
//		catch (NumberFormatException nfe) {
//			System.out.println("Exception caught in setDistance: "+nfe.getMessage());
//		}
////		this.setDistance(distance);
////		Distance = distance;
//	}

	public FitnessTracker() {
		// TODO Auto-generated constructor stub
	}

	

	@Override
	public String toString() {
		return "FitnessTracker [WorkoutDuration=" + WorkoutDuration + ", Distance=" + Distance + "]";
	}

	void ValidateValues(String workoutString, String distString)
	{
		try {
			Double wod = Double.parseDouble(workoutString);
			if(wod>0) {
				this.WorkoutDuration = String.valueOf(wod);
			}
			else {
				throw new ValueException("WorkoutDuration is negative or zero");
			}

		} catch (ValueException e) {
			System.out.println("Exception caught in setWorkoutDuration: "+e.getMessage());
		}
		catch (NullPointerException npe) {
			System.out.println("Exception caught in setWorkoutDuration: "+npe.getMessage());
		}
		catch (NumberFormatException nfe) {
			System.out.println("Exception caught in setWorkoutDuration: "+nfe.getMessage());
		}
		
		try {
			Double dist = Double.parseDouble(distString);
			if(dist>0) {
				this.Distance = String.valueOf(dist);
			}
			else {
				throw new ValueException("Distance is negative or zero");
			}
		}  catch (ValueException e) {
			System.out.println("Exception caught in setDistance: "+e.getMessage());
		}catch (NullPointerException npe) {
			System.out.println("Exception caught in setDistance: "+npe.getMessage());
		}
		catch (NumberFormatException nfe) {
			System.out.println("Exception caught in setDistance: "+nfe.getMessage());
		}
		
	}

}

public class FitnessTrackingTest {
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String wo, dis;
		wo="56";
		dis="100";
		FitnessTracker ft1 = new FitnessTracker();
		ft1.ValidateValues("56", "100");
		System.out.println(ft1.toString());
		
		FitnessTracker ft2 = new FitnessTracker();
		ft2.ValidateValues("-1", "00");
		System.out.println(ft2.toString());
		

	}

}
