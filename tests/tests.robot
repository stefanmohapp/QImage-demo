*** Settings ***
Library                  QWeb
Library                  QImage
Suite Setup              OpenBrowser                 about:blank                 chrome
Suite Teardown           CloseAllBrowsers

*** Test Cases ***
Time
    OpenBrowser          https://time.is             chrome
    ClickText            Agree                       # dismiss cookie popup
    Sleep                3                           Wait for elements to load

    # in this case we take ref image first.
    # Normally we would have a saved image for reference.
    ${ref_image}=        LogScreenshot
    Sleep                10                          # Wait for screen to change
    ${current_image}=    LogScreenshot
    CompareImages        ${current_image}            ${ref_image}                mask-image.png     tolerance=0.5               # small threshold to make this pass
    CompareImages        ${current_image}            ${ref_image}                tolerance=0.99    # larger threshold to make this fail