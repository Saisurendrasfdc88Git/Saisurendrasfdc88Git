import { LightningElement } from 'lwc';

export default class FetchApi extends LightningElement {
    imgURL;
    endpoint = 'https://some-random-api.ml/animal/dog';

    getImageHandler() {
        fetch(this.endpoint, { method: 'GET' })
            .then(resp => resp.json())
            .then(resp => {
                this.imgURL = resp.image;
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    }
}
