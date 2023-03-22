trigger AccountTrigger on Account (before update, after update) {
    
    if(Trigger.isBefore){
        for(Account acc : Trigger.New){
            if(acc.DunsNumber == null) {
                acc.DunsNumber = '123456789';
            }
    	}	
    }
    
    if(Trigger.isAfter){
        for(Account acc : Trigger.New){
            DemoFuture.invokeWeatherAPI('New York');
    	}	
    }    
    
}