# Schema Clarification Questions

## Table: businesses

1. Could you clarify the business meaning of the 'country' field?

**Answer: It represents the country the business/merchant is located at** 

2. How is the 'taxrate' field stored? As a decimal (0.15 for 15%) or as a whole number (15 for 15%)?

**Answer: decimal** 

3. What currency is the 'storeswithfixedsupplierprice' field stored in? Is this field in cents or full currency units?

**Answer: it's not a currency field, it capture the stores with fixed supplier price. so it's strings with storeid, separated by comma** 

4. What currency is the 'issupplierpricefixedforallstores' field stored in? Is this field in cents or full currency units?

**Answer: it's a true false field** 

5. What type of code is stored in 'defaulttaxcode'? What are some example values?

**Answer: example 534e078473efd4cdf636d578. can be blank too** 

6. What are the possible values for the 'status' field? Is this a numeric code, text string, or boolean?

**Answer: Active, Pending, or blank** 

7. What are the possible values for the 'subscriptionstatus' field? Is this a numeric code, text string, or boolean?

**Answer: strings. Possible values are Active, Expired, Trial or blanks. This field is the most important field to help us identify the subscription status of the business** 

8. Could you clarify the business meaning of the 'subscriptionid' field?

**Answer: the subscription ID for the business, as per Chargebee's subscription ID** 

9. Could you clarify the business meaning of the 'chargebeecustomerid' field?

**Answer:** 

10. Could you clarify the business meaning of the 'planid' field?

**Answer: defines the plan type the business is on. String values. Examples like large_annually, large_month, medium_annually, small_monthly_php, etc** 

11. Could you clarify the business meaning of the 'addonids' field?

**Answer: shows the addons merchants subscribed to (which is on top of their main subscription plan), it lists all addonids and separated by comma** 

12. What are the possible types/categories for the 'creditcardtype' field?

**Answer: so far I only see master, mastercard, visa and blanks** 

13. Could you clarify the business meaning of the 'maskedcardnumber' field?

**Answer: it's the masked credit card number that the merchant added to their backoffice** 

14. Could you clarify the business meaning of the 'plivoauthid' field?

**Answer:** 

15. Could you clarify the business meaning of the 'plivoauthtoken' field?

**Answer:** 

16. Could you clarify the business meaning of the 'assigntableid' field?

**Answer:** 

17. Could you clarify the business meaning of the 'integrationapitoken' field?

**Answer:. I think it might be related to the API token merchant needs when they need to integrate with any third party platform or something** 

18. How is the 'separatekitchenitems' field stored? As a decimal (0.15 for 15%) or as a whole number (15 for 15%)?

**Answer: it's a true false field** 

19. Could you clarify the business meaning of the 'ordersummaryprinter' field?

**Answer:** 

20. Could you clarify the business meaning of the 'autoorderid' field?

**Answer:** 

21. Could you clarify the business meaning of the 'paidregisters' field?

**Answer:** 

22. Could you clarify the business meaning of the 'hascreditedreferrer' field?

**Answer:** 

23. What currency is the 'totalsubfeepaid' field stored in? Is this field in cents or full currency units?

**Answer:** 

24. How is the 'servicechargerate' field stored? As a decimal (0.15 for 15%) or as a whole number (15 for 15%)?

**Answer: decimal** 

25. Could you clarify the business meaning of the 'othermposenabled' field?

**Answer:** 

26. Could you clarify the business meaning of the 'disableddefaultpayments' field?

**Answer:** 

27. What are the possible values for the 'businessstatus' field? Is this a numeric code, text string, or boolean?

**Answer:** 

28. What are the possible types/categories for the 'businesstype' field?

**Answer: this is like a industry field, with possible values like Bar, Cafe, Restaurant, retail, etc. The values can be quite messy with not consistent uppercase or lowercase usage and even misspelling** 

29. What are the possible types/categories for the 'hasdevicetype' field?

**Answer:** 

30. Could you clarify the business meaning of the 'sequentialreceiptnumber' field?

**Answer:** 

31. Could you clarify the business meaning of the 'paidextraregisters' field?

**Answer: it's the extra register license addon quantity** 

32. Could you clarify the business meaning of the 'paidextrastores' field?

**Answer: it's extra store license addon quantity (if no extra store addon, by default each non-base plan account has 1 paid store license). We have something called base plans, which is 0 subscription fee and renews monthly, they purely sign up to use our Beep product and we earn transaction fee from these merchants** 

33. Could you clarify the business meaning of the 'numberofstores' field?

