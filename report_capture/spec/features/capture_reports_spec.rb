require 'spec_helper'

username = ENV["CHEVENING_USERNAME"] || "Username"
password = ENV["CHEVENING_PASSWORD"] || "Password"
siteLabel = ENV["CHEVENING_SITE_LABEL"] || "ATS - Chevening"
userLabel = ENV["CHEVENING_USER_LABEL"] || "Username"
passwordLabel = ENV["CHEVENING_PASSWORD_LABEL"] || "Password"
userField = ENV["CHEVENING_USER_FIELD"] || "user"
passwordField = ENV["CHEVENING_PASSWORD_FIELD"] || "password"
loginButton = ENV["CHEVENING_LOGIN_BUTTON"] || "Login"
viewAllReportsLink = ENV["CHEVENING_VIEW_ALL_LINK"] || "View All Reports"
statisticsLink = ENV["CHEVENING_STATISTICS_LINK"] || "Statistics"
applicationReportLink = ENV["CHEVENING_APPLICATION_LINK"] || "Application report"
preScreeningReportLink = ENV["CHEVENING_PRE_SCREENING_LINK"] || "Pre-Screening Report"
viewButton = ENV["CHEVENING_VIEW_BUTTON"] || "View"
applicationReportContent1 = ENV["CHEVENING_APPLICATION_CONTENT1"] || "Application report"
applicationReportContent2 = ENV["CHEVENING_APPLICATION_CONTENT2"] || "Counting Applications"
applicationReportContent3 = ENV["CHEVENING_APPLICATION_CONTENT3"] || "Main status"
preScreeningReportContent1 = ENV["CHEVENING_PRE_SCREENING_CONTENT1"] || "Pre-Screening Report"
preScreeningReportContent2 = ENV["CHEVENING_PRE_SCREENING_CONTENT2"] || "Counting Applications"
preScreeningReportContent3 = ENV["CHEVENING_PRE_SCREENING_CONTENT3"] || "Main status"

applicationReportFile = ENV["CHEVENING_APPLICATION_FILE"] || "ApplicationReport"
preScreeningReportFile = ENV["CHEVENING_PRE_SCREENING_FILE"] || "PreScreeningReport"
outputFileExtension = ENV["CHEVENING_OUTPUT_EXTENSION"] || ".html"
dateLabel = Time.now.strftime("%Y%m%d")

  describe "Capture Reports", :js => true, :type => :feature  do
  
    it 'Go to the login page, log in, view reports, choose report, view report and save the page' do
    
      visit ''
      
      puts "Reached Login page"
      page.should have_content(siteLabel)
      page.should have_content(userLabel)
      page.should have_content(passwordLabel)
      page.should have_content(loginButton)
      
      # page.save_page overwrites the existing file
      #page.save_page('login.html')
      
      fill_in 'user', :with => username
      fill_in 'password', :with => password
      click_on loginButton
      
      page.should have_content(statisticsLink)
      # page.save_page overwrites the existing file
      #page.save_page('dashboard.html')
      
      if not (page.has_content?(viewAllReportsLink))
        click_link statisticsLink
      end
      
      page.should have_content(viewAllReportsLink)
      click_link viewAllReportsLink
      
      page.should have_content(applicationReportLink)
      # page.save_page overwrites the existing file
      # page.save_page('reportList.html')
      
      find('td', :text => applicationReportLink).click
      click_on(viewButton)
      

      page.should have_content(applicationReportContent1)
      page.should have_content(applicationReportContent2)
      page.should have_content(applicationReportContent3)
      
      # page.save_page overwrites the existing file
      page.save_page(applicationReportFile + dateLabel + outputFileExtension)
      
      click_link viewAllReportsLink
      
      page.should have_content(preScreeningReportLink)
      
      find('td', :text => preScreeningReportLink).click
      click_on(viewButton)
      

      page.should have_content(preScreeningReportContent1)
      page.should have_content(preScreeningReportContent2)
      page.should have_content(preScreeningReportContent3)
      
      # page.save_page overwrites the existing file
      page.save_page(preScreeningReportFile + dateLabel + outputFileExtension)
    end
  end
 