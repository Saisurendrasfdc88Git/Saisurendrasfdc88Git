import { LightningElement,track } from 'lwc';

export default class CurrentDateTime extends LightningElement {

    @track currentDateTime;

    connectedCallback(){
        this.updateCurrentDateTime();
        this.refreshIntervel = setInterval(()=>this.updateCurrentDateTime(),1000);
    }
disconnectedCallback(){
    clearInterval(this.refreshIntervel);
}


updateCurrentDateTime(){
    const now = new Date();
    this.currentDateTime=now.toLocaleString();

}
}