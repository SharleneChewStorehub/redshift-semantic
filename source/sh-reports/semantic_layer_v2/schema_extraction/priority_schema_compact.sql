-- StoreHub Priority Tables Schema (172 tables, 2.5K columns, 6.2B rows)
-- Generated: 2025-07-17
-- Schema: storehub_mongo (all tables)

-- transactionrecords__items (2,434,587,238 rows, Transactions)
varchar: _id, comments, discounttype, image, itemtype, notes
varchar: originalitemid, productid, sn, source, sourcevalue, status
varchar: submitid, taxcode, title, transactionrecords_foreignkey
double: adhocdiscount, athleteandcoachdiscount, discountvalue, fullbilldiscount, itemchannel, lockedquantity
double: loyaltydiscount, medalofvalordiscount, orderingvalue, promotiondiscount, pwddiscount, quantity
double: refundedquantity, seniordiscount, soloparentdiscount, takeawaycharge, taxableamount, taxexemptamount
double: taxrate, totaldeductedtax, unitprice, zeroratedsales
numeric: cost, discount, subtotal, tax, total
timestamp: data_modified_time, lockeddate
boolean: isamusementtax, ishalal, isservicechargenotapplicable, istakeaway, isvatexempted

-- transactionrecords__payments (984,792,794 rows, Transactions)
varchar: _id, cardname, cardno, mpostxnid, paymentgateway, paymentmethod
varchar: paymentmethodid, paymentprovider, paymentprovidermid, subtype, transactionrecords_foreignkey
numeric: amount
double: cashtendered, changeamount, roundedamount
timestamp: data_modified_time
boolean: isdeposit, isonline

-- transactionrecords (971,611,229 rows, Transactions)
varchar: _id, addonbircompliance.collectedinfo, addonbircompliance.discounttype, appversion, business, cancelledby
varchar: cancelledsource, cancelreason, cancelreasondetail, clientid, comment, consumerid
varchar: createdvouchercodes, customerid, deductinventorymethod, delaydetail, delayreason, deviceid
varchar: einvoiceinfo.documentid, einvoiceinfo.documenttype, einvoiceinfo.einvoicestatus, employeenumber, inventorychangemsgtrackinfo.eventid, issplittedby
varchar: issplittedfromreceiptnumber, minno, ordersource, originalreceiptnumber, originalshippingtype, otherreason
varchar: paymentmethod, pickupid, preorderby, preorderid, prooffiles, receiptnumber
varchar: receiptnumbersbeforefix, registerid, returnreason, returnstatus, sessionid, shippingtype
varchar: status, storeid, tableid, transactionid, transactiontype, urltype
varchar: voidnumber
double: addonbircompliance.athleteandcoachdiscount, addonbircompliance.medalofvalordiscount, addonbircompliance.soloparentdiscount, amusementtax, cashtendered, changedtoofflinepaymentnotifiedsmscount
double: channel, containerfee, containerfeetax, depositamount, fixedfee, headcount
double: invoiceseqnumber, notifiedselfpickupsmscount, otherfee, pax, pendingclaimcashback, platformservicefee
double: platformservicefeetax, productsmanualdiscount, pwdcount, pwddiscount, registernumber, revenue
double: roundedamount, saleschannel, seniordiscount, seniorscount, sequencenumber, servicechargerate
double: servicechargetax, shippingfeediscount, smallorderfee, smallorderfeetax, subtotaltax, takeawaycharges
double: taxablesales, taxexemptedsales, totaldeductedtax, version, voidseqnumber, vouchervaliddays
double: zeroratedsales
timestamp: cancelledat, cancelleddate, createdtime, data_modified_time, einvoiceinfo.statusupdatedat, expectdeliverydatefrom
timestamp: expectdeliverydateto, fulfilldate, inventorychangemsgtrackinfo.sendmsgstartat, lastuploadedtime, modifiedtime, onlinebirdate
timestamp: paiddate, pendingpaymentstarttime, pendingtime, pickupdate, preorderdate, seqnumbercreatedtime
timestamp: servedtime
numeric: cost, discount, servicecharge, shippingfee, subtotal, tax
numeric: total
boolean: emailreceipt, enablecashback, enabledgooglereviewsmscampaign, failedtosendmembershipstatsqueue, failedtoupdateinventory, failedtoupdateloyalty
boolean: inventorychangemsgtrackinfo.issendmsg, iscancelled, isdisbursed, isnextdaypreorder, ispaidzero, ispaylater
boolean: printkitchendocket, printreceipt

-- transactionrecords__items__selectedoptions (956,891,680 rows, Transactions)
varchar: _id, optionid, optionvalue, transactionrecords__items_foreignkey, transactionrecords_foreignkey, variationid
timestamp: data_modified_time
double: quantity

-- paymentrecordlogs (72,977,328 rows, Payments)
varchar: _id, metadata, operator, paymentrecordid, receiptnumber, remark
varchar: source, status
timestamp: createdtime, data_modified_time, logtime, modifiedtime

-- transactionrecords__items__componentsusages (72,349,548 rows, Transactions)
varchar: _id, productid, transactionrecords__items_foreignkey, transactionrecords_foreignkey
timestamp: data_modified_time, lockeddate
double: lockedquantity, quantity

-- transactionrecords__items__productinfo (66,696,215 rows, Transactions)
varchar: _id, category, image, inventorytype, originimage, productid
varchar: productparentid, tags, taxcode, title, transactionrecords__items_foreignkey, transactionrecords_foreignkey
timestamp: data_modified_time
double: displayprice, originaldisplayprice, taxrate, unitprice
boolean: isamusementtax, ishalal, isvatexempted, trackinventory

-- useractionlogs (60,089,080 rows, Other)
varchar: _id, action, additionalinfo, business, ipaddress, notes
varchar: source, storeid, user
timestamp: data_modified_time, time
double: registerid

-- inventories (58,541,689 rows, Other)
varchar: _id, appliedeventids, business, pendingcancelledstocktransfers, pendingmanualupdatelogs, pendingpurchaseorders
varchar: pendingreturnprocess, pendingstockreturns, pendingstocktakes, pendingstocktransfers, pendingtransactions, productid
varchar: storeid
timestamp: data_modified_time
double: desiredstocklevel, quantityonhand, restocklevel
boolean: isserialized, supplyneedsnotified

-- loyaltychangelogs (54,576,038 rows, Loyalty)
varchar: _id, business, customerid, eventtype, loyaltyperproduct, receiptnumber
varchar: rewardtype, source, transactionid
numeric: amount
timestamp: data_modified_time, eventtime
double: dataversion, defaultloyaltyratio

-- customers (47,663,764 rows, Customers)
varchar: _id, business, city, consumerid, createdatstoreid, customerid
varchar: email, facebook, firstname, firstpurchaseinfo.employeeid, firstpurchaseinfo.registerid, firstpurchaseinfo.storeid
varchar: firstpurchaseinfo.transactionid, lastname, memberid, membershipcreatedatstoreid, membershipsource, membershiptierid
varchar: originalconsumerid, phone, postalcode, purchasedinstores, signupbyemployee, signupfromstore
varchar: source, sourcerefid, state, street1, street2, tags
varchar: taxidno
timestamp: birthday, cashbackexpirationdate, createdtime, data_modified_time, firstpurchaseinfo.date, lastcashbackclaimdate
timestamp: lastpurchasedate, membershipjointime, membershiptierlastchangetime, membershiptiernextreviewtime, membershiptierstarttime, membershiptiertotalspentupdatedtime
timestamp: modifiedtime, tmpcashbackexpirationdate
double: cashbackclaimcnt, membershiptiertotalspent, storecreditsbalance, storecreditsspent, totalspent, totaltransactions
boolean: firstpurchaseinfo.flag, isdeleted

