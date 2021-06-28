*** Settings ***
Library  SeleniumLibrary
Library    String
Resource    ../Resource/automateRE.robot

Suite Setup     Run Keywords    automateRE.Opening browser
Suite Teardown    Run keyword    Close all Browsers

*** Variables ***
#${BROWSER}       Chrome     #Firefox
#${url}    http://www.automationpractice.com/

*** Test Cases ***
#robot -d Results Testdata/automate.robot
#robot -d Results -v BROWSER:FireFox Testdata/automate.robot
Registration
    [Documentation]    User is able to start registration from the ‘Sign in’ link in the header of the home page
    [Tags]    Reg
    automateRE.Click Sign In Button
    automateRE.Create an Account

Login to Account
    [Documentation]   User is logged in after successful registration
    ...    User is located on the ‘My Account’ page after successful registration
    automateRE.Login to Account     ${GENERATED_RANDOM_EMAIL}    ${GENERATED_RANDOM_PASSWORD}
#    automateRE.Sign Out
    capture page screenshot

#robot -d Results -i search Testdata/automate.robot
Product Search with the word Printed
    [Documentation]    User is able to search for products from the search bar on the home page
    ...    User only sees items that match the entered search term
    [Tags]    search
    automateRE.Search Product     Printed
    automateRE.Search result check


#robot -d Results -i add Testdata/automate.robot
Add products to cart from Popular tab on Home Page
    [Documentation]    User is able to add multiple items to the cart from the Popular tab on the Home Page
    ...    User sees message that the item has been successfully added to the cart
    ...    User sees product count updating in the cart on the Home Page
    ...    Upon navigating to the cart user sees the same items in the cart that were previously added
    ...    User sees the same quantity of items that were previously added
    ...    User sees the same price of items that were previously added
    [Tags]    add
    automateRE.Navigate To Homepage
    automateRE.Add 2 products to the cart and Verifying order at Checkout


Delete products from cart
    [Documentation]   User is able to delete items from the cart
    ...    User sees the TOTAL price amount decreasing
    ...    The reduction equals the price amount of the item that has been deleted
    ...    Whenever the last item is removed from the cart the page states that the shopping cart is empty
    automateRE.Product 1 delete
    automateRE.Product 2 delete
    automateRE.Sign Out


Purchase products with bank wire
    [Documentation]    User is able to successfully purchase products that have been added to the cart with bank wire
    ...    Upon order confirmation the order appears on the ‘MyOrders’ page
    ...    User sees the same ‘order reference’ that was given on order completion
    automateRE.Login to Account     ${GENERATED_RANDOM_EMAIL}    ${GENERATED_RANDOM_PASSWORD}
    automateRE.Add one product
    automateRE.Sign Out


