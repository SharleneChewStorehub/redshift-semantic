# Detailed Schema for Key Tables


## transactionrecords
Total columns: 132


### ID Fields
- _id (character varying)
- clientid (character varying)
- consumerid (character varying)
- customerid (character varying)
- deviceid (character varying)
- einvoiceinfo.documentid (character varying)
- inventorychangemsgtrackinfo.eventid (character varying)
- pickupid (character varying)
- preorderid (character varying)
- registerid (character varying)
- sessionid (character varying)
- storeid (character varying)
- tableid (character varying)
- transactionid (character varying)

### Date/Time Fields
- cancelleddate (timestamp without time zone)
- createdtime (timestamp without time zone)
- data_modified_time (timestamp without time zone)
- einvoiceinfo.statusupdatedat (timestamp without time zone)
- expectdeliverydatefrom (timestamp without time zone)
- expectdeliverydateto (timestamp without time zone)
- failedtoupdateinventory (boolean)
- failedtoupdateloyalty (boolean)
- fulfilldate (timestamp without time zone)
- lastuploadedtime (timestamp without time zone)
- modifiedtime (timestamp without time zone)
- onlinebirdate (timestamp without time zone)
- paiddate (timestamp without time zone)
- pendingpaymentstarttime (timestamp without time zone)
- pendingtime (timestamp without time zone)
- pickupdate (timestamp without time zone)
- preorderdate (timestamp without time zone)
- seqnumbercreatedtime (timestamp without time zone)
- servedtime (timestamp without time zone)

### Amount/Financial Fields
- amusementtax (double precision)
- containerfee (double precision)
- containerfeetax (double precision)
- cost (numeric)
- depositamount (double precision)
- fixedfee (double precision)
- otherfee (double precision)
- platformservicefee (double precision)
- platformservicefeetax (double precision)
- roundedamount (double precision)
- servicechargetax (double precision)
- shippingfee (numeric)
- shippingfeediscount (double precision)
- smallorderfee (double precision)
- smallorderfeetax (double precision)
- subtotal (numeric)
- subtotaltax (double precision)
- tax (numeric)
- taxablesales (double precision)
- taxexemptedsales (double precision)
- total (numeric)
- totaldeductedtax (double precision)

### Status Fields
- einvoiceinfo.einvoicestatus (character varying)
- returnstatus (character varying)
- status (character varying)

### Reference Fields
- receiptnumbersbeforefix (character varying)

### Other Fields
- addonbircompliance.athleteandcoachdiscount (double precision)
- addonbircompliance.collectedinfo (character varying)
- addonbircompliance.discounttype (character varying)
- addonbircompliance.medalofvalordiscount (double precision)
- addonbircompliance.soloparentdiscount (double precision)
- appversion (character varying)
- business (character varying)
- cancelledat (timestamp without time zone)
- cancelledby (character varying)
- cancelledsource (character varying)
- cancelreason (character varying)
- cancelreasondetail (character varying)
- cashtendered (double precision)
- changedtoofflinepaymentnotifiedsmscount (double precision)
- channel (double precision)
- comment (character varying)
- createdvouchercodes (character varying)
- deductinventorymethod (character varying)
- delaydetail (character varying)
- delayreason (character varying)
- ... and 53 more fields

## customers
Total columns: 53


### ID Fields
- _id (character varying)
- consumerid (character varying)
- createdatstoreid (character varying)
- customerid (character varying)
- firstpurchaseinfo.employeeid (character varying)
- firstpurchaseinfo.registerid (character varying)
- firstpurchaseinfo.storeid (character varying)
- firstpurchaseinfo.transactionid (character varying)
- memberid (character varying)
- membershipcreatedatstoreid (character varying)
- membershiptierid (character varying)
- originalconsumerid (character varying)
- sourcerefid (character varying)

### Date/Time Fields
- cashbackexpirationdate (timestamp without time zone)
- createdtime (timestamp without time zone)
- data_modified_time (timestamp without time zone)
- firstpurchaseinfo.date (timestamp without time zone)
- lastcashbackclaimdate (timestamp without time zone)
- lastpurchasedate (timestamp without time zone)
- membershipjointime (timestamp without time zone)
- membershiptierlastchangetime (timestamp without time zone)
- membershiptiernextreviewtime (timestamp without time zone)
- membershiptierstarttime (timestamp without time zone)
- membershiptiertotalspentupdatedtime (timestamp without time zone)
- modifiedtime (timestamp without time zone)
- tmpcashbackexpirationdate (timestamp without time zone)

