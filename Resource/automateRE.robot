*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Library    String

Variables    ../Resource/Locators/automatePO.py

*** Variables ***
${GENERATED_RANDOM_EMAIL}
${GENERATED_RANDOM_PASSWORD}
${URL}    http://www.automationpractice.com/
${BROWSER}      Chrome     #FireFox

*** Keywords ***
Opening browser
    open browser    ${URL}     ${BROWSER}
    maximize browser window

Click Sign In Button
    wait until element is visible     ${HOME_SEARCH_SIGN_IN_BUTTON}
    wait until element is enabled     ${HOME_SEARCH_SIGN_IN_BUTTON}
    click link     ${HOME_SEARCH_SIGN_IN_BUTTON}

Create an Account
    wait until element is visible    ${HOME_SIGN_IN_ACCOUNT_CREATE_EMAIL}
    wait until element is enabled    ${HOME_SIGN_IN_ACCOUNT_CREATE_EMAIL}
    ${ramdom}=    generate random string    6    [LETTERS]
    ${randomEmail}=    catenate    SEPARATOR=@    ${ramdom}    yahoo.com
    log    ${randomEmail}
    set global variable    ${GENERATED_RANDOM_EMAIL}      ${randomEmail}

    input text     ${HOME_SIGN_IN_ACCOUNT_CREATE_EMAIL}    ${randomEmail}
    wait until element is visible   ${HOME_SIGN_IN_ACCOUNT_CREATE_EMAIL_BUTTON}
    wait until element is enabled    ${HOME_SIGN_IN_ACCOUNT_CREATE_EMAIL_BUTTON}
    click button    ${HOME_SIGN_IN_ACCOUNT_CREATE_EMAIL_BUTTON}
    wait until element is visible    ${CREATE_ACCOUNT_TITLE_MR}         #Mr
    wait until element is enabled    ${CREATE_ACCOUNT_TITLE_MR}
    click button    ${CREATE_ACCOUNT_TITLE_MR}
    wait until element is enabled    xpath=//*[@id="customer_firstname"]      #First name
    input text    xpath=//*[@id="customer_firstname"]    John
    wait until element is enabled    xpath=//*[@id="customer_lastname"]      #Last name
    input text    xpath=//*[@id="customer_lastname"]    Doe
    capture page screenshot
    ${email}=  get value     xpath=//*[@id="email"]
    should be equal     ${email}      ${randomEmail}
    ${ramdomPassword}=    generate random string    12    [LETTERS]
    log    ${ramdomPassword}
    set global variable    ${GENERATED_RANDOM_PASSWORD}      ${ramdomPassword}
    wait until element is enabled    ${CREATE_ACCOUNT_PASSWORD}
    input password     ${CREATE_ACCOUNT_PASSWORD}    ${ramdomPassword}
    click element    ${CREATE_ACCOUNT_DATE_OF_BIRTH_DAY}                                  #Birthday    Day
    select from list by value        ${CREATE_ACCOUNT_DATE_OF_BIRTH_DAY}         11
    click element    ${CREATE_ACCOUNT_DATE_OF_BIRTH_MONTH}                                 #Birthday    Month    May
    select from list by value       ${CREATE_ACCOUNT_DATE_OF_BIRTH_MONTH}          5
    click element   ${CREATE_ACCOUNT_DATE_OF_BIRTH_YEAR}                                         #Birthday    Year
    select from list by value       ${CREATE_ACCOUNT_DATE_OF_BIRTH_YEAR}       2001
    select checkbox    newsletter                                            #Checkbox    newsletter
    select checkbox    optin                                                 #Checkbox   special offers from our partners
   #YOUR ADDRESS
    wait until element is enabled    ${YOUR_ADDRESS_FIRST_NAME}      #First name
    input text   ${YOUR_ADDRESS_FIRST_NAME}      John
    wait until element is enabled    ${YOUR_ADDRESS_LAST_NAME}           #Last name
    input text    ${YOUR_ADDRESS_LAST_NAME}    Doe
    wait until element is enabled    ${YOUR_ADDRESS_COMPANY}           #Company
    input text   ${YOUR_ADDRESS_COMPANY}      La Petite Boulangerie
    wait until element is enabled    ${YOUR_ADDRESS_ADDRESS_1}           #Address1
    input text    ${YOUR_ADDRESS_ADDRESS_1}     4009 Primrose Lane
    wait until element is enabled    ${YOUR_ADDRESS_ADDRESS_2}           #Address2
    input text    ${YOUR_ADDRESS_ADDRESS_2}     Apartment B, 2nd Floor
    wait until element is enabled    ${YOUR_ADDRESS_CITY}               #City
    input text     ${YOUR_ADDRESS_CITY}      Madison
    select from list by value   ${YOUR_ADDRESS_STATE}       49         #State Wisconsin
    wait until element is enabled    ${YOUR_ADDRESS_POSTAL_CODE}            # ZIP/Postal code
    input text    ${YOUR_ADDRESS_POSTAL_CODE}     53718
    select from list by value   ${YOUR_ADDRESS_COUNTRY}     21       #Country     USA
    capture page screenshot
    wait until element is enabled    ${YOUR_ADDRESS_ADD_INFO}               #Additional information
    input text   ${YOUR_ADDRESS_ADD_INFO}       Nothing to add
    wait until element is enabled    ${YOUR_ADDRESS_HOME_PHONE}             #Home phone
    input text   ${YOUR_ADDRESS_HOME_PHONE}     608-575-0327
    wait until element is enabled    ${YOUR_ADDRESS_MOBILE_PHONE}        #Mobile phone
    input text   ${YOUR_ADDRESS_MOBILE_PHONE}       920-219-7959
    wait until element is enabled    ${YOUR_ADDRESS_ADDRESS_ALIAS}               #Assign an address alias for future reference.
    input text   ${YOUR_ADDRESS_ADDRESS_ALIAS}       My_Address
    capture page screenshot
    wait until element is enabled    ${YOUR_ADDRESS_BUTTON_REGISTER}
    click button    ${YOUR_ADDRESS_BUTTON_REGISTER}
    page should contain    Welcome to your account. Here you can manage all of your personal information and orders.
    ${visibleName}=    get text    xpath=//*[@id="header"]/div[2]/div/div/nav/div[1]/a/span
    should be equal    ${visibleName}    John Doe
    Sign Out