**Answer:** 

34. What type of code is stored in 'sqlaccoutingcode'? What are some example values?

**Answer:** 

35. What type of code is stored in 'autocountaccountingcode'? What are some example values?

**Answer:** 

36. Could you clarify the business meaning of the 'hubspotdealid' field?

**Answer:** 

37. What does the abbreviated field name 'mrr' stand for?

**Answer: monthly recurring revenue** 

38. Could you clarify the business meaning of the 'isqrorderingenabled' field?

**Answer: whether the merchant enabled the QR Ordering feature** 

39. Could you clarify the business meaning of the 'lastenableqrorderingdate' field?

**Answer: the last timestamp where merchant enabled the QR Ordering feature** 

40. Could you clarify the business meaning of the 'firstenableqrorderingdate' field?

**Answer: the earliest timestamp where merchant enabled the QR Ordering feature** 

41. Could you clarify the business meaning of the 'claimcashbackcountperday' field?

**Answer:** 

42. Could you clarify the business meaning of the 'facebookid' field?

**Answer:** 

43. Could you clarify the business meaning of the 'cashbackclaimtrailcount' field?

**Answer:** 

44. What currency is the 'cashbackclaimtopuptotal' field stored in? Is this field in cents or full currency units?

**Answer:** 

45. Could you clarify the business meaning of the 'cashbackclaimautorefill' field?

**Answer:** 

46. Could you clarify the business meaning of the 'enableonlinestorefeature' field?

**Answer:** 

47. Could you clarify the business meaning of the 'enableqrorderingfeature' field?

**Answer: whether the merchant has access to use Beep feature in Backoffice** 

48. Could you clarify the business meaning of the 'ongoingsubscriptionorderid' field?

**Answer:** 

49. Could you clarify the business meaning of the 'advanceinvoiceid' field?

**Answer:** 

50. Could you clarify the business meaning of the 'allowanonymousqrordering' field?

**Answer:** 

51. Could you clarify the business meaning of the 'campaignenabledtime' field?

**Answer: it's the first Engage active campaign setup time in unix timestamp format (Engage is a SMS marketing tool feature our company has where merchants can purchase as addon on top of their main subscription)** 

52. What does the abbreviated field name '_id' stand for?

**Answer: unique business id** 

53. Could you clarify the business meaning of the 'autosmscreditsdiscountinfoid' field?

**Answer:** 

54. What currency is the 'smscreditsavgcost' field stored in? Is this field in cents or full currency units?

**Answer:** 

55. Could you clarify the business meaning of the 'cashbackexpirationduration.durationnumber' field?

**Answer: it's the cashback expiry setting (based on the duration unit)** 

56. What type of code is stored in 'lastmaxbarcode'? What are some example values?

**Answer:** 

---

## Table: businesses__paymentoptions

1. What does the double underscore notation ('businesses__paymentoptions') represent in our schema? Is this a nested/related table structure?

**Answer: yes it's a nested table within the businesses table** 

2. Could you clarify the business meaning of the 'paymentid' field?

**Answer: just a payment id field for each pyment method in record. Not a super useful field** 

3. What are the possible types/categories for the 'type' field?

**Answer: NFC, custom, paymentTerminal, qrCode, or blanks** 

4. Could you clarify the business meaning of the 'additionalinfo' field?

**Answer: additional important info for the payment method. For example, a string including qr provider for type = qrCode** 

5. Could you clarify the business meaning of the 'isdisabled' field?

**Answer: whether the payment option is currently disabled** 

6. Could you clarify the business meaning of the 'ordering' field?

**Answer:** 

7. What does the abbreviated field name '_id' stand for?

**Answer: the unique id field in this table** 

---

## Table: businesses__qrorderingsettings

1. What does the double underscore notation ('businesses__qrorderingsettings') represent in our schema? Is this a nested/related table structure?

**Answer: this is a nested table of the businesses table** 

2. Could you clarify the business meaning of the 'minimumconsumption' field?

**Answer:** 

3. Could you clarify the business meaning of the 'enabledelivery' field?

**Answer: whether Beep Delivery is enabled** 

4. Could you clarify the business meaning of the 'firstenabledeliverydate' field?

**Answer: the first timestamp where Beep Delivery is enabled** 

5. Could you clarify the business meaning of the 'validdays' field?

**Answer: operating days of the business on Beep Delivery (1 = Sunday, 2 = Monday and so on)** 

6. Could you clarify the business meaning of the 'validtimefrom' field?

**Answer: opening hours of the day (start time)** 

