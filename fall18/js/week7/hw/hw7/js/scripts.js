'use strict';

let alert_overlay = document.getElementsByClassName('warning-overlay')[0];
let alert_form = document.getElementsByClassName('warning-form')[0];
let alert_message = alert_form.children[0];
let form = document.forms.price_input;
let start_geo = {
  lat: '',
  lng: ''
};
let end_geo = {
  lat: '',
  lng: ''
};

let uber_data = {
  uber_x: {
    driver_eta: 0,
    duration_estimate: '',
    price_estimate: ''
  },
  uber_pool: {
    driver_eta: 0,
    duration_estimate: '',
    price_estimate: ''
  },
  uber_black: {
    driver_eta: 0,
    duration_estimate: '',
    price_estimate: ''
  }
};

let lyft_data = {
  lyft: {
    driver_eta: 0,
    duration_estimate: '',
    price_estimate: ''
  },
  lyft_line: {
    driver_eta: 0,
    duration_estimate: '',
    price_estimate: ''
  },
  lyft_plus: {
    driver_eta: 0,
    duration_estimate: '',
    price_estimate: ''
  }
};

document.addEventListener("DOMContentLoaded", function() {
    document.forms.price_input.addEventListener('submit', clickSubmit);
    alert_overlay.addEventListener('click', function() {
      alert_overlay.classList.remove('alert');
      alert_form.classList.remove('alert');
    });

    // add event listener to dialog buttons
    document.getElementsByClassName('dismiss')[0].addEventListener('click', function() {
      alert_overlay.classList.remove('alert');
      alert_form.classList.remove('alert');
    });

    document.getElementsByClassName('restart')[0].addEventListener('click', function() {
      // reset the form when click on restart
      form.reset();
      alert_overlay.classList.remove('alert');
      alert_form.classList.remove('alert');
    });
});

