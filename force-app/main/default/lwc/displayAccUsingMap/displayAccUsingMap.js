import { LightningElement,wire,track,api} from 'lwc';
import getAccLocations from '@salesforce/apex/DisplayAccUsingMapController.getLocations'
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import NAME_FIELD from '@salesforce/schema/Account.Name';
export default class DisplayAccUsingMap extends LightningElement {
@api recordId;
@track error;
@track accName
@track mapMarkers=[];
@track zoomLevel=4;
@track markersTitle='';

@wire(getRecord, {recordId:'$recordId',
     fields:[NAME_FIELD]})
     accountHandler({data}){
         if(data){
             console.log(data)
             this.accName = getFieldValue(data, NAME_FIELD)
             console.log(this.accName);
         }
     }

@wire(getAccLocations,{accountName : '$accName'})
wiredLocations({data,error}){
    if(data){
        data.forEach(dataItem => {
            this.mapMarkers=[...this.mapMarkers,
            {
                location:{
                    City : dataItem.BillingCity,
                    Country : dataItem.BillingCountry,
                },
                icon:'custom:custom26',
                title:dataItem.Name,
            },
            {
            location : {
                city : dataItem.ShippingCity,
                postalCode:dataItem.ShippingPostalCode,
                State: dataItem.ShippingState,
                Street:dataItem.ShippingStreet,
            },
            icon: 'custom:custom26',
            title:dataItem.Name
        },
        ];   
        });
        this.error = undefined;
    }
    else if(error){
        this.error=error;
    }
}   
}