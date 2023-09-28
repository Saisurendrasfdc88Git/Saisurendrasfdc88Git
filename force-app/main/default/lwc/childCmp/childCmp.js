import { LightningElement,api} from 'lwc';

export default class ChildCmp extends LightningElement {

searchKey;

handleChange(event){
    this.searchKey =event.target.value;

    const searchEvent = new CustomEvent("getsearchvalue",{
        detail: this.searchKey
    });
    this.dispatchEvent(searchEvent);

}

}