### Amount/Financial Fields
- membershiptiertotalspent (double precision)
- taxidno (character varying)
- totalspent (double precision)
- totaltransactions (double precision)

### Other Fields
- birthday (timestamp without time zone)
- business (character varying)
- cashbackclaimcnt (double precision)
- city (character varying)
- email (character varying)
- facebook (character varying)
- firstname (character varying)
- firstpurchaseinfo.flag (boolean)
- isdeleted (boolean)
- lastname (character varying)
- membershipsource (character varying)
- phone (character varying)
- postalcode (character varying)
- purchasedinstores (character varying)
- signupbyemployee (character varying)
- signupfromstore (character varying)
- source (character varying)
- state (character varying)
- storecreditsbalance (double precision)
- storecreditsspent (double precision)
- ... and 3 more fields

## products
Total columns: 67


### ID Fields
- _id (character varying)
- externalid (character varying)
- original_id (character varying)
- originalid (character varying)
- parentproductid (character varying)
- supplierid (character varying)

### Date/Time Fields
- createdtime (timestamp without time zone)
- data_modified_time (timestamp without time zone)
- inventorystartdate (timestamp without time zone)
- lastupdatethumbnail (timestamp without time zone)
- modifiedtime (timestamp without time zone)
- validtimefrom (double precision)
- validtimeto (double precision)

### Amount/Financial Fields
- cost (numeric)
- foodpandaprice (double precision)
- grabfoodprice (double precision)
- lastsupplierprice (double precision)
- maxrefunitprice (double precision)
- minrefunitprice (double precision)
- onlinesaleprice (double precision)
- onlineunitprice (double precision)
- pricetype (character varying)
- shopeefoodprice (double precision)
- taxcode (character varying)
- unitprice (double precision)

### Other Fields
- barcode (character varying)
- beforegstadjustment (character varying)
- business (character varying)
- category (character varying)
- classificationcode (character varying)
- deletedbarcode (character varying)
- deletedskunumber (character varying)
- description (character varying)
- descriptionimages (character varying)
- detailedinfo (character varying)
- hasthumbnail (boolean)
- images (character varying)
- inventorytype (character varying)
- isbasicnecessitiesph (boolean)
- ischild (boolean)
- isdeleted (boolean)
- ishalal (boolean)
- isonbeep (boolean)
- isonfoodpanda (boolean)
- isongrabfood (boolean)
- ... and 22 more fields

## businesses
Total columns: 165


### ID Fields
- _id (character varying)
- advanceinvoiceid (character varying)
- assigntableid (boolean)
- autoorderid (boolean)
- autosmscreditsdiscountinfoid (character varying)
- chargebeecustomerid (character varying)
- facebookid (character varying)
- hubspotdealid (double precision)
- ongoingsubscriptionorderid (character varying)
- planid (character varying)
- plivoauthid (character varying)
- salesforceopportunityid (character varying)
- softwareorderid (character varying)
- subscriptionid (character varying)
- totalsubfeepaid (double precision)

### Date/Time Fields
- campaignenabledtime (double precision)
- campaigntrialendtime (double precision)
- campaigntrialstartdate (timestamp without time zone)
- cashbacktrialexpirydate (timestamp without time zone)
- createdtime (timestamp without time zone)
- creditcardexpirydate (character varying)
- creditcardmodifieddate (timestamp without time zone)
- data_modified_time (timestamp without time zone)
- firstenablecashbackdate (timestamp without time zone)
- firstenableqrorderingdate (timestamp without time zone)
- firstmembershipenabledtime (timestamp without time zone)
- firstpointsenabledtime (timestamp without time zone)
- lastchargebeeeventtime (timestamp without time zone)
- lastenablecashbackdate (timestamp without time zone)
- lastenableqrorderingdate (timestamp without time zone)
- lastpointsdisabledtime (timestamp without time zone)
- lastrevenuecheckingtime (double precision)
- nextbillingdate (timestamp without time zone)
- pointsexpirationduration.lastupdatetime (timestamp without time zone)
- scheduledactivationtime (double precision)
- subscriptionenddate (timestamp without time zone)
- subscriptionstartdate (timestamp without time zone)
- timezone (character varying)

### Amount/Financial Fields
- cashbackclaimtopuptotal (double precision)
- defaulttaxcode (character varying)
- includingtaxindisplay (boolean)
- issupplierpricefixedforallstores (boolean)
- servicechargetax (character varying)
- smscreditsavgcost (double precision)
- softwareorderamount (double precision)
- storeswithfixedsupplierprice (character varying)
- taxrate (double precision)

