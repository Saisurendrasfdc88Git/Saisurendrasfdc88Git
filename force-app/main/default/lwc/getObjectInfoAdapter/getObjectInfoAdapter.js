import { LightningElement,wire,api,track} from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';

export default class GetObjectInfoAdapter extends LightningElement {

  RecordTypeId;
  @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
  objectInfo({data,error}){
    if(data){
      console.log('Data',data);
      this.RecordTypeId = data.defaultRecordTypeId;
    }
    else{
      console.log('Error',error);
    }
  }



  //getPicklistvalues with recordTypeId
  @wire(getPicklistValues,{recordTypeId:'$RecordTypeId',fieldApiName:INDUSTRY_FIELD})
  industryPicklist({data,error}){
    if(data){
      console.log('getPicklistValues Data',data);
    }
   else{
    console.log('getPicklistValues Error',error);
   }
  }

  /*get recordTypeId() {
    // Returns a map of record type Ids
    const rtis = this.objectInfo.data.recordTypeInfos;
    console.log('rtis',rtis);
    return Object.keys(rtis).find((rti) => rtis[rti].name === "Special Account");
  }*/
}