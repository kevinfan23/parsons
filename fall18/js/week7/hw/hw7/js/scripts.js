document.addEventListener("DOMContentLoaded", function() {
    document.forms.price_input.addEventListener('submit', clickSubmit);

});

function clickSubmit(e) {
  e.preventDefault();

  let form = document.forms.price_input;

  let start = form.start.value;
  let end = form.end.value;

  if (!(start && end)) {
    alert('start and destination cannot be empty');
  }
  else {
    const xhr = new XMLHttpRequest();
    let baseUrl='https://maps.googleapis.com/maps/api/geocode/json';
    let key = 'AIzaSyDIjoTqEJADVj-kj33OTqDmv2iX044QsyI';
    let keyStr = '?key=' + key;
    let url = 'https://maps.googleapis.com/maps/api/geocode/json?&address=centralpark&key=AIzaSyDIjoTqEJADVj-kj33OTqDmv2iX044QsyI'
    xhr.open("GET", url);
    xhr.send();
    xhr.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        let json = JSON.parse(xhr.responseText);
        console.log(json.results[0].geometry)
      }
    }
  }
}

// let xhr = new XMLHttpRequest();
//   let user = {}; // create an empty object
//   user.name = form.first_name.value + ' ' + form.last_name.value;
//   console.log(user, JSON.stringify(user));
//   xhr.onreadystatechange = function() {
//     if (xhr.readyState === 4 ) {
//       if (xhr.status === 200 || xhr.status === 201) {
//         let resp = JSON.parse(xhr.response);
//         document.getElementById("Output").innerHTML = "Successfully
// created id: "+resp.id;
// } else {
//         document.getElementById("Output").innerHTML = "There was an
// error";
// } }
// }
