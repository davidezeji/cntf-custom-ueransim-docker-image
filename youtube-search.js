/**
 * @name Youtube search
 *
 * @desc  Looks for Iron Maiden's "Invaders" video on youtube.com and clicks on the third video.
 * Waits for 5 seconds for the video to load.
 */

const puppeteer = require('puppeteer-core')
const screenshot = 'youtube_invaders_video.png'

const os = require('os');

//get the IP of the eth0 interface so we can tell puppeteer to ignore it
function getInterfaceIp(interfaceName) {
    const networkInterfaces = os.networkInterfaces();
    const interfaceDetails = networkInterfaces[interfaceName];

    if (!interfaceDetails) {
        console.log(`No such interface: ${interfaceName}`);
        return null;
    }

    for (let details of interfaceDetails) {
        if (details.family === 'IPv4') {
            return details.address;
        }
    }

    console.log(`No IPv4 address found for interface: ${interfaceName}`);
    return null;
}

const ipAddress = getInterfaceIp('eth0');
console.log(`IP address of eth0: ${ipAddress}`);

try {
  (async () => {
    const browser = await puppeteer.launch({
        headless: true,
        executablePath: process.env.CHROME_BIN || null,
        args: ['--no-sandbox', '--headless', '--disable-gpu', '--disable-dev-shm-usage', '--netifs-to-ignore=${ipAddress}']
    })
    const page = await browser.newPage()
    await page.goto('https://youtube.com')
    await page.type('input#search', 'Iron Maiden Invaders')
    await page.click('button#search-icon-legacy')
    await page.waitForSelector('ytd-thumbnail.ytd-video-renderer')
    await page.waitForTimeout(500)
    await page.screenshot({ path: 'youtube_invaders_video.png' })
    const videos = await page.$$('ytd-thumbnail.ytd-video-renderer')
    await videos[2].click()
    await page.waitForSelector('.html5-video-container')
    await page.waitForTimeout(5000)
    await page.screenshot({ path: screenshot })
    await browser.close()
    console.log('See screenshot: ' + screenshot)
  })()
} catch (err) {
  console.error(err)
}