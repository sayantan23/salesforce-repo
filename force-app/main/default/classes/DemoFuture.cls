public class DemoFuture {
    
    
    public static HttpRequest createRequest(String cityName) {      
       // String url = 'http://api.weatherstack.com/current?access_key=7a51b58ddcce37cd145d9bd2aa3e608a&query='+cityName;
         String url = 'http://api.invalid.com/current?access_key=7a51b58ddcce37cd145d9bd2aa3e608a&query='+cityName;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        req.setTimeout(120000);
        return req;
    }
    
    public static void processIt(){
        Id accId = insertAccount('New York');
        System.debug('Account inserted, Id = '+accId);
        invokeWeatherAPI('New York');
    }
    
    public static Id insertAccount(String cityName){
       Account acc=new Account();
        acc.Name='MyAccountForTestingFuture123';
        acc.BillingCity=cityName;
        insert acc; 
        return acc.Id;
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