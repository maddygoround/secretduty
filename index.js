const core = require("@actions/core");
const {setupPython} = require("./src/setup-python");
// const github = require("@actions/github");

(async()=> {
try {
  // `who-to-greet` input defined in action metadata file
  const nameToGreet = core.getInput("who-to-greet");
  console.log(`Hello ${nameToGreet}!`);
  const time = new Date().toTimeString();
  await setupPython("3.7.5");

  // Get the JSON webhook payload for the event that triggered the workflow
  //   const payload = JSON.stringify(github.context.payload, undefined, 2);
  //   console.log(`The event payload: ${payload}`);
} catch (error) {
  console.log("hehehhe");
  core.setFailed(error.message);
}
})();