Sign Out
    capture page screenshot
    execute javascript     window.scrollTo(750, 0)
    capture page screenshot
    sleep    2sec
    wait until element is visible    ${HEADER_SIGN_OUT_TAB}
    wait until element is enabled    ${HEADER_SIGN_OUT_TAB}
    click link    ${HEADER_SIGN_OUT_TAB}
    sleep    5sec
    wait until element is not visible    ${HEADER_SIGN_OUT_TAB}
    wait until element is visible     ${HEADER_SIGN_IN_TAB}
    capture page screenshot


Login to Account
    [Arguments]       ${email}    ${password}
    go to     ${url}
    capture page screenshot
    Click Sign In Button
    capture page screenshot
    wait until element is enabled    ${HOME_SIGN_IN_SIGNIN_EMAIL}     #sign in email address
    input text    ${HOME_SIGN_IN_SIGNIN_EMAIL}        ${email}
    wait until element is enabled    ${HOME_SIGN_IN_SIGNIN_PASSWORD}     #sign in password
    input text    ${HOME_SIGN_IN_SIGNIN_PASSWORD}        ${password}
    capture page screenshot
    wait until element is enabled    ${HOME_SIGN_IN_SIGNIN_BUTTON}     # Sign In Button
    click button    ${HOME_SIGN_IN_SIGNIN_BUTTON}
    ${MyAccount}=    get text    xpath=//*[@id="center_column"]/h1
    should be equal    MY ACCOUNT     ${MyAccount}
    ${visibleName}=    get text    xpath=//*[@id="header"]/div[2]/div/div/nav/div[1]/a/span
    should be equal    ${visibleName}    John Doe

