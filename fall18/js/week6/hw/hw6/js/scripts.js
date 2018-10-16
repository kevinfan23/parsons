// get the tooltip HTMLElement
let tooltip = document.getElementsByClassName('tip')[0];
let testList = document.getElementById('testList');

// add event listeners to the test list elements
for (let i = 0; i < testList.children.length; i++) {
  testList.children[i].addEventListener('mouseover', toggleTooltip);
  // hide tooltip when mouse not hovering
  testList.children[i].addEventListener('mouseleave', function(e){
    tooltip.style.display = 'none';
  });
}

// set tooltip configurations
function toggleTooltip(e) {
  tooltip.style.display = 'block';

  // set position
  let posX = e.target.getBoundingClientRect().x + e.target.getBoundingClientRect().width/2;
  let posY = e.target.getBoundingClientRect().y + e.target.getBoundingClientRect().height + 5;
  tooltip.style.left = posX + 'px';
  tooltip.style.top = posY + 'px';

  // set textContent
  let num = e.target.textContent;
  tooltip.textContent = 'This is a tooltip on ' + num;
}
