// Building an AI Assistant
const ans = {
  weather: "The weather right now is 73 degrees",
  rain: "It is unlikely to rain today",
  time: "The time now is 4:00pm",
  "my favorite food": "Hi, your favorite food is taco",
  "your favorite food": "Hi, my favorite food is electricity",
  "your name": "Hi, my name is Alexi",
  order: "Scheduling an delivery right now...",
  coffee: "There is a great coffee shop on 14st street!",
  "how are you": "Thanks for asking. I'm doing great!",
  null: "Sorry I cannot find an answer to that question..."
}

// Checking questions in O(n)
function checkAnswer(question) {
  for (key in ans) {
    if (question.includes(key)) {
      return key;
    }
  }
  return null;
}

// find answers based on ans object keys
let question = prompt("Ask me anything");
console.log(ans[checkAnswer(question)]);
