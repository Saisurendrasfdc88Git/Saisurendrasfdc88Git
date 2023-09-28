import { LightningElement,api,wire,track} from 'lwc';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import NAME_FIELD from '@salesforce/schema/Account.Name';

export default class Git extends LightningElement {

Name;
@api recordId;

@wire(getRecord, {recordId:'$recordId',
     fields:[NAME_FIELD]})
     accountHandler({data}){
         if(data){
             console.log(data)
             this.Name = getFieldValue(data, NAME_FIELD)
             console.log(this.Name);
         }
     }
 }