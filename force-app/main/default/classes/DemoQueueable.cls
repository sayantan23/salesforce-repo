public class DemoQueueable implements Queueable {
    
    Account acc;
    String city;
    public DemoQueueable(Account account, String cityname){
        acc=account;
        city=cityname;
    }
    public void execute(QueueableContext context){
        Account cloneacc=acc.clone();
        cloneacc.Name='TestAccountFromQueueable';
        cloneacc.BillingCity=city;
        insert cloneacc; 
        invokeWeatherAPI(city);
        
    }
    
    public static HttpRequest createRequest(String cityName) {      
       // String url = 'http://api.weatherstack.com/current?access_key=7a51b58ddcce37cd145d9bd2aa3e608a&query='+cityName;
         String url = 'http://api.invalid.com/current?access_key=7a51b58ddcce37cd145d9bd2aa3e608a&query='+cityName;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        req.setTimeout(120000);
        return req;
    }
    
    @Future(callout=true)
    public static void invokeWeatherAPI(String cityName){

        Http httpCls = new Http();
        HttpRequest request = createRequest(cityName);
        HttpResponse response = httpCls.send(request);

        if(response.getStatusCode() == 200){
            System.debug('## Successfully retrieved Result' );
            System.debug('Response Body : '+response.getBody());
            WeatherResponse weatherResponse = (WeatherResponse) System.JSON.deserialize(response.getBody(), WeatherResponse.class);
            System.debug('Temperature = '+weatherResponse.current.temperature);
            System.debug('Wind Speed = '+weatherResponse.current.wind_speed);
            System.debug('Humidity = '+weatherResponse.current.humidity);
            System.debug('Feels Like = '+weatherResponse.current.feelslike);
           
        }
        else{
            throw new MyException('API Not Reachable');
        }

    }
    

}