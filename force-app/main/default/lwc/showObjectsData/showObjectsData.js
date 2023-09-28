import { LightningElement,wire } from 'lwc';
import getObjectNames from '@salesforce/apex/ObjectDropdownController.getObjectNames';
import getObjectFields from '@salesforce/apex/ObjectDropdownController.getObjectFields';
import getObjectData from '@salesforce/apex/ObjectDropdownController.getObjectData';

export default class ShowObjectsData extends LightningElement {

    selectedObject;
    objectOptions;
    selectedFields=[];
    fieldOptions;
    query;


    @wire(getObjectNames)
    wiredObjectNames({data,error}){
        if(data){
            this.objectOptions = data.map((objectName)=>{
                return {label : objectName ,value:objectName};
            });
           
        }
        else if(error){
            //handle the error if needed
        }
    }

    handleObjectChange(event){
        this.selectedObject = event.detail.value;
        this.fetchFieldsForSelectedObject();

    }

    fetchFieldsForSelectedObject(){
        if(this.selectedObject){
            getObjectFields({objectName : this.selectedObject})
            .then((result)=>{
                this.fieldOptions = result.map((field)=>{
                return {label : field , value : field}
            });
            })
            .catch((error)=>{
                  //handle the error if needed
            });

        }
        else{
            this.fieldOptions=[];
        }
    }
    handlefieldChange(event){
        this.selectedFields = event.detail.value;

    }
    handleBuildQuery(){
        if(this.selectedObject && this.selectedFields){
            const soqlQuery = `SELECT ${this.selectedFields.join(',')} FROM ${this.selectedObject}`;
            console.log(soqlQuery);
            this.query=soqlQuery;//store the query for display
            getObjectData({Query : soqlQuery})
            .then((result)=>{
                this.fieldData = result;
            })
            .catch((error)=>{
                //Handle the error if needed

            });

        }
        else{
            this.query='';
            this.fieldData=[];
        }
    }

}