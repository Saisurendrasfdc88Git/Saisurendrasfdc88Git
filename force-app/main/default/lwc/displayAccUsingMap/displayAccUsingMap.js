import { LightningElement,wire,track,api} from 'lwc';
import getAccLocations from '@salesforce/apex/DisplayAccUsingMapController.getLocations'
import City from '@salesforce/schema/Lead.City';

export default class DisplayAccUsingMap extends LightningElement {

@api recordId;
@track error;
@track accName='Dheeraj';
@track mapMarkers=[];
@track zoomLevel=4;
@track markersTitle='';

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