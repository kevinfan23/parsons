//Some Global Variables to Hold Info for Later

// //Constructors for API URL Request. We'll use these later
// var baseURL = "https://ghibliapi.herokuapp.com";
// var films = "/films";
// var id1 = "/58611129-2dbc-4a81-a72f-77ddfc1b1b49";
// var fullURL = baseURL + films + id1;

//Pull in our HTML elements so we can talk to them using JS
var list = document.getElementById('list');

// runs whole function as soon as page opens. We wrap all our code in this function.
(function() {
  //Set Event listener on Button. When clicked, run the makeRequest function defined below
  document.addEventListener('DOMContentLoaded', makeRequest);

  //variable to hold httpRequest info
  var httpRequest;
  //makeRequest function runs when button is clicked
  function makeRequest() {
    httpRequest = new XMLHttpRequest();
    //If something is wrong with request, pop-up an alert that says so
    if (!httpRequest) {
      alert("It did not work :(");
      return false;
    }
    httpRequest.onreadystatechange = fillInfo;
    httpRequest.open(
      "GET", "http://api.openweathermap.org/data/2.5/group?id=3882428,5128638,6455259,2643743&units=imperial&APPID=dbe8f386e8912ae29af12afa2d7945e1"
    );
    httpRequest.send();
  }

  //Function that Runs When API Call is finished
  function fillInfo() {
    //variable to hold the response from API GET request
    var responseContent;
    var listArray = [];

    if (httpRequest.readyState === XMLHttpRequest.DONE) {
      if (httpRequest.status === 200) {
          // console.log(httpRequest.responseText);
          responseContent = JSON.parse(httpRequest.responseText);
          listArray = responseContent;


          var la_temp = Math.round(responseContent.list[0].main.temp);
          var ny_temp = Math.round(responseContent.list[1].main.temp);
          var ps_temp = Math.round(responseContent.list[2].main.temp);
          var ld_temp = Math.round(responseContent.list[3].main.temp);

          var lists = document.getElementsByClassName("temp");

          //console.log(responseContent.list[0].main.temp);
          lists[0].innerHTML = la_temp + '&deg;';
          lists[1].innerHTML = ny_temp + '&deg;';
          lists[2].innerHTML = ps_temp + '&deg;';
          lists[3].innerHTML = ld_temp + '&deg;';

          // for (var i = 0;i<responseContent.length;i++) {
          //   console.log(responseContent[i].title);
          //   var listItem = document.createElement('li');
          //   listItem.appendChild(document.createTextNode(responseContent[i].title));
          //   list.appendChild(listItem);
          // }

          /*Add results to a list*/

//         /*Save the response in responseContent variable.
//         Note that the response has ' ' around it. This means it is a String.*/
//         responseContent = httpRequest.responseText;
//         console.log(responseContent);
//         /*
//         Since responseContent is a string, we need to change it into an object
//         to use it. To do this, we can use JSON.parse. This parses or translates
//         a JSON object from a String.
//         */
//         var parsed = JSON.parse(responseContent);
//         //Now we can use the info the same way as an object.
//         console.log(parsed.title);
//         console.log(parsed.description);

//         /* Now lets update our actual HTML using this info.
//         We already have two variables, title and description which we
//         pulled into our code using document.getElementById() earlier.
//         We can update these variables with the information from the API
//         by using the .innerHTML command. */
//         title.innerHTML = parsed.title;
//         description.innerHTML = parsed.description;
      } else {
        alert("There was a problem with the request.");
      }
    }
  }
  //Make sure you ad the () after the end of the function.
})();