-- transactionrecords__location (42,716,363 rows, Transactions)
varchar: _id, coordinates, transactionrecords_foreignkey, type
timestamp: data_modified_time

-- products (33,301,429 rows, Products)
varchar: _id, barcode, beforegstadjustment, business, category, classificationcode
varchar: deletedbarcode, deletedskunumber, description, descriptionimages, detailedinfo, externalid
varchar: images, inventorytype, kitchenprinter, onlinetitle, original_id, originalid
varchar: parentproductid, pricetype, producttype, skunumber, slug, soldoutstoreids
varchar: supplierid, supplierids, tags, taxcode, title, unit
varchar: validdays
numeric: cost
timestamp: createdtime, data_modified_time, inventorystartdate, lastupdatethumbnail, modifiedtime, validfrom
timestamp: validto
double: foodpandaprice, grabfoodprice, lastsupplierprice, loyalty, maxrefunitprice, minrefunitprice
double: onlinesaleprice, onlineunitprice, shopeefoodprice, unitprice, validtimefrom, validtimeto
boolean: hasthumbnail, isbasicnecessitiesph, ischild, isdeleted, ishalal, isonbeep
boolean: isonfoodpanda, isongrabfood, isonline, isonshopeefood, issample, isserialized
boolean: issoloparentdiscountapplicable, markedsoldout, onlyforpreorder, trackinventory

-- transactionrecords__items__promotions (30,836,822 rows, Transactions)
varchar: _id, discounttype, originaldiscounttype, promotioncode, promotionid, promotionname
varchar: promotiontype, taxcode, transactionrecords__items_foreignkey, transactionrecords_foreignkey, uniquepromotioncode, uniquepromotioncodeid
timestamp: data_modified_time
numeric: discount, tax
double: pwddiscount, quantity, seniordiscount, shippingfeediscount, storehubpaidpercentage, taxableamount
double: taxexemptamount

-- products__variations__optionvalues (29,309,572 rows, Products)
varchar: _id, products__variations_foreignkey, products_foreignkey, soldoutstoreids, value
timestamp: data_modified_time
boolean: isdefault, markedsoldout
double: order, pricediff, pricediffbeforegstadjustment

-- transactionrecords__contactdetail (22,804,306 rows, Transactions)
varchar: _id, email, info, name, phone, transactionrecords_foreignkey
timestamp: data_modified_time

-- products__variationvalues (19,545,805 rows, Products)
varchar: _id, products_foreignkey, value, variationid
timestamp: data_modified_time

-- payoutitems (19,231,310 rows, Payments)
varchar: _id, batchpayoutid, businessname, cause, countrycode, paymentgateway
varchar: payoutstatus, payouttype, receiptnumber, reconstatus, refid, reftype
varchar: shippingtype, storeid
numeric: amount
timestamp: createdtime, data_modified_time, modifiedtime, settledat
double: deliveryrevenue, logisticsfee, offlinepaidamount, orderamount, orderpromotionamount, ordervoucheramount
double: paidamount, paymentgatewayfee, pickupsmsfee, productrevenue, promotionamount, refundedamount
double: transactionfee, transactionfeerate, voucheramount

-- payoutitems__storehubdetails (19,231,310 rows, Payments)
varchar: _id, payoutitems_foreignkey
timestamp: data_modified_time
double: paymentgatewaycost, paymentgatewayrevenue, storehublogisticscost, storehublogisticsrevenue

-- stocktransfers__ordereditems (18,498,656 rows, Inventory)
varchar: _id, productid, serialnumbers, stocktransfers_foreignkey
timestamp: data_modified_time
boolean: isserialized
double: quantity

-- transactionrecords__suborders (13,576,743 rows, Transactions)
varchar: _id, comments, submitid, submittedby, submittedbyphone, submittedfrom
varchar: transactionrecords_foreignkey
timestamp: data_modified_time, printedtime, submittedtime
boolean: isprinted

-- stocktakeitems (13,273,473 rows, Inventory)
varchar: _id, productid, stocktakeid
double: countedqty, quantity
timestamp: data_modified_time

-- orderlogs (12,779,042 rows, Other)
varchar: _id, info, operatorid, operatorname, operatortype, receiptnumber
varchar: type
timestamp: createdtime, data_modified_time, modifiedtime, time

-- paymentrecords (12,433,804 rows, Payments)
varchar: _id, business, cardholdername, cardtoken, cardtype, currency
varchar: cvctoken, encryptedcardinfo, issuercountry, issuername, lasterror, lasterrorcode
varchar: metadata, nonce, payactionway, paymentid, paymentmethodid, paymentoption
varchar: paymentrecordid, paymenttype, provider, provideraccountid, provideroption, receiptnumber
varchar: redirecturl, refundid, refundrequestid, shippingtype, source, status
varchar: storeid, userid, webhookurl
numeric: amount
timestamp: cancelledat, createdat, data_modified_time, updatedat
boolean: isinternal, notificationack

-- transactionrecords__promotions (12,139,704 rows, Transactions)
varchar: _id, discounttype, originaldiscounttype, promotioncode, promotionid, promotionname
varchar: promotiontype, taxcode, transactionrecords_foreignkey, uniquepromotioncode, uniquepromotioncodeid
timestamp: data_modified_time
numeric: discount, tax
double: pwddiscount, quantity, seniordiscount, shippingfeediscount, storehubpaidpercentage, taxableamount
double: taxexemptamount

-- gatewayrecords (10,244,168 rows, Payments)
varchar: _id, country, paymentgateway, paymentrecordid, receiptnumber, reconstatus
varchar: transactionid, transactiontype, transferstatus
timestamp: createdtime, data_modified_time, modifiedtime, settlementtime
double: fee, net, transactionamount

-- transactionrecords__loyaltydiscounts (8,004,277 rows, Transactions)
varchar: _id, loyaltytype, transactionrecords_foreignkey
timestamp: data_modified_time
double: discountedtax, displaydiscount, spentvalue, taxrate

-- messages (7,906,573 rows, Other)
varchar: _id, business, message, msgid, msgids, phone
varchar: provider, source, status, templateid, type
numeric: amount
timestamp: createdtime, data_modified_time, senttime, updatedtime
double: rate, senttimes, units

-- products__variations (7,396,980 rows, Products)
varchar: _id, name, products_foreignkey, sharedmodifierid, variationtype
boolean: allowmultiqty, enableselectionamountlimit, ismodifier
timestamp: data_modified_time
double: maxselectionamount, minselectionamount, order

-- transactionrecords__deliveryinformation (6,578,078 rows, Transactions)
varchar: _id, comments, courier, deliverydistanceunit, driverphone, jobid
varchar: ridetypemerchantsetup, trackingid, trackingurl, transactionrecords_foreignkey
timestamp: bestlastmileeta, data_modified_time, worstlastmileeta
double: deliverydistance, deliveryfee
numeric: shippingfee
boolean: usestorehublogistics

-- transactionrecords__deliveryinformation__address (6,578,025 rows, Transactions)
varchar: _id, address, addressdetails, addressid, city, companyname
varchar: country, deliveryto, name, phone, postcode, state
varchar: transactionrecords__deliveryinformation_foreignkey, transactionrecords_foreignkey
timestamp: createdtime, data_modified_time, updatedtime

-- campaignjobs (6,076,635 rows, Marketing)
varchar: _id, attributes, business, campaignid, channel, consumerid
varchar: content, customeremail, customerid, customerphone, failedreason, globalcampaigninformationid
varchar: launchid, lockfreesmscreditlogid, lockpaidsmscreditlogid, messageid, messageprovider, messagestatus
varchar: promotioncustomerid, pushstatus, validations
timestamp: createdtime, data_modified_time, modifiedtime, sendtime
double: delay, freemessageamount, messageamount, messageunits, smsunitcredits