Search Product
    [Arguments]    ${product}
    wait until element is enabled     ${HOME_SEARCH_BOX}   # search box on Home page
    wait until element is enabled     ${HOME_SEARCH_BUTTON}     # search button
    input text     ${HOME_SEARCH_BOX}     ${product}      # use the word `Printed` as a search term for simplicity
    click button    ${HOME_SEARCH_BUTTON}      # click search button

Search result check
    ${t}=    get text    xpath=//*[@id="center_column"]/ul
    log    ${t}
    ${searchResult}=    get count    ${t}    Printed
    ${searchResultOnWebsite}=    get text     xpath=//*[@id="center_column"]/h1/span[2]
    ${searchResultOnWebsite_sub}=   get substring    ${searchResultOnWebsite}        0     1
    log     ${searchResultOnWebsite_sub}
    ${converted_sub}=    convert to integer    ${searchResultOnWebsite_sub}
    should be equal     ${converted_sub}    ${searchResult}

Navigate To Homepage
     go to     ${URL}


Add 2 products to the cart and Verifying order at Checkout
    click element    ${HOME_POPULAR_TAB}     # click Popular Tab on Home page
    mouse over    ${HOME_PRODUCT_1_IMG}
    wait until element is visible    ${HOME_PRODUCT_1}
    wait until element is enabled    ${HOME_PRODUCT_1}
    mouse over    ${HOME_PRODUCT_1}
    click element    ${HOME_PRODUCT_1}     # add item 1 to the cart
    wait until element is enabled    ${HOME_POP_UP_WINDOW}   #pop up window
    page should contain     Product successfully added to your shopping cart
    wait until element is visible    ${HOME_CONTINOUE_SHOPPING_BUTTON}     #continue shopping button
    wait until element is enabled    ${HOME_CONTINOUE_SHOPPING_BUTTON}     #continue shopping button
    wait until element is visible    ${HOME_PROCEED_BUTTON}       # button proceed
    wait until element is enabled    ${HOME_PROCEED_BUTTON}       # button proceed
    capture page screenshot
    ${price1}=    get text     xpath=//*[@id="layer_cart_product_price"]
    log      ${price1}
    capture page screenshot
    ${quantity1}=    get text     xpath=//*[@id="layer_cart_product_quantity"]
    log      ${quantity1}
    ${product1}=     get text     xpath=//*[@id="layer_cart_product_title"]
    log     ${product1}
    capture page screenshot

    click element    ${HOME_CONTINOUE_SHOPPING_BUTTON}     # continoue shopping Button

    mouse over    ${HOME_PRODUCT_2_IMG}
    wait until element is visible    ${HOME_PRODUCT_2}
    wait until element is enabled    ${HOME_PRODUCT_2}
    click element    ${HOME_PRODUCT_2}
    wait until element is enabled    ${HOME_POP_UP_WINDOW}    #pop up window
    page should contain     Product successfully added to your shopping cart
    wait until element is visible    ${HOME_CONTINOUE_SHOPPING_BUTTON}     #continue shopping button
    wait until element is enabled    ${HOME_CONTINOUE_SHOPPING_BUTTON}      #continue shopping button
    wait until element is visible    ${HOME_PROCEED_BUTTON}       # button proceed
    wait until element is enabled    ${HOME_PROCEED_BUTTON}        # button proceed
    ${price2}=    get text     xpath=//*[@id="layer_cart_product_price"]
    log      ${price2}
    ${quantity2}=    get text     xpath=//*[@id="layer_cart_product_quantity"]
    log      ${quantity2}
    ${product2}=     get text     xpath=//*[@id="layer_cart_product_title"]
    log     ${product2}
    ${total_products_in_Cart}=    get text    xpath=//*[@id="layer_cart"]/div[1]/div[2]/div[1]/span
    log    ${total_products_in_Cart}

    click element    ${HOME_PROCEED_BUTTON}      # button proceed

    wait until element is visible    ${CART_SUMMARY_PROCEED_TO_CHECKOUT_BUTTON}      #proceed to checkout button
    wait until element is enabled    ${CART_SUMMARY_PROCEED_TO_CHECKOUT_BUTTON}      #proceed to checkout button
    page should contain    Shopping-cart summary
    ${quantityInCart}=    get text     xpath=//*[@id="summary_products_quantity"]
    ${sub}=   get substring    ${quantityInCart}        0     1
    log     ${sub}
    ${convertedQuantityInCart}= 	convert to integer     ${sub}
    ${total_quantity}=    evaluate  ${quantity1} + ${quantity2}
    should be equal     ${convertedQuantityInCart}     ${total_quantity}

    ${total_product_price}=     get text    xpath=//*[@id="total_product"]
    should be equal    ${total_product_price}     ${total_products_in_Cart}

    #product1
    ${product1_in_cart}=     get text    xpath=//*[contains(text(),"Faded Short Sleeve T-shirts")]
    should be equal    ${product1_in_cart}     ${product1}
    ${product1_price_in_cart}=    get text    xpath=/html/body/div/div[2]/div/div[3]/div/div[2]/table/tbody/tr[1]/td[4]/span/span
    should be equal    ${product1_price_in_cart}     ${price1}
    ${product1_quantity_in_cart}=    get value    xpath=/html/body/div/div[2]/div/div[3]/div/div[2]/table/tbody/tr[1]/td[5]/input[1]
    should be equal    ${product1_quantity_in_cart}     ${quantity1}
    #product2
    ${product2_in_cart}=     get text    xpath=/html/body/div/div[2]/div/div[3]/div/div[2]/table/tbody/tr[2]/td[2]/p/a
    should be equal    ${product2_in_cart}     ${product2}
    ${product2_price_in_cart}=    get text    xpath=/html/body/div/div[2]/div/div[3]/div/div[2]/table/tbody/tr[2]/td[4]/span/span
    should be equal    ${product2_price_in_cart}     ${price2}
    ${product2_quantity_in_cart}=    get value    xpath=/html/body/div/div[2]/div/div[3]/div/div[2]/table/tbody/tr[2]/td[5]/input[2]
    should be equal    ${product2_quantity_in_cart}     ${quantity1}

