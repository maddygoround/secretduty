const core = require("@actions/core");
const pip3 = require("pip3");
// const github = require("@actions/github");

try {
  // `who-to-greet` input defined in action metadata file
  const nameToGreet = core.getInput("who-to-greet");
  console.log(`Hello ${nameToGreet}!`);
  const time = new Date().toTimeString();
  pip3.install().then((success) => {
    if (success) {
      core.setOutput("time", time);
      console.log("pip3 has been succesfully installed!");
      pip3.exec("--version");
    } else {
      console.log("Installation of pip3 failed.");
    }
  });
  
  // Get the JSON webhook payload for the event that triggered the workflow
//   const payload = JSON.stringify(github.context.payload, undefined, 2);
//   console.log(`The event payload: ${payload}`);
} catch (error) {
console.log("hehehhe")
  core.setFailed(error.message);
}