-- products__quickselectpositions (6,043,581 rows, Products)
varchar: _id, backgroundcolor, categoryid, layoutid, products_foreignkey
double: column, row
timestamp: data_modified_time

-- consumers (5,735,184 rows, Customers)
varchar: _id, defaultshippingaddressid, email, firstname, gender, lastname
varchar: latestappversion, membership, mergedto, password, phone, registrationsource
varchar: registrationtouchpoint, unverifiedphone
timestamp: alcoholconsenttime, birthday, birthdaymodifiedtime, createdtime, data_modified_time, modifiedtime
boolean: hasusedclevertapversion, isdeleted

-- products__stocktakes (5,717,724 rows, Products)
varchar: _id, products_foreignkey, stocktakeid
timestamp: countedat, data_modified_time
double: countedqty, quantity
boolean: failedtoupdateinventory

-- campaignjobs__additionalattributes (5,529,934 rows, Marketing)
varchar: _id, campaignjobs_foreignkey, receiptnumber
timestamp: data_modified_time

-- logistics (5,299,975 rows, Logistics)
varchar: _id, business, country, dependentid, driverid, dropofflocation.coordinates
varchar: dropofflocation.type, id, joburl, name, pickuplocation.coordinates, pickuplocation.type
varchar: receiptnumber, riderclaimlocation.coordinates, riderclaimlocation.type, ridercompletelocation.coordinates, ridercompletelocation.type, riderid
varchar: ridername, riderphone, riderpickeduplocation.coordinates, riderpickeduplocation.type, ridetype, ridetypemerchantsetup
varchar: state, status, teamid, trackingid, trackingurl, upbidtype
timestamp: bestlastmileeta, createdtime, data_modified_time, expireat, modifiedtime, onfleetlastcheckcompletiontime
timestamp: preorderstartat, startat, worstlastmileeta
double: claimcheckpasscounts, deliverydistance, deliveryfee, onfleetunassignedcounts, originalfee, riderclaimdistance
double: riderstraightdistancetodropoff
boolean: claimedbefore, isexpress, ismanual, isoffstorebefore, ispickedupbefore, ispreorder
boolean: ispreorderconverted, issendpreordernotifications, istest, istimeoutsent

-- smscreditlogs (5,258,337 rows, Other)
varchar: _id, business, country, eventtype, extrainfo.campaignid, extrainfo.campaignjobid
varchar: extrainfo.campaignjoblaunchid, extrainfo.campaignname, extrainfo.currency, extrainfo.lockfreesmscreditlogid, extrainfo.lockpaidsmscreditlogid, extrainfo.purchasedid
varchar: extrainfo.ticketid, source, title, type
timestamp: createdtime, data_modified_time, eventtime, modifiedtime
double: engagetrialsmscreditsbalance, engagetrialsmscreditschange, extrainfo.paidamount, extrainfo.smscount, lockedengagetrialsmscreditsavailable, lockedengagetrialsmscreditschange
double: lockedmonthlysmscreditsavailable, lockedmonthlysmscreditschange, lockedsmscreditsavailable, lockedsmscreditschange, monthlysmscreditsbalance, monthlysmscreditschange
double: smscreditchange, smscreditsavgcost, smscreditsbalance

-- stockreturns__returneditems (3,503,163 rows, Inventory)
varchar: _id, productid, serialnumbers, stockreturns_foreignkey
timestamp: data_modified_time
boolean: isserialized
double: returnedquantity, supplierprice
numeric: subtotal

-- transactionrecords__deliveryinformation__deliverymethodinfo (2,979,587 rows, Transactions)
varchar: _id, deliverymethodid, deliverymethodname, shippingtimeunit, shippingzoneid, shippingzonename
varchar: transactionrecords__deliveryinformation_foreignkey, transactionrecords_foreignkey
timestamp: data_modified_time
boolean: isfree
double: maxshippingtime, minshippingtime, rate

-- products__pricebooks (2,967,002 rows, Products)
varchar: _id, pricebookid, products_foreignkey, taxcode
timestamp: data_modified_time
double: max, min, unitprice

-- zreadings__paymentcollections (2,775,077 rows, Payments)
varchar: _id, name, zreadings_foreignkey
numeric: amount
double: count
timestamp: data_modified_time

-- transactionrecords__deliveryinformation__address__location (2,634,226 rows, Transactions)
varchar: _id, coordinates, transactionrecords__deliveryinformation__address_foreignkey, transactionrecords_foreignkey, type
timestamp: data_modified_time

-- transactionrecords__fromlocation (2,554,263 rows, Transactions)
varchar: _id, coordinates, transactionrecords_foreignkey, type
timestamp: data_modified_time

-- transactionrecords__returnprocess (2,506,561 rows, Transactions)
varchar: _id, comment, inventoryaction, productid, skunumber, sn
varchar: title, transactionrecords_foreignkey
boolean: actionrequired, failedtoupdateinventory
timestamp: completedtime, data_modified_time

-- purchaseorders__ordereditems (2,505,698 rows, Other)
varchar: _id, productid, purchaseorders_foreignkey, serialnumbers
timestamp: data_modified_time
boolean: isserialized
double: orderedquantity, receivedquantity, supplierprice
numeric: subtotal

-- serialnumbers__logs (1,811,210 rows, Other)
varchar: _id, docrefid, employeeid, eventtype, serialnumbers_foreignkey, storeid
timestamp: data_modified_time, timestamp

-- stocktransfers (1,220,788 rows, Inventory)
varchar: _id, business, inventorychangemsgtrackinfo.eventid, notes, receivedby, shippedby
varchar: sourcestoreid, status, targetstoreid
timestamp: completedat, createdtime, data_modified_time, inventorychangemsgtrackinfo.sendmsgstartat, markshippedat, modifiedtime
timestamp: shippeddate
boolean: failedtoupdateinventory, inventorychangemsgtrackinfo.issendmsg
double: stocktransferid

-- stocktakes (1,106,489 rows, Inventory)
varchar: _id, business, completedby, description, inventorychangemsgtrackinfo.eventid, source
varchar: startedby, status, storeid, supplierid
timestamp: completetime, data_modified_time, inventorychangemsgtrackinfo.sendmsgstartat, starttime
boolean: inventorychangemsgtrackinfo.issendmsg, iscountedonshmanager, ismovedtostocktakeitems
double: totalcostdiff, totalqtydiff

-- products__components (1,104,444 rows, Products)
varchar: _id, productid, products_foreignkey, usages
timestamp: data_modified_time

-- serialnumbers (1,085,984 rows, Other)
varchar: _id, business, productid, serialnum, storeid
timestamp: data_modified_time

-- logisticsjoblogs (1,054,762 rows, Logistics)
varchar: _id, jobid, operation, operator, operatorname, providername
varchar: receiptnumber, ridetype, status
timestamp: createdtime, data_modified_time
double: deliverydistance, deliveryfee

-- campaignlogs (969,614 rows, Marketing)
varchar: _id, business, campaignid, operation, reason, status
double: additionallogdata.creditsactualdeducted, additionallogdata.creditsduefordeduction, additionallogdata.customercount
timestamp: createdtime, data_modified_time, modifiedtime

-- transactionrecords__pickupinformation__store__qrorderingsettings__vacations (891,916 rows, Transactions)
varchar: _id, transactionrecords__pickupinformation__store__qrorderingsettings_foreignkey, transactionrecords_foreignkey, vacationtimefrom, vacationtimeto
timestamp: data_modified_time

-- shifts__payins (879,020 rows, Other)
varchar: _id, actedby, comment, shifts_foreignkey, type
numeric: amount
timestamp: data_modified_time, payouttime
double: paytype