Product 1 delete
    click element    ${CART_SUMMARY_PRODUCT_DELETE_BUTTON_PRODUCT_1}     # click delete
    wait until element is not visible     xpath=//*[contains(text(),"Faded Short Sleeve T-shirts")]
    ${quantityInCart_after_delete}=    get text     xpath=//*[@id="summary_products_quantity"]
    ${sub1}=   get substring    ${quantityInCart_after_delete}        0     1
    log     ${sub1}
    capture page screenshot

Product 2 delete
    execute javascript     window.scrollTo(0, 750)
    capture page screenshot

    ${product2_price_in_cart}=    get text    xpath=/html/body/div/div[2]/div/div[3]/div/div[2]/table/tbody/tr/td[4]/span/span
    ${remainingTotalPrice}=    get text     xpath=//*[@id="total_product"]
    should be equal    ${product2_price_in_cart}     ${remainingTotalPrice}
    capture page screenshot
    wait until element is visible    ${CART_SUMMARY_PRODUCT_DELETE_BUTTON_PRODUCT_2}
    wait until element is enabled    ${CART_SUMMARY_PRODUCT_DELETE_BUTTON_PRODUCT_2}
    sleep     3sec
    click element    ${CART_SUMMARY_PRODUCT_DELETE_BUTTON_PRODUCT_2}      #2nd product delete
    wait until element is not visible     xpath=//*[contains(text(),"Blouse")]
    page should contain     Your shopping cart is empty.
    capture page screenshot

