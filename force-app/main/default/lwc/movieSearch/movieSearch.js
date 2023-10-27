import { LightningElement } from 'lwc';
const DELAY = 300;

export default class MovieSearch extends LightningElement {


selectedType=" ";
selectedSearch=" ";
selectedPageNo="1";
loading=false;
delayTimeOut;


get typeOptions() {
    return [
        { label: 'None', value: '' },
        { label: 'Movie', value: 'movie' },
        { label: 'Series', value: 'series' },
        { label: 'Episode', value: 'episode' },
    ];
}

handleChange(event){
    let{name,value} = event.target;
    this.loading=true;
    if(name === 'type'){
        this.selectedType=value;
    }
    else if(name === 'search'){
        this.selectedSearch=value;
    }else if(name === 'pageNo'){
        this.selectedPageNo=value;
    }
    //debouncing
    clearTimeout(this.delayTimeOut);
this.delayTimeOut = setTimeout(()=>{
this.searchMovie();
},DELAY) ;    
}

//this method will search for the entered movie
//const url = 'https://www.omdbapi.com/?s=Batman&page=2'
async searchMovie(){
 const url=`https://www.omdbapi.com/?s=${this.selectedSearch}&type=${this.selectedType}&page=${this.selectedPageNo}&apikey=d2e0dd62`;
    const res = await fetch(url);
    const data = await res.json();
    console.log("Movie Search Output",data);
}
}