-- transactionrecords__payments__manualapproveinfo (835,889 rows, Transactions)
varchar: _id, approver, approvereason, transactionrecords__payments_foreignkey, transactionrecords_foreignkey
timestamp: approvedate, data_modified_time

-- transactionrecords__pickupinformation (829,856 rows, Transactions)
varchar: _id, transactionrecords_foreignkey
timestamp: data_modified_time

-- transactionrecords__pickupinformation__store__pickupaddress__addresscomponents (760,012 rows, Transactions)
varchar: _id, city, country, state, street1, street2
varchar: transactionrecords__pickupinformation__store__pickupaddress_foreignkey, transactionrecords_foreignkey
timestamp: data_modified_time

-- transactionrecords__pickupinformation__store__pickupaddress (759,993 rows, Transactions)
varchar: _id, coordinate, googlemapsplaceid, googlemapsurl, location, placename
varchar: transactionrecords__pickupinformation__store_foreignkey, transactionrecords_foreignkey
timestamp: data_modified_time

-- transactionrecords__pickupinformation__store__location (738,555 rows, Transactions)
varchar: _id, coordinates, transactionrecords__pickupinformation__store_foreignkey, transactionrecords_foreignkey, type
timestamp: data_modified_time

-- products__variations__optionvalues__soldoutstores (724,208 rows, Products)
varchar: _id, products__variations__optionvalues_foreignkey, products_foreignkey, storeid
timestamp: data_modified_time
double: duration

-- transactionrecords__pickupinformation__store__qrorderingsettings (714,331 rows, Transactions)
varchar: _id, breaktimefrom, breaktimeto, pausemodesettings.shippingtypes, transactionrecords__pickupinformation__store_foreignkey, transactionrecords_foreignkey
varchar: validdays, validtimefrom, validtimeto
timestamp: data_modified_time, firstenablepreorderdeliverydate
boolean: disableondemandorder, disabletodaypreorder, enablepertimeslotlimitforpreorder, enablepreorder, enableselfpickupalert
double: maxpreorderspertimeslot, pausemodesettings.endingat

-- employees (546,726 rows, Employees)
varchar: _id, assignedstores, backofficedetailaccesses, email, emailnotifications, employername
varchar: firstname, languagepreference, lastname, passwordhash, phone
boolean: accessallstores, backofficeaccess, cashieraccess, isdeleted, istutorialdone, limitbackofficeaccess
boolean: manageraccess
timestamp: createdtime, data_modified_time, lastcheckalerts, modifiedtime
double: employeenumber

-- products__soldoutstores (488,470 rows, Products)
varchar: _id, products_foreignkey, storeid
timestamp: data_modified_time
double: duration

-- batchpayouts (486,016 rows, Payments)
varchar: _id, bankaccountid, businessname, countrycode, currency, merchantbankaccountname
varchar: merchantbankaccountnumber, merchantbankcode, merchantbankname, storeids
timestamp: createdtime, data_modified_time, enddate, modifiedtime, startdate
double: merchanttotaldeliveryrevenue, merchanttotalproductrevenue, payoutitemcount, totaladjustments, totalbanktransactionfee, totalofflinepaidamount
double: totalorderamount, totalorderpayout, totalorderpromotionamount, totalordervoucheramount, totalpaymentgatewayfee, totalpayout
double: totalpickupsmsfee, totalpromotionamount, totalstorehubfee, totalstorehublogisticsfee, totalvoucheramount

-- stockreturns (444,590 rows, Inventory)
varchar: _id, business, completedby, inventorychangemsgtrackinfo.eventid, name, notes
varchar: sourcestoreid, status, supplierid
timestamp: createdtime, data_modified_time, inventorychangemsgtrackinfo.sendmsgstartat, modifiedtime
numeric: discount, subtotal, tax, total
boolean: failedtoupdateinventory, inventorychangemsgtrackinfo.issendmsg
double: stockreturnid

-- promotionclaimcounts (390,641 rows, Marketing)
varchar: _id, businessname, consumerid, customerid, promotioncode, promotionid
varchar: receiptnumbers, uniquepromotioncodeid
double: count
timestamp: createdtime, data_modified_time, modifiedtime

-- pointchangelogs__points (366,525 rows, Loyalty)
varchar: _id, pointchangelogs_foreignkey, pointid
double: changeamount
timestamp: data_modified_time

-- pointchangelogs (362,593 rows, Other)
varchar: _id, customerid, merchantname, type
double: changeamount
timestamp: createdtime, data_modified_time, eventtime, modifiedtime

-- zreadings (356,202 rows, Other)
varchar: _id, business, endornumber, endtrxnumber, minno, ptu
varchar: registerid, serialno, startornumber, starttrxnumber, storeid, tin
double: amusementtax, athleteandcoachdiscount, extendedinfoformall.customercount, extendedinfoformall.discountedtrxcount, extendedinfoformall.newvoidamount, extendedinfoformall.newvoidnumber
double: extendedinfoformall.oldvoidamount, extendedinfoformall.oldvoidnumber, extendedinfoformall.vatablenewnet, extendedinfoformall.vatableoldnet, extendedinfoformall.vatablerefundamount, extendedinfoformall.vatablevoidamount
double: extendedinfoformall.vatexemptnewnet, extendedinfoformall.vatexemptoldnet, extendedinfoformall.vatexemptrefundamount, extendedinfoformall.vatexemptvoidamount, extendedinfoformall.voidamount, extendedinfoformall.voidtrxcount
double: grosssales, headcount, medalofvalordiscount, netsales, newgross, newnet
double: oldgross, oldnet, pwddiscount, refundamount, refundtrxcount, regulardiscount
double: salestrxcount, scdiscount, servicechargetax, soloparentdiscount, totaldeductedvat, transactionswithathleteandcoachdiscount
double: transactionswithmedalofvalordiscount, transactionswithpwddiscount, transactionswithregulardiscount, transactionswithscdiscount, vatablesales, vatamount
double: vatexemptsales, zcount, zeroratedsales
timestamp: closetime, data_modified_time, zendtime, zstarttime
numeric: servicecharge

-- registerlocalsettings__localsettings (349,408 rows, Other)
varchar: _id, key, registerlocalsettings_foreignkey, value
timestamp: data_modified_time

-- suppliers (300,459 rows, Other)
varchar: _id, business, city, contactname, country, email
varchar: fax, name, phone, postalcode, state, street1
varchar: street2, website
timestamp: data_modified_time

-- customerpoints (291,139 rows, Loyalty)
varchar: _id, customerid, merchantname, source, sourcerefid
double: balance, earnpointsunit, pointrate
timestamp: createdtime, data_modified_time, expirydate, modifiedtime
numeric: total

-- purchaseorders (289,254 rows, Other)
varchar: _id, business, completedby, inventorychangemsgtrackinfo.eventid, notes, status
varchar: supplierid, targetstoreid
timestamp: createdtime, data_modified_time, expectedarrivaldate, inventorychangemsgtrackinfo.sendmsgstartat, modifiedtime
numeric: discount, subtotal, tax, total
boolean: failedtoupdateinventory, inventorychangemsgtrackinfo.issendmsg
double: purchaseorderid

-- promotioncustomers (274,759 rows, Marketing)
varchar: _id, business, consumerid, customerid, promotioncode, promotionid
varchar: rewardsettingid, rewardsource, rewardssetid, status
timestamp: createdtime, data_modified_time, lastredemptiontime, updatedat, validfrom, validto
boolean: isdeleted
double: restclaimcount, rewardbirthdayrewardsyear

-- paymentsettlements__orders (268,970 rows, Payments)
varchar: _id, paymentgateway, paymentsettlements_foreignkey, receiptnumber
timestamp: createdtime, data_modified_time
double: deliveryrevenue, paymentgatewaycost, paymentgatewayfee, paymentgatewayrevenue, payout, productrevenue
double: storehubfee, storehublogisticscost, storehublogisticsfee, storehublogisticsrevenue
numeric: total