Add one product
    click element    ${HOME_YOUR_LOGO}       #top left corner -your logo
    click element    ${HOME_POPULAR_TAB}     # click Popular Tab on Home page
    mouse over    ${HOME_PRODUCT_1_IMG}       # select item 1 to add to the cart
    wait until element is visible    ${HOME_PRODUCT_1}
    wait until element is enabled    ${HOME_PRODUCT_1}
    mouse over    ${HOME_PRODUCT_1}
    click element    ${HOME_PRODUCT_1}     # add item 1 to the cart
    wait until element is enabled    ${HOME_POP_UP_WINDOW}     #pop up window
    page should contain     Product successfully added to your shopping cart
    wait until element is visible    ${HOME_CONTINOUE_SHOPPING_BUTTON}     #continue shopping button
    wait until element is enabled    ${HOME_CONTINOUE_SHOPPING_BUTTON}     #continue shopping button
    wait until element is visible    ${HOME_PROCEED_BUTTON}       # button proceed
    wait until element is enabled    ${HOME_PROCEED_BUTTON}       # button proceed
    capture page screenshot
    ${price1}=    get text     xpath=//*[@id="layer_cart_product_price"]
    log      ${price1}
    capture page screenshot
    ${quantity1}=    get text     xpath=//*[@id="layer_cart_product_quantity"]
    log      ${quantity1}
    ${product1}=     get text     xpath=//*[@id="layer_cart_product_title"]
    log     ${product1}
    capture page screenshot
    click element    ${HOME_PROCEED_BUTTON}       #xpath=//*[@id="layer_cart"]/div[1]/div[2]/div[4]/a
    execute javascript     window.scrollTo(0, 750)
    capture page screenshot
    wait until element is visible    ${CART_SUMMARY_PROCEED_TO_CHECKOUT_BUTTON}      #proceed to checkout button
    wait until element is enabled    ${CART_SUMMARY_PROCEED_TO_CHECKOUT_BUTTON}      #proceed to checkout button
    click element  ${CART_SUMMARY_PROCEED_TO_CHECKOUT_BUTTON}
    page should contain     Addresses
    wait until element is visible    ${CART_SUMMARY_ADDRESSES_PROCEED_TO_CHECKOUT_BUTTON}    #proceed to checkout button address
    wait until element is enabled    ${CART_SUMMARY_ADDRESSES_PROCEED_TO_CHECKOUT_BUTTON}
    click button    ${CART_SUMMARY_ADDRESSES_PROCEED_TO_CHECKOUT_BUTTON}
    page should contain     Shipping
    click element    ${CART_SUMMARY_SHIPPING_TERM_OF_SERVICE_CHECKBOX}       #terms of service
    wait until element is visible    ${CART_SUMMARY_SHIPPING_PROCEED_TO_CHECKOUT_BUTTON}     #proceed to checkout button shipping
    wait until element is enabled    ${CART_SUMMARY_SHIPPING_PROCEED_TO_CHECKOUT_BUTTON}
    click button     ${CART_SUMMARY_SHIPPING_PROCEED_TO_CHECKOUT_BUTTON}
    page should contain    Please choose your payment method
    execute javascript     window.scrollTo(0, 750)
    click link    ${CART_SUMMARY_BANKWIRE}      #bankwire
    page should contain    Bank-wire payment.
    wait until element is visible    ${ORDER_SUMMARY_CONFIRM_BUTTON}
    wait until element is enabled    ${ORDER_SUMMARY_CONFIRM_BUTTON}
    click button    ${ORDER_SUMMARY_CONFIRM_BUTTON}              # confirm order
    page should contain    Order confirmation
    #On Order Confirmation the order reference number is received
    ${order reference}=    get text    xpath=//*[@id="center_column"]/div     #order reference
    log    ${order reference}
    click element     ${BACK_TO_ORDERS_BUTTON}      # back to orders
    #On Order history we check whether the order confirmation is also present/visible
    page should contain    Order history
    ${OrderRef}=    get text     xpath=//*[@id="order-list"]/tbody/tr/td[1]/a
    log    ${OrderRef}
    should match      ${order reference}      *${OrderRef}*

