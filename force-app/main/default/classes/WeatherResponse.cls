public class WeatherResponse {

	public Request request;
	public Location location;
	public Current current;

	public class Request {
		public String type;
		public String query;
		public String language;
		public String unit;
	}

	public class Current {
		public String observation_time;
		public Integer temperature;
		public Integer weather_code;
		public List<String> weather_icons;
		public List<String> weather_descriptions;
		public Integer wind_speed;
		public Integer wind_degree;
		public String wind_dir;
		public Integer pressure;
		public Integer precip;
		public Integer humidity;
		public Integer cloudcover;
		public Integer feelslike;
		public Integer uv_index;
		public Integer visibility;
		public String is_day;
	}

	public class Location {
		public String name;
		public String country;
		public String region;
		public String lat;
		public String lon;
		public String timezone_id;
		public String localtime;
		public Integer localtime_epoch;
		public String utc_offset;
	}

	
	public static WeatherResponse parse(String json) {
		return (WeatherResponse) System.JSON.deserialize(json, WeatherResponse.class);
	}
}