-- promotions (231,293 rows, Marketing)
varchar: _id, appliedclienttypes, appliedsources, appliedstores, business, createdby
varchar: discounttype, modifiedby, name, promotioncode, taxcode, type
varchar: validdays
boolean: applytoonlinestore, enablebeeptagandbanner, enableclaimlimit, enableduniquepromotioncode, enableperbusinessclaimlimit, enablepercustomerclaimlimit
boolean: isbindcampaign, isdeleted, iseligibletoshowonbeep, isenabled, isrepeatable, requirefirstpurchase
double: claimedcount, costpersms, discountvalue, maxclaimcount, maxdiscountamount, maxquantity
double: minquantity, ordering, perbusinessclaimlimit, percustomerclaimlimit, storehubpaidpercentage, totalsmssent
double: validtimefrom, validtimeto
timestamp: createdtime, data_modified_time, modifiedtime, validfrom, validto

-- employees__passwordsettingtokens (228,732 rows, Employees)
varchar: _id, employees_foreignkey, token
timestamp: data_modified_time, expirydate
boolean: isredeemed

-- sharedmodifiers__optionvalues (172,384 rows, Other)
varchar: _id, sharedmodifiers_foreignkey, soldoutstoreids, value
timestamp: data_modified_time
boolean: isdefault, markedsoldout
double: order, pricediff, pricediffbeforegstadjustment

-- transactionrecords__returnprocess__selectedoptions (167,197 rows, Transactions)
varchar: _id, optionid, optionvalue, transactionrecords__returnprocess_foreignkey, transactionrecords_foreignkey, variationid
timestamp: data_modified_time
double: quantity

-- stocktransfers__ordereditems__componentsusages (139,083 rows, Inventory)
varchar: _id, productid, stocktransfers__ordereditems_foreignkey, stocktransfers_foreignkey
timestamp: data_modified_time, lockeddate
double: lockedquantity, quantity

-- onlinecategories__conditions (131,359 rows, Online Store)
varchar: _id, onlinecategories_foreignkey, operand, operator, type
timestamp: data_modified_time

-- reviewinfohistories (128,507 rows, Other)
varchar: _id, business, placeid, refid, reftype
timestamp: createdtime, data_modified_time, modifiedtime
double: pricelevel, rating, ratingcount

-- businesses__stores (125,809 rows, Businesses)
varchar: _id, beepbrandname, beepstorenamelocationsuffix, brn, businesses_foreignkey, cashieraccesses
varchar: city, companyname, confirmbirtoken, country, einvoicesetting.countrycode, einvoicesetting.industry
varchar: einvoicesetting.msiccode, einvoicesetting.msicdescription, einvoicesetting.nric, einvoicesetting.statecode, einvoicesetting.tin, email
varchar: fax, fulfillmentoptions, gstid, mallintegrationchannel, name, notes
varchar: operationhours, ordernotificationemail, phone, postalcode, qrregisters, receipttemplate
varchar: sstid, state, street1, street2, website
boolean: birrequested, einvoicesetting.isconsolidationon, einvoicesetting.iseinvoiceready, enabledigital, hassupplyneeds, isbiraccredited
boolean: isdeleted, ismallintegrationenabled, isonezreadingperdayenabled, isonline, isvatregistered, kds
boolean: ncs, paidordernotification, pendingpaymentordernotification, pendingverificationordernotification
timestamp: data_modified_time, firstaccreditbirtime
double: industry

-- businesses__paymentoptions (100,919 rows, Businesses)
varchar: _id, additionalinfo, businesses_foreignkey, cashregisters, name, stores
varchar: type
timestamp: data_modified_time
boolean: isdeleted, isdisabled, isexcludedfromeinvoice
double: ordering, paymentid

-- businesses__cashregisters (78,646 rows, Businesses)
varchar: _id, apitoken, appversion, businesses_foreignkey, defaulttablelayoutsection, minno
varchar: model, name, oldapitoken, platform, ptu, ptudateissued
varchar: ptuvalideuntil, pushprovider, quickselectlayoutid, serialno, snsendpointarn, storeid
varchar: token
double: activationcode, badgenumber, beepbadgenumber, ecommercebadgenumber, onlinebadgenumber, registerid
double: trialperiod
timestamp: data_modified_time
boolean: isactivated, tablelayoutenabled

-- businesses__taxcodes (73,434 rows, Businesses)
varchar: _id, businesses_foreignkey, name
timestamp: data_modified_time
boolean: isamusementtax, isdeleted, isvatexempted
double: rate

-- subscriptions (59,084 rows, Other)
varchar: _id, business, creditcardaddedway, softwareorderid, subscriptionid
timestamp: data_modified_time, lasteventtime, subscriptioncreatedtime
boolean: hasscheduledchanges
double: softwareorderamount

-- businesses (58,138 rows, Businesses)
varchar: _id, addonids, advanceinvoiceid, autocountaccountingcode, autosmscreditsdiscountinfoid, billingcurrency
varchar: businessstatus, businesstype, cashbackexpirationduration.durationunit, cashbackpopedupemployees, chargebeecustomerid, country
varchar: coupon, creditcardexpirydate, creditcardtype, currency, defaultkitchenprinter, defaultproductclassificationcode
varchar: defaulttaxcode, disableddefaultpayments, displaybusinessname, email, enablethirdparty, facebookid
varchar: hasdevicetype, industry, integrationapitoken, kitchenprinters, maskedcardnumber, name
varchar: ongoingsubscriptionorderid, ordersummaryprinter, phone, planid, plivoauthid, plivoauthtoken
varchar: pointsexpirationduration.durationunit, salesforceopportunityid, scheduledby, servicechargetax, smsfrom, smsnotifications
varchar: softwareorderid, sqlaccoutingcode, status, storeswithfixedsupplierprice, subscriptionid, subscriptionstatus
varchar: timezone
timestamp: activatedat, campaigntrialstartdate, cashbacktrialexpirydate, createdtime, creditcardmodifieddate, data_modified_time
timestamp: firstenablecashbackdate, firstenableqrorderingdate, firstmembershipenabledtime, firstpointsenabledtime, lastchargebeeeventtime, lastenablecashbackdate
timestamp: lastenableqrorderingdate, lastpointsdisabledtime, membershipsetting.activatedat, membershipsetting.firstgoliveat, membershipsetting.trialendat, nextbillingdate
timestamp: pointsexpirationduration.lastupdatetime, subscriptionenddate, subscriptionstartdate, trialends
boolean: added60daysfreesmscredits, allowanonymousqrordering, alloweditproductsonpos, assigntableid, autoorderid, billingperiodchanged
boolean: cashbackclaimautorefill, cashbacktrailexpiredalertclosed, cashbacktrailstartedalertclosed, claimcashbacklimit, customerexceedthreshold, disablecashbackfrompos
boolean: enablecashback, enablegroupitem, enableloyalty, enablemultipleipads, enableonlinechannelsinpaymentsreport, enableonlinestorefeature
boolean: enablepax, enableqrorderingfeature, enablereportdriver, enablerounding, enableservicecharge, enablesmsnotifications
boolean: enabletakeaway, enableweights, existingcampaignuser, hascreditedreferrer, includingtaxindisplay, isautosms
boolean: iseinvoiceenabled, isenablebeepqremailsent, isinitializing, isinventorywebhookenabled, isonjimacforbir, isonline
boolean: isonlinestorepublished, isonlinestorerequested, ispositiveinvstockmanageenabled, isqrorderingenabled, issupplierpricefixedforallstores, membershipenabled
boolean: membershipsetting.islive, notrenewing, othermposenabled, permanentoldpricingextrastores, pointsenabled, remainingtrialperiodadded
boolean: roundalltransactions, separatekitchenitems, sequentialreceiptnumber, skipeasyenablement, smscreditslow, softwareorderpaymentapproved
boolean: specialsubscription, usestorehubpay
double: autolowsmscredits, autorechargesmscredits, campaignenabledtime, campaigntrialendtime, cashbackclaimplanused, cashbackclaimtopuptotal
double: cashbackclaimtopupused, cashbackclaimtrailcount, cashbackexpirationduration.durationnumber, claimcashbackcountperday, claimpointscountperday, defaultloyaltyratio
double: extrastoreoldpricingquota, hubspotdealid, lastmaxbarcode, lastpopupeasyenablement, lastrevenuecheckingtime, liteplanexceedlimitmonths
double: lockedsmscredits, maxofflinedays, mrr, numberofstores, operationhours, paidextraregisters
double: paidextrastores, paidregisters, pointsexpirationduration.durationnumber, remainingtrialperiod, roundingto, scheduledactivationtime
double: servicechargerate, smscredits, smscreditsavgcost, softwareorderamount, takeawaycharge, taxrate
double: totalsubfeepaid, trialextraregister