// solution 1: XMLHttpRequest async callbacks
function clickSubmit(e) {
  e.preventDefault();
  let start = form.start.value;
  let end = form.end.value;

  if (!(start && end)) {
    alertHandler('alert');
  }
  else {
    let start_str = start.split(' ').join('%20');
    let end_str = end.split(' ').join('%20');

    const xhr_start = new XMLHttpRequest();
    let base_url='https://maps.googleapis.com/maps/api/geocode/json';
    let key = 'AIzaSyDIjoTqEJADVj-kj33OTqDmv2iX044QsyI';
    let key_str = '&key=' + key;
    // let url = 'https://maps.googleapis.com/maps/api/geocode/json?&address=centralpark&key=AIzaSyDIjoTqEJADVj-kj33OTqDmv2iX044QsyI'
    let url = base_url + '?&address=' + start_str + key_str;
    xhr_start.open("GET", url);
    xhr_start.send();
    xhr_start.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        let json = JSON.parse(xhr_start.responseText);
        // console.log(json);
        // console.log(json.results[0].geometry.location);
        start_geo.lat = json.results[0].geometry.location.lat;
        start_geo.lng = json.results[0].geometry.location.lng;

        const xhr_end = new XMLHttpRequest();
        let url = base_url + '?&address=' + end_str + key_str;
        xhr_end.open("GET", url);
        xhr_end.send();
        xhr_end.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            let json = JSON.parse(xhr_end.responseText);
            end_geo.lat = json.results[0].geometry.location.lat;
            end_geo.lng = json.results[0].geometry.location.lng;
            console.log(start_geo);
            console.log(end_geo);

            const xhr_uber_price = new XMLHttpRequest();
            let base_url='https://api.uber.com/v1.2/estimates/price?';
            let token = 'qRJfM0XMGwi9Y2O7Iv5Jbt9tRK6_bP13ZXG6CNtd';
            // let url = 'https://api.uber.com/v1.2/estimates/price?start_latitude=37.7752315&start_longitude=-122.418075&end_latitude=37.7752415&end_longitude=-122.518075'

            let url = base_url + 'start_latitude=' + start_geo.lat + '&start_longitude=' + start_geo.lng + '&end_latitude=' + end_geo.lat + '&end_longitude=' + end_geo.lng;
            xhr_uber_price.open("GET", url);
            xhr_uber_price.setRequestHeader('Authorization', 'Token ' + token )
            xhr_uber_price.send();
            xhr_uber_price.onreadystatechange = function() {
              if (this.readyState == 4 && this.status == 200) {
                let json = JSON.parse(xhr_uber_price.responseText);
                json.prices.forEach(function(price) {
                  switch (price.localized_display_name) {
                    case 'UberX':
                      uber_data.uber_x.price_estimate = price.estimate;
                      uber_data.uber_x.duration_estimate = price.duration;
                      break;
                    case 'UberPool':
                      uber_data.uber_pool.price_estimate = price.estimate;
                      uber_data.uber_pool.duration_estimate = price.duration;
                      break;
                    case 'Black':
                      uber_data.uber_black.price_estimate = price.estimate;
                      uber_data.uber_black.duration_estimate = price.duration;
                      break;
                    default:
                      break;
                  }
                });


                const xhr_uber_time = new XMLHttpRequest();
                let base_url='https://api.uber.com/v1.2/estimates/time?';
                let token = 'qRJfM0XMGwi9Y2O7Iv5Jbt9tRK6_bP13ZXG6CNtd';
                // let url = 'https://api.uber.com/v1.2/estimates/price?start_latitude=37.7752315&start_longitude=-122.418075&end_latitude=37.7752415&end_longitude=-122.518075'

                let url = base_url + 'start_latitude=' + start_geo.lat + '&start_longitude=' + start_geo.lng;
                xhr_uber_time.open("GET", url);
                xhr_uber_time.setRequestHeader('Authorization', 'Token ' + token )
                xhr_uber_time.send();
                xhr_uber_time.onreadystatechange = function() {
                  if (this.readyState == 4 && this.status == 200) {
                    let json = JSON.parse(xhr_uber_time.responseText);
                    json.times.forEach(function(time) {
                      switch (time.localized_display_name) {
                        case 'UberX':
                          uber_data.uber_x.driver_eta = time.estimate;
                          break;
                        case 'UberPool':
                          uber_data.uber_pool.driver_eta = time.estimate;
                          break;
                        case 'Black':
                          uber_data.uber_black.driver_eta = time.estimate;
                          break;
                        default:
                          break;
                      }
                    });
                    // console.log(uber_data);
                    let uber_price_fields = document.querySelectorAll('.uber .ride-list .price');
                    let uber_eta_fields = document.querySelectorAll('.uber .ride-list .eta');

                    uber_price_fields[0].textContent = uber_data.uber_x.price_estimate;
                    uber_price_fields[1].textContent = uber_data.uber_pool.price_estimate;
                    uber_price_fields[2].textContent = uber_data.uber_black.price_estimate;

                    uber_eta_fields[0].textContent = formatTime(uber_data.uber_x.driver_eta + uber_data.uber_x.duration_estimate);
                    uber_eta_fields[1].textContent = formatTime(uber_data.uber_pool.driver_eta + uber_data.uber_x.duration_estimate)
                    uber_eta_fields[2].textContent = formatTime(uber_data.uber_black.driver_eta + uber_data.uber_x.duration_estimate);

                    const xhr_lyft_price = new XMLHttpRequest();
                    let base_url='https://api.lyft.com/v1/cost?';
                    let token = 'OaUiUkNFaoA2B9LSg945pr2DHrGlSJ1MGa0Q+C3N18B7ldGBHluIj5ebXJIkBbjV+BAfVGxq2Mfi1DmqkCPysH8jFvhB7S+jSyC9XGlOFhSpVJv3npO2ZfM=';
                    let url = base_url + 'start_lat=' + start_geo.lat + '&start_lng=' + start_geo.lng + '&end_lat=' + end_geo.lat + '&end_lng=' + end_geo.lng;
                    xhr_lyft_price.open("GET", url);
                    xhr_lyft_price.setRequestHeader('Authorization', 'bearer ' + token )
                    xhr_lyft_price.send();
                    xhr_lyft_price.onreadystatechange = function() {
                      if (this.readyState == 4 && this.status == 200) {
                        let json = JSON.parse(xhr_lyft_price.responseText);
                        json.cost_estimates.forEach(function(price) {
                          switch (price.ride_type) {
                            case 'lyft':
                              lyft_data.lyft.price_estimate = '$' + Math.round(price.estimated_cost_cents_min/100) + '-' + Math.round(price.estimated_cost_cents_max/100);
                              lyft_data.lyft.duration_estimate = price.estimated_duration_seconds;
                              break;
                            case 'lyft_line':
                              lyft_data.lyft_line.price_estimate = '$' + Math.round(price.estimated_cost_cents_min/100) + '-' + Math.round(price.estimated_cost_cents_max/100);
                              lyft_data.lyft_line.duration_estimate = price.estimated_duration_seconds;
                              break;
                            case 'lyft_plus':
                              lyft_data.lyft_plus.price_estimate = '$' + Math.round(price.estimated_cost_cents_min/100) + '-' + Math.round(price.estimated_cost_cents_max/100);
                              lyft_data.lyft_plus.duration_estimate = price.estimated_duration_seconds;
                              break;
                            default:
                              break;
                          }
                        });

                        const xhr_lyft_time = new XMLHttpRequest();
                        let base_url='https://api.lyft.com/v1/eta?';
                        let token = 'OaUiUkNFaoA2B9LSg945pr2DHrGlSJ1MGa0Q+C3N18B7ldGBHluIj5ebXJIkBbjV+BAfVGxq2Mfi1DmqkCPysH8jFvhB7S+jSyC9XGlOFhSpVJv3npO2ZfM=';
                        // let url = 'https://api.lyft.com/v1.2/estimates/price?start_latitude=37.7752315&start_longitude=-122.418075&end_latitude=37.7752415&end_longitude=-122.518075'

                        let url = base_url + 'lat=' + start_geo.lat + '&lng=' + start_geo.lng;
                        xhr_lyft_time.open("GET", url);
                        xhr_lyft_time.setRequestHeader('Authorization', 'bearer ' + token )
                        xhr_lyft_time.send();
                        xhr_lyft_time.onreadystatechange = function() {
                          if (this.readyState == 4 && this.status == 200) {
                            let json = JSON.parse(xhr_lyft_time.responseText);
                            console.log(json.eta_estimates[0].eta_seconds);
                            json.eta_estimates.forEach(function(eta) {
                              switch (eta.ride_type) {
                                case 'lyft':
                                  lyft_data.lyft.driver_eta = eta.eta_seconds;
                                  break;
                                case 'lyft_line':
                                  lyft_data.lyft_line.driver_eta = eta.eta_seconds;
                                  break;
                                case 'lyft_plus':
                                  lyft_data.lyft_plus.driver_eta = eta.eta_seconds;
                                  break;
                                default:
                                  break;
                              }
                            });
                            console.log(lyft_data);
                            let lyft_price_fields = document.querySelectorAll('.lyft .ride-list .price');
                            let lyft_eta_fields = document.querySelectorAll('.lyft .ride-list .eta');

                            lyft_price_fields[0].textContent = lyft_data.lyft.price_estimate;
                            lyft_price_fields[1].textContent = lyft_data.lyft_line.price_estimate;
                            lyft_price_fields[2].textContent = lyft_data.lyft_plus.price_estimate;

                            lyft_eta_fields[0].textContent = formatTime(lyft_data.lyft.driver_eta + lyft_data.lyft.duration_estimate);
                            lyft_eta_fields[1].textContent = formatTime(lyft_data.lyft_line.driver_eta + lyft_data.lyft_line.duration_estimate)
                            lyft_eta_fields[2].textContent = formatTime(lyft_data.lyft_plus.driver_eta + lyft_data.lyft_plus.duration_estimate);
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

function alertHandler(type) {
  if (type === 'dialog') {
    alert_message.textContent = '😔  Sorry...I can\'t find da wae';
    alert_overlay.classList.add('alert');
    alert_form.classList.add('alert');
  }
  else if (type === 'alert') {
    alert_message.textContent = '😢 Hmmm I don\'t know where to go'
    alert_overlay.classList.add('alert');
    alert_form.classList.add('alert');
  }
  else {

  }
}

function formatTime(sec) {
  let date = new Date();
  date.setSeconds(date.getSeconds() + sec);
  let time_str = date.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true }).toLowerCase().replace(/\s/g, '');
  return time_str;
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
