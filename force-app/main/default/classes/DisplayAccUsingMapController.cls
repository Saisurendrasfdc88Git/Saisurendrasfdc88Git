public with sharing class DisplayAccUsingMapController {
    
@AuraEnabled(cacheable=true)
public static list<account> getLocations(String accountName){

    string str = accountName+'%';

    return [SELECT Id,Name,BillingStreet,BillingState,BillingPostalCode,BillingCity,BillingCountry,
    shippingCity,ShippingPostalCode,shippingCountry,shippingSate,shippingStreet
     FROM account
     WHERE Name LIKE : str];
}
}