-- storereviews (52,469 rows, Other)
varchar: _id, business, comments, contactname, contactphone, placeid
varchar: receiptnumber, storeid
boolean: allowmerchantcontact
double: clickcount, rating
timestamp: createdtime, data_modified_time, modifiedtime

-- payoutitems__adjustmentdetails__adjustmentitems (50,257 rows, Payments)
varchar: _id, payoutitems__adjustmentdetails_foreignkey, payoutitems_foreignkey, refid, reftype, title
varchar: type
numeric: amount
timestamp: data_modified_time
double: quantity

-- comments (49,467 rows, Other)
varchar: _id, content, refid, type, useravatar, useremail
varchar: userid, username
timestamp: createdtime, data_modified_time, modifiedtime
boolean: isdeleted

-- payoutitems__adjustmentdetails (48,582 rows, Payments)
varchar: _id, payoutitems_foreignkey, reason, remarks
numeric: amount
timestamp: data_modified_time

-- inventorychangeevents (45,800 rows, Inventory)
varchar: _id, business, eventid, eventtype, failreason, rules
varchar: sourceinfo.customfields, sourceinfo.refid, status, storeid, updaterule
timestamp: createdat, data_modified_time, eventstartat, failedat, rollbackedat, rollbackfailedat
timestamp: succeededat, updatedat
boolean: createinvifnotexist, iseventidscleared, isneedmanualcheck, needdedupmsg
double: retrycount

-- businesses__qrorderingsettings (45,612 rows, Businesses)
varchar: _id, businesses_foreignkey, defaultshippingzoneid, defaultshippingzonemethodid, marketingtags, searchingtags
varchar: storesenabledpaybycash, storesenabledpaylater, validdays, validtimefrom, validtimeto
timestamp: data_modified_time, firstenabledeliverydate, firstenablepreorderdeliverydate
double: deliveryradius, minimumconsumption
boolean: disableguestlogin, disabletodaypreorder, enabledelivery, enabledeliveryliveonline, enableliveonline, enablepaybycash
boolean: enablepaylater, enablepreorder, hidefrombeepcom, sellalcohol, sellnonhalalfood, sellpork
boolean: usestorehublogistics

-- businesses__cashregisters__location (44,928 rows, Businesses)
varchar: _id, businesses__cashregisters_foreignkey, businesses_foreignkey, coordinates, type
timestamp: data_modified_time

-- businesses__stores__location (44,517 rows, Businesses)
varchar: _id, businesses__stores_foreignkey, businesses_foreignkey, coordinates, type
timestamp: data_modified_time

-- sharedmodifiers (40,830 rows, Other)
varchar: _id, business, name, sharedmodifierid, variationtype
boolean: allowmultiqty, enableselectionamountlimit, ismodifier
timestamp: createdat, data_modified_time, updatedat
double: maxselectionamount, minselectionamount

-- onlinestoreinfos (37,258 rows, Online Store)
varchar: _id, aboutstore, alternatephone1, alternatephone2, beepbrandname, beepprofileimage
varchar: business, connectstatus, customdomain, email, enabledchattype, facebookdomainverification
varchar: favicon, featuredproducts, logo, operationhours, phone, postcode
varchar: state, storename, street, themecolor
timestamp: data_modified_time, firstenabledate, firstpublishdate, lastenabledate, lastpublishdate
boolean: haslogo

-- feedbacks (34,308 rows, Other)
varchar: _id, email, image, logisticsprovider, notes, reasoncode
varchar: receiptnumber, reportertype
timestamp: createdtime, data_modified_time, modifiedtime
double: status

-- businesses__stores__pickupaddress (33,643 rows, Businesses)
varchar: _id, businesses__stores_foreignkey, businesses_foreignkey, coordinate, googlemapsplaceid, googlemapsurl
varchar: location, placename
timestamp: data_modified_time

-- shippingzones (31,338 rows, Logistics)
varchar: _id, business, country, coveredcountries, logisticsridetype, name
varchar: postcodes, shippingtype, states
timestamp: data_modified_time
double: distance

-- shippingzones__deliverymethods (31,338 rows, Logistics)
varchar: _id, name, shippingtimeunit, shippingzones_foreignkey, type
timestamp: data_modified_time
boolean: enableconditionalfreeshipping
double: maxshippingtime, minshippingtime, rate

-- businesses__stores__pickupaddress__addresscomponents (30,429 rows, Businesses)
varchar: _id, businesses__stores__pickupaddress_foreignkey, businesses_foreignkey, city, country, state
varchar: street1, street2
timestamp: data_modified_time

-- qbosettings__qboaccounts (29,017 rows, Other)
varchar: _id, classification, id, name, qbosettings_foreignkey
timestamp: data_modified_time

-- logisticslogs (27,258 rows, Logistics)
varchar: _id, body, id, name, operationtype, operatorname
varchar: receiptnumber, ridetype, status, type
timestamp: data_modified_time, time
double: deliverydistance, deliveryfee

-- campaignsegments__nestedsource__filters (25,499 rows, Marketing)
varchar: _id, campaignsegments__nestedsource_foreignkey, campaignsegments_foreignkey, condition, defaultcomparedvalue, funcname
varchar: key, segmentruletype, symbol, valuedate, valuenumber, valuestring
timestamp: data_modified_time

-- xerosettings__accounts (25,457 rows, Other)
varchar: _id, code, id, name, type, xerosettings_foreignkey
timestamp: data_modified_time
boolean: enablepaymentstoaccount

-- transactionrecords__appliedvoucher (25,133 rows, Transactions)
varchar: _id, purchasechannel, transactionrecords_foreignkey, vouchercode, voucherid
numeric: cost
boolean: coveredbysh
timestamp: data_modified_time
double: value

-- products__beerdocketsettings (24,115 rows, Products)
varchar: _id, products_foreignkey
timestamp: data_modified_time
double: docketcount, expirationdateduration
boolean: isenable

-- shippingzones__deliverymethods__ratecalculation (22,638 rows, Logistics)
varchar: _id, shippingzones__deliverymethods_foreignkey, shippingzones_foreignkey
timestamp: data_modified_time

-- shippingzones__deliverymethods__ratecalculation__additions (22,638 rows, Logistics)
varchar: _id, shippingzones__deliverymethods__ratecalculation_foreignkey, shippingzones_foreignkey
double: additionalmeasurevalue, additionalrate
timestamp: data_modified_time

