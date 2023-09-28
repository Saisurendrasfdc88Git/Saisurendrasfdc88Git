import { LightningElement,track } from 'lwc';

export default class ParentCmp extends LightningElement {
    @track searchValue;
    handleSearchValue(event){
        this.searchValue = event.detail;

    }

}