7. Could you clarify the business meaning of the 'validtimeto' field?

**Answer: opening hours of the day (closing time)** 

8. Could you clarify the business meaning of the 'defaultshippingzoneid' field?

**Answer:** 

9. Could you clarify the business meaning of the 'defaultshippingzonemethodid' field?

**Answer:** 

10. Could you clarify the business meaning of the 'enablepreorder' field?

**Answer: Whether the function of preorder is enabled** 

11. Could you clarify the business meaning of the 'firstenablepreorderdeliverydate' field?

**Answer: the timestamp where the preorder function was first enabled** 

12. Could you clarify the business meaning of the 'disabletodaypreorder' field?

**Answer:** 

13. Could you clarify the business meaning of the 'hidefrombeepcom' field?

**Answer:** 

14. Could you clarify the business meaning of the 'storesenabledpaybycash' field?

**Answer: stores (store ID) that are using the QR pay at counter feature** 

15. Could you clarify the business meaning of the 'storesenabledpaylater' field?

**Answer: stores (store ID) that are using the QR paylater feature** 

16. What does the abbreviated field name '_id' stand for?

**Answer: the unique id in this table** 

---

## Table: businesses__stores

1. What does the double underscore notation ('businesses__stores') represent in our schema? Is this a nested/related table structure?

**Answer: it's a nested table of the businesses table** 

2. Could you clarify the business meaning of the 'country' field?

**Answer: the country where the store is located** 

3. What type of code is stored in 'postalcode'? What are some example values?

**Answer: the postal code of the store address, eg. 41050 for Klang (MY) location stores.** 

4. What does the abbreviated field name 'fax' stand for?

**Answer:** 

5. Could you clarify the business meaning of the 'gstid' field?

**Answer:** 

6. Could you clarify the business meaning of the 'sstid' field?

**Answer:** 

7. What does the abbreviated field name 'brn' stand for?

**Answer: the business registration number of the merchant** 

8. Could you clarify the business meaning of the 'confirmbirtoken' field?

**Answer:** 

9. Could you clarify the business meaning of the 'ordernotificationemail' field?

**Answer:** 

10. Could you clarify the business meaning of the 'paidordernotification' field?

**Answer:** 

11. Could you clarify the business meaning of the 'pendingpaymentordernotification' field?

**Answer:** 

12. Could you clarify the business meaning of the 'pendingverificationordernotification' field?

**Answer:** 

13. Could you clarify the business meaning of the 'enabledigital' field?

**Answer: virtual store to sell vouchers** 

14. What does the abbreviated field name '_id' stand for?

**Answer: the unique store id** 

15. Could you clarify the business meaning of the 'ismallintegrationenabled' field?

**Answer: whether mall integration is enabled** 

---

## Table: customers

1. Could you clarify the business meaning of the 'customerid' field?

**Answer: the customer ID that is unique for a customer within a specific business.** 

2. Could you clarify the business meaning of the 'memberid' field?

**Answer:** 

3. What type of code is stored in 'postalcode'? What are some example values?

**Answer:** 

4. What currency is the 'totalspent' field stored in? Is this field in cents or full currency units?

**Answer:** 

5. What currency is the 'totaltransactions' field stored in? Is this field in cents or full currency units?

**Answer:** 

6. Could you clarify the business meaning of the 'taxidno' field?

**Answer:** 

7. Could you clarify the business meaning of the 'consumerid' field?

**Answer: the global identifier that links all records for a single person across all businesses if they have used the "Beep" product** 

8. Could you clarify the business meaning of the 'originalconsumerid' field?

**Answer:** 

9. What does the abbreviated field name '_id' stand for?

**Answer: unique identifier for that row** 

---

## Table: employees

1. Could you clarify the business meaning of the 'employeenumber' field?

**Answer:** 

2. Could you clarify the business meaning of the 'passwordhash' field?

**Answer:** 

3. Could you clarify the business meaning of the 'languagepreference' field?

**Answer: language preference of the employee** 

4. What does the abbreviated field name '_id' stand for?

**Answer: unique identifier of that row, also the unique employee id** 

---

## Table: products

1. Could you clarify the business meaning of the 'originalid' field?

**Answer:** 

2. Could you clarify the business meaning of the 'detailedinfo' field?

**Answer:** 

3. What are the possible types/categories for the 'pricetype' field?

**Answer: fixed, variable, weight, blanks and more (others are mostly typo like fi, f)** 

4. What currency is the 'unitprice' field stored in? Is this field in cents or full currency units?