-- shippingzones__deliverymethods__ratecalculation__additions__measure (22,638 rows, Logistics)
varchar: _id, shippingzones__deliverymethods__ratecalculation__additions_foreignkey, shippingzones_foreignkey, type, unit
timestamp: data_modified_time
double: maxvalue, minvalue

-- shippingzones__deliverymethods__ratecalculation__firstbase (22,638 rows, Logistics)
varchar: _id, shippingzones__deliverymethods__ratecalculation_foreignkey, shippingzones_foreignkey
timestamp: data_modified_time
double: originalrate, rate

-- shippingzones__deliverymethods__ratecalculation__firstbase__measure (22,638 rows, Logistics)
varchar: _id, shippingzones__deliverymethods__ratecalculation__firstbase_foreignkey, shippingzones_foreignkey, type, unit
timestamp: data_modified_time
double: maxvalue, minvalue

-- registerlocalsettings (21,748 rows, Other)
varchar: _id, businessname, registerid
timestamp: data_modified_time

-- purchaseorders__ordereditems__componentsusages (21,380 rows, Other)
varchar: _id, productid, purchaseorders__ordereditems_foreignkey, purchaseorders_foreignkey
timestamp: data_modified_time, lockeddate
double: lockedquantity, quantity

-- subscriptionorders (21,109 rows, Other)
varchar: _id, action, business, errorcode, ordertype, paymentgateway
varchar: paymentid, paymentmethod, paymentprovider, planid, shortid, status
timestamp: createdtime, data_modified_time, updatedtime
double: discountamount, expirationseconds, numberofrenewals, price, taxamount
boolean: isb2bpayment, outdated

-- fooddeliveryplatformsettings__outlets__grabitemmappings (20,492 rows, Digital Ordering)
varchar: _id, fooddeliveryplatformsettings__outlets_foreignkey, fooddeliveryplatformsettings_foreignkey, grabitemid, sectionid, storehubitemid
timestamp: data_modified_time

-- einvoicerequestrecords (20,478 rows, Other)
varchar: _id, addonrequestinfo, business, einvoicedocumenttype, rawrequestinfo, receiptnumbers
varchar: requestor.requestorid, requestor.requestortype, requestresult.documentid, requestresult.documentlongid, requestresult.einvoicestatus, requestresult.errormessage
varchar: requestresult.submitid, requesttype, storeid, submitcontent
timestamp: createdat, data_modified_time, requestresult.statusupdatedat, updatedat
boolean: isonline

-- promotions__requiredproducts (19,765 rows, Marketing)
varchar: _id, entity, operand, operator, promotions_foreignkey, propertyname
timestamp: data_modified_time
double: maxquantity, minquantity

-- campaignsegments (19,346 rows, Marketing)
varchar: _id, business, name
timestamp: createdtime, data_modified_time, modifiedtime

-- campaignsegments__nestedsource (19,346 rows, Marketing)
varchar: _id, campaignsegments_foreignkey, groupbys, source
timestamp: data_modified_time

-- bankaccounts (17,812 rows, Other)
varchar: _id, appliedstores, bankaccountnumber, bankcode, bankname, business
varchar: emails, holdername
timestamp: createdtime, data_modified_time, updatedtime
boolean: isdeleted

-- campaigns (17,481 rows, Marketing)
varchar: _id, brandname, business, campaigntype, channel, conditiontype
varchar: cron, cronjobkey, globalcampaigninformationid, initialsegmentid, name, segmentid
varchar: selectedtemplatelanguage, status, template, timezone, version
timestamp: createdtime, data_modified_time, endtime, modifiedtime, starttime
double: delay
boolean: isactive, isinitial

-- businesses__stores__qrorderingsettings (16,066 rows, Businesses)
varchar: _id, breaktimefrom, breaktimeto, businesses__stores_foreignkey, businesses_foreignkey, pausemodesettings.shippingtypes
varchar: validdays, validtimefrom, validtimeto
timestamp: data_modified_time, firstenablepreorderdeliverydate
boolean: disableondemandorder, disabletodaypreorder, enablepertimeslotlimitforpreorder, enablepreorder, enableselfpickupalert
double: maxpreorderspertimeslot, pausemodesettings.endingat

-- shippingzones__deliverymethods__freeconditions (15,261 rows, Logistics)
varchar: _id, entity, operand, operator, propertyname, shippingzones__deliverymethods_foreignkey
varchar: shippingzones_foreignkey
timestamp: data_modified_time

-- shareinforequests (11,384 rows, Other)
varchar: _id, consumerid, customerid, employeeid, merchantname, registerid
varchar: source, storeid
timestamp: createdtime, data_modified_time, expireddate, modifiedtime, scanneddate, sharedinfodate
boolean: isnewcustomer, isnewmember

-- subscriptions__addons (11,129 rows, Other)
double: count, unitprice
timestamp: data_modified_time
varchar: id, subscriptions_foreignkey

-- businesses__cashregisters__device (11,032 rows, Businesses)
varchar: _id, businesses__cashregisters_foreignkey, businesses_foreignkey, model, platform, version
timestamp: data_modified_time

-- reviewinfos (7,525 rows, Other)
varchar: _id, business, placeid, refid, reftype
timestamp: createdtime, data_modified_time, modifiedtime
double: pricelevel, rating, ratingcount

-- customtransactionfeerates (6,757 rows, Other)
varchar: _id, business
timestamp: createdtime, data_modified_time, modifiedtime

-- customtransactionfeerates__rateconfig (6,757 rows, Other)
varchar: _id, customtransactionfeerates_foreignkey
double: beepdelivery, beepinstore, beeppickup, beepselfdelivery, beeptakeaway, ecommerce
timestamp: data_modified_time

-- businesses__stores__qrorderingsettings__vacations (6,194 rows, Businesses)
varchar: _id, businesses__stores__qrorderingsettings_foreignkey, businesses_foreignkey, vacationtimefrom, vacationtimeto
timestamp: data_modified_time

-- userjobs (5,589 rows, Other)
varchar: _id, business, employeeid, error, jobtype, resultsfile
varchar: status, uploadedfile
timestamp: data_modified_time, time
double: progress

-- businesses__addons (4,746 rows, Businesses)
varchar: _id, businesses_foreignkey, id
double: count
timestamp: data_modified_time

-- rewardsettings (4,620 rows, Loyalty)
varchar: _id, merchantname, rewardgroupid, rewardrefid, rewardsource, rewardtype
varchar: validperiodunit
double: aheadofdays, costofpoints, tierlevel, validperiod
timestamp: createdtime, data_modified_time, modifiedtime
boolean: isdeleted, isenabled, isstackable

-- qbosettings__qbotaxcodes (4,447 rows, Other)
varchar: _id, qbosettings_foreignkey, taxcodeid, taxcodename
timestamp: data_modified_time

-- timesheets (3,752 rows, Other)
varchar: _id, clockinimage, clockoutimage, employeeid, storeid
timestamp: clockintime, clockouttime, data_modified_time

-- onlinestoreinfos__socialmediainfo (3,450 rows, Online Store)
varchar: _id, instagram, onlinestoreinfos_foreignkey, twitter, whatsapp, youtube
timestamp: data_modified_time

-- onlinestoreinfos__socialmediainfo__facebook (3,450 rows, Online Store)
varchar: _id, greetingmessage, language, onlinestoreinfos__socialmediainfo_foreignkey, onlinestoreinfos_foreignkey, pageid
varchar: themecolor
timestamp: data_modified_time

-- onlinestoreinfos__socialmediainfo__line (3,450 rows, Online Store)
varchar: _id, officialline, onlinestoreinfos__socialmediainfo_foreignkey, onlinestoreinfos_foreignkey, personalline
timestamp: data_modified_time
boolean: usepersonalline

