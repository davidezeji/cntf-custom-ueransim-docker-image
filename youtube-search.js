/**
 * @name Youtube search
 *
 * @desc  Looks for Iron Maiden's "Invaders" video on youtube.com and clicks on the third video.
 * Waits for 5 seconds for the video to load.
 */
const puppeteer = require('puppeteer-core')
const screenshot = 'youtube_invaders_video.png'
try {
  (async () => {
    const browser = await puppeteer.launch({
        headless: true,
        executablePath: process.env.CHROME_BIN || null,
        args: ['--no-sandbox', '--headless', '--disable-gpu', '--disable-dev-shm-usage']
    })
    const page = await browser.newPage()
    await page.goto('https://youtube.com')
    // await page.waitForSelector('#search')
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