**Answer: the merchant's local currency, the field is numbers/integers** 

5. What currency is the 'onlineunitprice' field stored in? Is this field in cents or full currency units?

**Answer:** 

6. What currency is the 'onlinesaleprice' field stored in? Is this field in cents or full currency units?

**Answer: the merchant's local currency, the field is numbers/integers** 

7. What currency is the 'cost' field stored in? Is this field in cents or full currency units?

**Answer: the merchant's local currency, the field is numbers with decimal places** 

8. What are the possible types/categories for the 'inventorytype' field?

**Answer: Composite or blank** 

9. Could you clarify the business meaning of the 'skunumber' field?

**Answer: the SKU number for the product** 

10. What type of code is stored in 'barcode'? What are some example values?

**Answer:** 

11. Could you clarify the business meaning of the 'deletedskunumber' field?

**Answer:** 

12. What type of code is stored in 'deletedbarcode'? What are some example values?

**Answer:** 

13. What are the possible types/categories for the 'producttype' field?

**Answer: Simple or Configurable** 

14. Could you clarify the business meaning of the 'parentproductid' field?

**Answer: it's the parent product id corresponding to this product** 

15. What external system does the 'externalid' field reference?

**Answer:** 

16. Could you clarify the business meaning of the 'supplierid' field?

**Answer: the supplier id that can be used to connect to the suppliers table** 

17. Could you clarify the business meaning of the 'supplierids' field?

**Answer:** 

18. What currency is the 'lastsupplierprice' field stored in? Is this field in cents or full currency units?

**Answer:** 

19. What type of code is stored in 'taxcode'? What are some example values?

**Answer:** 

20. Could you clarify the business meaning of the 'description' field?

**Answer:** 

21. Could you clarify the business meaning of the 'descriptionimages' field?

**Answer:** 

22. Could you clarify the business meaning of the 'soldoutstoreids' field?

**Answer:** 

23. Could you clarify the business meaning of the 'validfrom' field?

**Answer:** 

24. Could you clarify the business meaning of the 'validto' field?

**Answer:** 

25. Could you clarify the business meaning of the 'validdays' field?

**Answer:** 

26. Could you clarify the business meaning of the 'validtimefrom' field?

**Answer:** 

27. Could you clarify the business meaning of the 'validtimeto' field?

**Answer:** 

28. Could you clarify the business meaning of the 'onlyforpreorder' field?

**Answer:** 

29. What does the abbreviated field name '_id' stand for?

**Answer: unique identifier for each row in this table** 

30. What does the 'original_id' field reference? Is this a foreign key to another table?

**Answer: primary identifier for each product, can be used to join with the productid field in the transactionrecords__items table to link sales data with product details** 

31. What currency is the 'grabfoodprice' field stored in? Is this field in cents or full currency units?

**Answer: the price on Grabfood platform** 

32. What currency is the 'shopeefoodprice' field stored in? Is this field in cents or full currency units?

**Answer: the price on Shopeefood platform** 

33. What currency is the 'foodpandaprice' field stored in? Is this field in cents or full currency units?

**Answer: the price on Foodpanda platform** 

34. What currency is the 'minrefunitprice' field stored in? Is this field in cents or full currency units?

**Answer:** 

35. What currency is the 'maxrefunitprice' field stored in? Is this field in cents or full currency units?

**Answer:** 

36. Could you clarify the business meaning of the 'issoloparentdiscountapplicable' field?

**Answer:** 

37. What type of code is stored in 'classificationcode'? What are some example values?

**Answer:** 

---

## Table: transactionrecords

1. Could you clarify the business meaning of the 'storeid' field?

**Answer: the store id of the store for the sale/transaction, can be joined to the _id field in the businesses__stores table** 

2. Could you clarify the business meaning of the 'transactionid' field?

**Answer:** 

3. Could you clarify the business meaning of the 'registerid' field?

**Answer: the cash register id for the sale/transaction, can be used to connect to the businesses__cashregisters table** 

4. Could you clarify the business meaning of the 'employeenumber' field?

**Answer: the employee id for the sale/transaction** 

5. How is the 'servicechargerate' field stored? As a decimal (0.15 for 15%) or as a whole number (15 for 15%)?

**Answer:** 

6. What currency is the 'total' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

7. What currency is the 'subtotal' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

8. Could you clarify the business meaning of the 'discount' field?

**Answer: the discount amount applied to the sale/transaction** 

9. What does the abbreviated field name 'tax' stand for?

**Answer: it is the tax amount of the sale/transaction** 