-- onlinestoreinfos__socialmediainfo__viber (3,450 rows, Online Store)
varchar: _id, officialviber, onlinestoreinfos__socialmediainfo_foreignkey, onlinestoreinfos_foreignkey, personalviber
timestamp: data_modified_time
boolean: usepersonalviber

-- stockreturns__returneditems__componentsusages (3,370 rows, Inventory)
varchar: _id, productid, stockreturns__returneditems_foreignkey, stockreturns_foreignkey
timestamp: data_modified_time, lockeddate
double: lockedquantity, quantity

-- fooddeliveryplatformsettings (2,514 rows, Digital Ordering)
varchar: _id, addonversion, business
timestamp: data_modified_time
boolean: hadenabled, isenabled
double: platform

-- qbosettings (2,398 rows, Other)
varchar: _id, accesstoken, accesstokensecret, accountmapping, businessname, companyid
varchar: customerid, pausereason, paymentmethodmapping, refreshtoken, refundfromaccountid, requesttoken
varchar: requesttokensecret, state, status, taxcodemapping, unmappedtaxcode
double: accesstokenexpiresin, refreshtokenexpiresin
timestamp: data_modified_time, starttime
boolean: firstconnected, hasrequestedstart, isallproductsmatched

-- businesses__nagbar (2,259 rows, Businesses)
varchar: _id, businesses_foreignkey
timestamp: data_modified_time
boolean: isnagbarhide, ispickuponly

-- businesses__ownertransfertokens (2,079 rows, Businesses)
varchar: _id, businesses_foreignkey, newownerid, status, token
timestamp: data_modified_time, expirydate

-- fooddeliveryplatformsettings__outlets (1,717 rows, Digital Ordering)
varchar: _id, addonaccount, addonpwd, fooddeliveryplatformsettings_foreignkey, grabportalorderpollendat, grabportalorderpollstartat
varchar: outletid, sectionids, storeid, taxcode
timestamp: data_modified_time
boolean: hadenabled, isenabled, islived, isrequested, issynctaxexclusiveprice

-- businesses__excludeservicechargeproductcondition (1,427 rows, Businesses)
varchar: _id, businesses_foreignkey, conditionsmatch
timestamp: data_modified_time
boolean: isenabled

-- qbosettings__qbopaymentmethods (1,375 rows, Payments)
varchar: _id, paymentmethodid, paymentmethodname, qbosettings_foreignkey
timestamp: data_modified_time

-- businesses__stores__reviewinfo (1,234 rows, Businesses)
varchar: _id, businesses__stores_foreignkey, businesses_foreignkey
timestamp: data_modified_time
double: rating, ratingcount

-- onlinestoreinfos__customizecommissionrates (1,176 rows, Online Store)
varchar: _id, onlinestoreinfos_foreignkey
double: beepdelivery, beepinstore, beeppickup, beeptakeaway, ecommerce
timestamp: data_modified_time

-- onlinestoreinfos__analytictools (972 rows, Online Store)
varchar: _id, name, onlinestoreinfos_foreignkey, trackingid
timestamp: data_modified_time

-- transactionrecords__review (949 rows, Transactions)
varchar: _id, comments, transactionrecords_foreignkey
boolean: allowmerchantcontact
timestamp: data_modified_time
double: rating

-- thirdpartyonlineorders (701 rows, Online Store)
varchar: _id, content, orderid
double: channel
timestamp: data_modified_time
boolean: iscancellationnottakeeffect

-- onlinestoreinfos__bankingdetails (617 rows, Online Store)
varchar: _id, bankaccountnumber, bankaddress, bankcode, bankname, beneficiaryaccountname
varchar: beneficiaryaddress, beneficiaryphonenumber, onlinestoreinfos_foreignkey
timestamp: data_modified_time

-- xerosettings (539 rows, Other)
varchar: _id, accesstoken, accesstokensecret, accountmapping, businessname, companyid
varchar: customerid, oauthsessionhandle, organizationname, pausereason, paymentmethodmapping, previousstatus
varchar: refreshtoken, refundfromaccountid, requesttoken, requesttokensecret, state, status
varchar: taxcodemapping, unmappedtaxcode
double: accesstokenexpiresin, expiresat, refreshtokenexpiresin
timestamp: data_modified_time, oauthexpiresat, starttime
boolean: firstconnected, hasrequestedstart, isallproductsmatched

-- onlinestoreinfos__offlinepaymentinstructions (470 rows, Payments)
varchar: _id, additionalnotes, enabledcontactinfo, onlinestoreinfos_foreignkey
timestamp: data_modified_time

-- onlinestoreinfos__offlinepaymentbankaccounts (437 rows, Payments)
varchar: _id, bankaccountname, bankaccountnumber, bankname, onlinestoreinfos_foreignkey
timestamp: data_modified_time
double: ordering

-- xerosettings__taxcodes (430 rows, Other)
varchar: _id, taxcodeid, taxcodename, xerosettings_foreignkey
timestamp: data_modified_time

-- shifts (365 rows, Other)
varchar: _id, beeptransactionids, beeptransactions, business, closeby, detailaccountingsyncstatus
varchar: loyaltydiscounts, minno, openby, qboinvoiceid, registerappversion, registerid
varchar: registerobjectid, registertransactionids, registertransactions, servicecharge, shiftid, storeid
double: cancelledamount, cancelledcount, cashreturnsroundedamount, cashsalesroundedamount, closingamount, discountedamount
double: discountedcount, openingamount, qbosynctime, returnsroundedamount, salesroundedamount, totalsalesamount
double: transactioncount
timestamp: closetime, data_modified_time, opentime
boolean: enablecashback, isaccountingsynced

-- shifts__taxsummary (282 rows, Other)
varchar: _id, name, shifts_foreignkey, taxcodeid
numeric: amount
timestamp: data_modified_time
double: rate

-- transactionrecords__pickupinformation__store__reviewinfo (240 rows, Transactions)
varchar: _id, transactionrecords__pickupinformation__store_foreignkey, transactionrecords_foreignkey
timestamp: data_modified_time
double: rating, ratingcount

-- searchingtags (151 rows, Other)
varchar: _id, createdby, tagname, tagtype
timestamp: createdtime, data_modified_time, updatedtime

-- onlinestoreinfos__onlinepaymentoptions (74 rows, Payments)
varchar: _id, additionalinfo, name, onlinestoreinfos_foreignkey
timestamp: data_modified_time
boolean: isdisabled

-- marketingtags (56 rows, Other)
varchar: _id, businesses, createdby, modifiedby, tagname
timestamp: createdtime, data_modified_time, modifiedtime

-- promotions__rewardssettings (49 rows, Marketing)
varchar: _id, promotions_foreignkey, rewardstype, validunit
double: costofpoints, validnumber
timestamp: data_modified_time

-- rewardssets__promotionconfigs (43 rows, Marketing)
varchar: _id, promotionid, rewardssets_foreignkey, validunit
timestamp: data_modified_time
double: validnumber

-- onlinecategories (39 rows, Online Store)
varchar: _id, appliedsources, appliedstores, business, channels, conditionsmatch
varchar: name, slug, sortordering, sorttype
timestamp: data_modified_time
boolean: iseditable, isenabled
double: ordering

-- rewardssets (26 rows, Loyalty)
varchar: _id, business, type
timestamp: createdtime, data_modified_time, updatedtime
boolean: isenabled

-- businesses__fixedfeesettings (3 rows, Businesses)
varchar: _id, appliedstores, businesses_foreignkey, fulfillmentoption
numeric: amount
timestamp: data_modified_time
boolean: isenabled

-- KEY PATTERNS:
-- PK: _id | FK: *_foreignkey, businessid->businesses, customerid->customers, productid->products
-- Dates: createdtime, updatedtime, data_modified_time | Flags: isdeleted, isactive
-- Money: amount, total, subtotal, price, cost, discount, tax
