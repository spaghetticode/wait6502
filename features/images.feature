Feature: Manage Images
	In order to pubish images for computers and peripherals
	As a logged user
	I want to manage computers and peripherals images
	
	Background:
		Given I am logged in as user
		And   I have a computer named "Amiga 1000"
		And   I have a peripheral named "DuoDisk"
		
	Scenario: Only logged users can access Images area
		Given I am logged out
		When  I go to the "Amiga 1000" computer images page
		Then I should see "You must be logged in to access this page"
	
	Scenario: Listing Images
		Given I uploaded an image titled "Inner view" for "Amiga 1000" computer
		And   I am on the "Amiga 1000" computer editor page
		When  I follow "Images"
		Then  I should see "Amiga 1000 Images"
		And   I should see "Inner view"
		And   I should see "New image"
	
	Scenario: Adding Images
		Given I am on the "Amiga 1000" computer editor page
		And   I follow "Images"
		And   I follow "New image"
		When  I fill in "Title" with "Amiga 1000 image"
		And   I fill in "Caption" with "Something about the Amiga 1000"
		And   I attach a valid image
		And   I press "Create"
		Then  I should see "Image was successfully created"
		And   I should see "Amiga 1000 image"
		And   I should see "Something about the Amiga 1000"
		And   I should be on the "Amiga 1000" computer images page
	
	Scenario: Removing Images
		Given I uploaded an image titled "Front view" for "DuoDisk" peripheral
		And   I am on the "DuoDisk" peripheral images page
		When  I follow "destroy"
		Then  I should see "Image was successfully destroyed"
		And   I should be on the "DuoDisk" peripheral images page
		And   I should not see "Front view"
	