10. What currency is the 'roundedamount' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

11. Could you clarify the business meaning of the 'originalreceiptnumber' field?

**Answer:** 

12. What are the possible types/categories for the 'transactiontype' field?

**Answer: Sale, Return, PreOrder** 

13. What are the possible values for the 'returnstatus' field? Is this a numeric code, text string, or boolean?

**Answer:** 

14. Could you clarify the business meaning of the 'receiptnumber' field?

**Answer: the unique receipt number for the sale/transaction for the merchant** 

15. Could you clarify the business meaning of the 'sequencenumber' field?

**Answer:** 

16. Could you clarify the business meaning of the 'invoiceseqnumber' field?

**Answer:** 

17. Could you clarify the business meaning of the 'customerid' field?

**Answer: the customer id for the customer of that sale/transaction, unique for the customer to that business** 

18. What currency is the 'depositamount' field stored in? Is this field in cents or full currency units?

**Answer:** 

19. Could you clarify the business meaning of the 'preorderdate' field?

**Answer: the preorder creation timestamp** 

20. Could you clarify the business meaning of the 'preorderby' field?

**Answer:** 

21. Could you clarify the business meaning of the 'preorderid' field?

**Answer: unique iderntifier for preorder sales, used to identify preorders,preorderid is not empty means "POS preorders"** 

22. What currency is the 'cost' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

23. Could you clarify the business meaning of the 'headcount' field?

**Answer:** 

24. Could you clarify the business meaning of the 'seniorscount' field?

**Answer:** 

25. Could you clarify the business meaning of the 'pwdcount' field?

**Answer:** 

26. What currency is the 'totaldeductedtax' field stored in? Is this field in cents or full currency units?

**Answer:** 

27. Could you clarify the business meaning of the 'seniordiscount' field?

**Answer:** 

28. Could you clarify the business meaning of the 'pwddiscount' field?

**Answer:** 

29. How is the 'zeroratedsales' field stored? As a decimal (0.15 for 15%) or as a whole number (15 for 15%)?

**Answer:** 

30. What does the abbreviated field name 'pax' stand for?

**Answer: the number of pax for that sale, usually only applicable to dine in transactions** 

31. Could you clarify the business meaning of the 'tableid' field?

**Answer: the table id for the sale/transaction, usually only applicable to dine in transactions** 

32. Could you clarify the business meaning of the 'pickupid' field?

**Answer:** 

33. Could you clarify the business meaning of the 'receiptnumbersbeforefix' field?

**Answer:** 

34. What does the abbreviated field name '_id' stand for?

**Answer: unique identifier for each row** 

35. Could you clarify the business meaning of the 'consumerid' field?

**Answer: same thing as the consumerid in customers table, but is for the customer tied to that sale/transaction** 

36. Could you clarify the business meaning of the 'sessionid' field?

**Answer:** 

37. What are the possible values for the 'status' field? Is this a numeric code, text string, or boolean?

**Answer: text string values of delivered, paymentCancelled, accepted, pickedUp, shipped, cancelled, paid, logisticsConfirmed, readyForDelivery, pendingPayment, created, readyForPickup, failed, pendingVerification** 

38. What are the possible types/categories for the 'shippingtype' field?

**Answer: Text string values of delivery, pickup, dineIn, takeaway. This is applicable to Beep transactions** 

39. What currency is the 'shippingfee' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

40. What currency is the 'shippingfeediscount' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

41. Could you clarify the business meaning of the 'clientid' field?

**Answer:** 

42. Could you clarify the business meaning of the 'deviceid' field?

**Answer:** 

43. What type of code is stored in 'createdvouchercodes'? What are some example values?

**Answer:** 

44. Could you clarify the business meaning of the 'vouchervaliddays' field?

**Answer:** 

45. Could you clarify the business meaning of the 'ordersource' field?

**Answer: source of the order, usually applicable to Beep transactions. 'BeepApp' for app orders, 'BeepSite' for beepit.com orders, 'BeepStore' for beep store URL orders, 'BeepTngMiniProgram' for Beep Mini Program in TNG eWallet** 

46. Could you clarify the business meaning of the 'ispaidzero' field?

**Answer:** 

47. What are the possible types/categories for the 'originalshippingtype' field?

**Answer:** 

48. Could you clarify the business meaning of the 'isnextdaypreorder' field?

**Answer:** 

49. Could you clarify the business meaning of the 'paiddate' field?

**Answer:** 

50. What currency is the 'smallorderfee' field stored in? Is this field in cents or full currency units?

