require("dotenv").config();
const { IgApiClient } = require('instagram-private-api');
const { get } = require('request-promise');
// const CronJob = require("cron").CronJob;
const postToInsta = async () => {
const ig = new IgApiClient();
ig.state.generateDevice(process.env.IG_USERNAME);
await ig.account.login(process.env.IG_USERNAME, process.env.IG_PASSWORD);
// 
const imageBuffer = await get({
url: 'https://aa.aeniks.com/wordimg/akimbo.jpg',
encoding: null, 
});
// 
await ig.publish.photo({
file: imageBuffer,
caption: 'with hands on hips and elbows bent outward',
// nice caption (optional)
});
}
// 
postToInsta();
// 
// 
// const cronInsta = new CronJob("30 * * * * *", async () => {
// postToInsta();
// }); 
// cronInsta.start();
