public with sharing class newsController {


    @AuraEnabled(cacheable=true)
    public static Map<string,Object> retriveNews(){

        HttpRequest req = new HttpRequest();
           req.setEndpoint('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=84b570bdf7454a608b58624b5453d7c9');
           req.setMethod('GET');

           Map<string,Object> newsJsonData = new Map<string,Object>();

           string strResponse=null;

           try {
            Http htp = new Http();
            HttpResponse res = htp.send(req);
            if(res.getStatusCode()==200){
                strResponse = res.getBody();
            }
            else {
                throw new CalloutException(res.getBody());
            }
        }
        catch(Exception ex){
            throw ex;
        }

        if(!string.isBlank(strResponse)){
            newsJsonData = (Map<string,Object>)JSON.deserializeUntyped(strResponse);
        }
        if(!newsJsonData.isEmpty()){
            return newsJsonData;
        }
        else{
            return null;
        }
    }
}
