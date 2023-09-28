public class ObjectDropdownController {

@AuraEnabled(cacheable=true)
public static list<string> getObjectNames(){
    
map<string,schema.SObjectType> gd = schema.getGlobalDescribe();
    //retrieve all objects names with the help of schema.getGlobalDescribe
    list<string> objectNames = new list<string>();
    for(string sObj : gd.Keyset()){
        objectNames.add(sObj);
    } 
    return objectNames;
    
}

@AuraEnabled(cacheable=true)
public static list<string> getObjectFields(string objectName){
    list<string> fieldNames = new list<string> ();
    map<string,schema.SObjectType> gd = schema.getGlobalDescribe();
    schema.SObjectType objectType = gd.get(objectName);
    if(objectType != null){
        Schema.DescribeSObjectResult describeResult = objectType.getDescribe();
        map<string,schema.SObjectField> fieldMap = describeResult.fields.getMap();
    for(string fieldName : fieldMap.Keyset()){
        fieldnames.add(fieldName);
    }
    }
    return fieldNames;
}


public static list<string> getObjectData(string Query){

    list<sObject> records = Database.query(Query);
    list<string> fieldData = new list<string>();
for(SObject record : records){
for(string field : record.getSObjectType().getDescribe().fields.getMap().keyset()){
        fieldData.add(field+':'+string.valueOf(record.get(field)));
}
}
return fieldData;



}
}