### Status Fields
- businessstatus (character varying)
- status (character varying)
- subscriptionstatus (character varying)

### Reference Fields
- cashbackclaimautorefill (boolean)
- enableonlinestorefeature (boolean)
- hascreditedreferrer (boolean)

### Other Fields
- activatedat (timestamp without time zone)
- added60daysfreesmscredits (boolean)
- addonids (character varying)
- allowanonymousqrordering (boolean)
- alloweditproductsonpos (boolean)
- autocountaccountingcode (character varying)
- autolowsmscredits (double precision)
- autorechargesmscredits (double precision)
- billingcurrency (character varying)
- billingperiodchanged (boolean)
- businesstype (character varying)
- cashbackclaimplanused (double precision)
- cashbackclaimtopupused (double precision)
- cashbackclaimtrailcount (double precision)
- cashbackexpirationduration.durationnumber (double precision)
- cashbackexpirationduration.durationunit (character varying)
- cashbackpopedupemployees (character varying)
- cashbacktrailexpiredalertclosed (boolean)
- cashbacktrailstartedalertclosed (boolean)
- claimcashbackcountperday (double precision)
- ... and 92 more fields

## inventories
Total columns: 19


### ID Fields
- _id (character varying)
- productid (character varying)
- storeid (character varying)

### Date/Time Fields
- data_modified_time (timestamp without time zone)
- pendingmanualupdatelogs (character varying)

### Other Fields
- appliedeventids (character varying)
- business (character varying)
- desiredstocklevel (double precision)
- isserialized (boolean)
- pendingcancelledstocktransfers (character varying)
- pendingpurchaseorders (character varying)
- pendingreturnprocess (character varying)
- pendingstockreturns (character varying)
- pendingstocktakes (character varying)
- pendingstocktransfers (character varying)
- pendingtransactions (character varying)
- quantityonhand (double precision)
- restocklevel (double precision)
- supplyneedsnotified (boolean)

## promotions
Total columns: 44


### ID Fields
- _id (character varying)

### Date/Time Fields
- createdtime (timestamp without time zone)
- data_modified_time (timestamp without time zone)
- modifiedtime (timestamp without time zone)
- validtimefrom (double precision)
- validtimeto (double precision)

### Amount/Financial Fields
- costpersms (double precision)
- maxdiscountamount (double precision)
- taxcode (character varying)
- totalsmssent (double precision)

### Reference Fields
- requirefirstpurchase (boolean)

### Other Fields
- appliedclienttypes (character varying)
- appliedsources (character varying)
- appliedstores (character varying)
- applytoonlinestore (boolean)
- business (character varying)
- claimedcount (double precision)
- createdby (character varying)
- discounttype (character varying)
- discountvalue (double precision)
- enablebeeptagandbanner (boolean)
- enableclaimlimit (boolean)
- enableduniquepromotioncode (boolean)
- enableperbusinessclaimlimit (boolean)
- enablepercustomerclaimlimit (boolean)
- isbindcampaign (boolean)
- isdeleted (boolean)
- iseligibletoshowonbeep (boolean)
- isenabled (boolean)
- isrepeatable (boolean)
- maxclaimcount (double precision)
- ... and 13 more fields

## logistics
Total columns: 56


### ID Fields
- _id (character varying)
- dependentid (character varying)
- driverid (character varying)
- id (character varying)
- riderid (character varying)
- teamid (character varying)
- trackingid (character varying)

### Date/Time Fields
- createdtime (timestamp without time zone)
- data_modified_time (timestamp without time zone)
- istimeoutsent (boolean)
- modifiedtime (timestamp without time zone)
- onfleetlastcheckcompletiontime (timestamp without time zone)

### Amount/Financial Fields
- deliveryfee (double precision)
- originalfee (double precision)

### Status Fields
- status (character varying)

### Other Fields
- bestlastmileeta (timestamp without time zone)
- business (character varying)
- claimcheckpasscounts (double precision)
- claimedbefore (boolean)
- country (character varying)
- deliverydistance (double precision)
- dropofflocation.coordinates (character varying)
- dropofflocation.type (character varying)
- expireat (timestamp without time zone)
- isexpress (boolean)
- ismanual (boolean)
- isoffstorebefore (boolean)
- ispickedupbefore (boolean)
- ispreorder (boolean)
- ispreorderconverted (boolean)
- issendpreordernotifications (boolean)
- istest (boolean)
- joburl (character varying)
- name (character varying)
- onfleetunassignedcounts (double precision)
- ... and 21 more fields