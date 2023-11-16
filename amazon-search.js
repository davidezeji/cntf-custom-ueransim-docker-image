// Script which simulates a UE interacting with www.Amazon.com
/**
 * @name Amazon search
 *
 * @desc Looks for a "5G wireless guide" on amazon.com, goes two page two clicks the third one.
 */
const puppeteer = require('puppeteer-core')
const screenshot = '5g_reference_guide.png'
try {
  (async () => {
    const browser = await puppeteer.launch({
        headless: true,
        executablePath: process.env.CHROME_BIN || null,
        args: ['--no-sandbox', '--headless', '--disable-gpu', '--disable-dev-shm-usage']
    })
    const page = await browser.newPage()
    await page.setViewport({ width: 1280, height: 800 })
    await page.goto('https://www.amazon.com')
    await page.type('#twotabsearchtextbox', '5G wireless guide')
    await page.click('input.nav-input')
    await page.waitForSelector('#resultsCol')
    await page.screenshot({ path: '5g_reference_guide.png' })
    await page.click('#pagnNextString')
    await page.waitForSelector('#resultsCol')
    const pullovers = await page.$$('a.a-link-normal.a-text-normal')
    await pullovers[2].click()
    await page.waitForSelector('#ppd')
    await page.screenshot({ path: screenshot })
    await browser.close()
    console.log('See screenshot: ' + screenshot)
  })()
} catch (err) {
  console.error(err)
}

