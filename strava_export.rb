require 'capybara/cuprite'
require 'capybara'

Capybara.register_driver(:cuprite) do |app|
  options = { headless: false, window_size: [1200, 800] }

  Capybara::Cuprite::Driver.new(app, options)
end

Capybara.javascript_driver = :cuprite

browser = Capybara::Session.new(:cuprite)

browser.visit 'https://connect.garmin.com/signin/'

sleep 2

browser.save_and_open_page
browser.current_url

# pp browser.body

# browser.within_frame('gauth-widget-frame-gauth-widget') do
  browser.fill_in :email, with: "#{ARGV[0]}"
  browser.fill_in :password, with: "#{ARGV[1]}"
  # browser.click_button 'Sign In'
  browser.execute_script "document.querySelector('.signin__form').querySelectorAll('button')[2].click()"
puts "clicked"
# end

sleep 20

browser.visit 'https://connect.garmin.com/modern/activities'

sleep 10

3.times do
  browser.execute_script "document.querySelector('.row-fluid.list-items.flexItemAutoHeight').scrollTop += 2000"
  sleep 4
end

sleep 10

ids = browser.all('.activity-name-edit > a').map { |x| x[:href].split('/').last }

def download(browser, id)
  browser.visit("https://connect.garmin.com/modern/proxy/download-service/files/activity/#{id}") rescue Ferrum::TimeoutError
end

browser.driver.add_headers('Content-Type' => 'application/octet-stream')
ids.each do |id|
  puts "Dowlonading #{id}"
  download(browser, id)
  sleep 1
end