**Answer:** 

51. What currency is the 'containerfee' field stored in? Is this field in cents or full currency units?

**Answer:** 

52. What currency is the 'otherfee' field stored in? Is this field in cents or full currency units?

**Answer:** 

53. Could you clarify the business meaning of the 'changedtoofflinepaymentnotifiedsmscount' field?

**Answer:** 

54. Could you clarify the business meaning of the 'notifiedselfpickupsmscount' field?

**Answer:** 

---

## Table: transactionrecords__items

1. What does the double underscore notation ('transactionrecords__items') represent in our schema? Is this a nested/related table structure?

**Answer: it's a nested table in the transactionrecords table** 

2. What are the possible types/categories for the 'itemtype' field?

**Answer: text string values of ServiceCharge, Discount, Voucher, or blanks** 

3. Could you clarify the business meaning of the 'productid' field?

**Answer: the unique product id for that product tied to the merchant, used to connect products table** 

4. What currency is the 'subtotal' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

5. What currency is the 'total' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

6. Could you clarify the business meaning of the 'discount' field?

**Answer: item level discount amount that is applied to the sale/transaction** 

7. Could you clarify the business meaning of the 'adhocdiscount' field?

**Answer:** 

8. Could you clarify the business meaning of the 'loyaltydiscount' field?

**Answer:** 

9. What does the abbreviated field name 'tax' stand for?

**Answer: it's the item level tax amount that is applied to the sale/transaction** 

10. Could you clarify the business meaning of the 'orderingvalue' field?

**Answer:** 

11. What currency is the 'unitprice' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

12. What currency is the 'cost' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

13. What type of code is stored in 'taxcode'? What are some example values?

**Answer: example: string value of 5510f1bc2a8241c812a83f0c** 

14. What currency is the 'taxableamount' field stored in? Is this field in cents or full currency units?

**Answer:** 

15. What currency is the 'taxexemptamount' field stored in? Is this field in cents or full currency units?

**Answer:** 

16. Could you clarify the business meaning of the 'seniordiscount' field?

**Answer:** 

17. Could you clarify the business meaning of the 'pwddiscount' field?

**Answer:** 

18. What does the abbreviated field name 'sn' stand for?

**Answer:** 

19. Could you clarify the business meaning of the 'refundedquantity' field?

**Answer:** 

20. What are the possible values for the 'status' field? Is this a numeric code, text string, or boolean?

**Answer:** 

21. Could you clarify the business meaning of the 'originalitemid' field?

**Answer:** 

22. Could you clarify the business meaning of the 'sourcevalue' field?

**Answer:** 

23. Could you clarify the business meaning of the 'submitid' field?

**Answer:** 

24. What does the abbreviated field name '_id' stand for?

**Answer: the unique identifier of each row** 

25. How is the 'zeroratedsales' field stored? As a decimal (0.15 for 15%) or as a whole number (15 for 15%)?

**Answer:** 

26. What currency is the 'totaldeductedtax' field stored in? Is this field in cents or full currency units?

**Answer:** 

27. Could you clarify the business meaning of the 'athleteandcoachdiscount' field?

**Answer:** 

28. Could you clarify the business meaning of the 'medalofvalordiscount' field?

**Answer:** 

29. Could you clarify the business meaning of the 'discountvalue' field?

**Answer:** 

30. What are the possible types/categories for the 'discounttype' field?

**Answer:** 

31. Could you clarify the business meaning of the 'fullbilldiscount' field?

**Answer:** 

32. Could you clarify the business meaning of the 'promotiondiscount' field?

**Answer:** 

33. How is the 'taxrate' field stored? As a decimal (0.15 for 15%) or as a whole number (15 for 15%)?

**Answer:** 

---

## Table: transactionrecords__payments

1. What does the double underscore notation ('transactionrecords__payments') represent in our schema? Is this a nested/related table structure?

**Answer: it's a nested table under transactionrecords table** 

2. What currency is the 'amount' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

3. What currency is the 'roundedamount' field stored in? Is this field in cents or full currency units?

**Answer: local currency of the merchant, it's numbers with decimal places** 

4. What are the possible types/categories for the 'subtype' field?

**Answer:** 

5. Could you clarify the business meaning of the 'mpostxnid' field?

**Answer:** 

6. Could you clarify the business meaning of the 'paymentprovider' field?

**Answer: the payment provider of the transaction** 

7. What does the abbreviated field name '_id' stand for?

**Answer: the unique identifier of each row** 

---

