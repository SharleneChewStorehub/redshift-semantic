-- Priority Tables Schema for StoreHub Semantic Layer
-- Generated: 2025-07-16 21:53:20
-- Total Tables: 172
-- This file contains schema definitions for the 172 priority tables
-- identified for the semantic layer development

-- =====================================================
-- Category: Businesses
-- =====================================================

-- Table: businesses__stores (125,809 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores','_id','character varying'),
	 ('storehub_mongo','businesses__stores','beepbrandname','character varying'),
	 ('storehub_mongo','businesses__stores','beepstorenamelocationsuffix','character varying'),
	 ('storehub_mongo','businesses__stores','birrequested','boolean'),
	 ('storehub_mongo','businesses__stores','brn','character varying'),
	 ('storehub_mongo','businesses__stores','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores','cashieraccesses','character varying'),
	 ('storehub_mongo','businesses__stores','city','character varying'),
	 ('storehub_mongo','businesses__stores','companyname','character varying'),
	 ('storehub_mongo','businesses__stores','confirmbirtoken','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores','country','character varying'),
	 ('storehub_mongo','businesses__stores','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__stores','einvoicesetting.countrycode','character varying'),
	 ('storehub_mongo','businesses__stores','einvoicesetting.industry','character varying'),
	 ('storehub_mongo','businesses__stores','einvoicesetting.isconsolidationon','boolean'),
	 ('storehub_mongo','businesses__stores','einvoicesetting.iseinvoiceready','boolean'),
	 ('storehub_mongo','businesses__stores','einvoicesetting.msiccode','character varying'),
	 ('storehub_mongo','businesses__stores','einvoicesetting.msicdescription','character varying'),
	 ('storehub_mongo','businesses__stores','einvoicesetting.nric','character varying'),
	 ('storehub_mongo','businesses__stores','einvoicesetting.statecode','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores','einvoicesetting.tin','character varying'),
	 ('storehub_mongo','businesses__stores','email','character varying'),
	 ('storehub_mongo','businesses__stores','enabledigital','boolean'),
	 ('storehub_mongo','businesses__stores','fax','character varying'),
	 ('storehub_mongo','businesses__stores','firstaccreditbirtime','timestamp without time zone'),
	 ('storehub_mongo','businesses__stores','fulfillmentoptions','character varying'),
	 ('storehub_mongo','businesses__stores','gstid','character varying'),
	 ('storehub_mongo','businesses__stores','hassupplyneeds','boolean'),
	 ('storehub_mongo','businesses__stores','industry','double precision'),
	 ('storehub_mongo','businesses__stores','isbiraccredited','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores','isdeleted','boolean'),
	 ('storehub_mongo','businesses__stores','ismallintegrationenabled','boolean'),
	 ('storehub_mongo','businesses__stores','isonezreadingperdayenabled','boolean'),
	 ('storehub_mongo','businesses__stores','isonline','boolean'),
	 ('storehub_mongo','businesses__stores','isvatregistered','boolean'),
	 ('storehub_mongo','businesses__stores','kds','boolean'),
	 ('storehub_mongo','businesses__stores','mallintegrationchannel','character varying'),
	 ('storehub_mongo','businesses__stores','name','character varying'),
	 ('storehub_mongo','businesses__stores','ncs','boolean'),
	 ('storehub_mongo','businesses__stores','notes','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores','operationhours','character varying'),
	 ('storehub_mongo','businesses__stores','ordernotificationemail','character varying'),
	 ('storehub_mongo','businesses__stores','paidordernotification','boolean'),
	 ('storehub_mongo','businesses__stores','pendingpaymentordernotification','boolean'),
	 ('storehub_mongo','businesses__stores','pendingverificationordernotification','boolean'),
	 ('storehub_mongo','businesses__stores','phone','character varying'),
	 ('storehub_mongo','businesses__stores','postalcode','character varying'),
	 ('storehub_mongo','businesses__stores','qrregisters','character varying'),
	 ('storehub_mongo','businesses__stores','receipttemplate','character varying'),
	 ('storehub_mongo','businesses__stores','sstid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores','state','character varying'),
	 ('storehub_mongo','businesses__stores','street1','character varying'),
	 ('storehub_mongo','businesses__stores','street2','character varying'),
	 ('storehub_mongo','businesses__stores','website','character varying');

-- Table: businesses__paymentoptions (100,919 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__paymentoptions','_id','character varying'),
	 ('storehub_mongo','businesses__paymentoptions','additionalinfo','character varying'),
	 ('storehub_mongo','businesses__paymentoptions','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__paymentoptions','cashregisters','character varying'),
	 ('storehub_mongo','businesses__paymentoptions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__paymentoptions','isdeleted','boolean'),
	 ('storehub_mongo','businesses__paymentoptions','isdisabled','boolean'),
	 ('storehub_mongo','businesses__paymentoptions','isexcludedfromeinvoice','boolean'),
	 ('storehub_mongo','businesses__paymentoptions','name','character varying'),
	 ('storehub_mongo','businesses__paymentoptions','ordering','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__paymentoptions','paymentid','double precision'),
	 ('storehub_mongo','businesses__paymentoptions','stores','character varying'),
	 ('storehub_mongo','businesses__paymentoptions','type','character varying');

-- Table: businesses__cashregisters (78,646 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__cashregisters','_id','character varying'),
	 ('storehub_mongo','businesses__cashregisters','activationcode','double precision'),
	 ('storehub_mongo','businesses__cashregisters','apitoken','character varying'),
	 ('storehub_mongo','businesses__cashregisters','appversion','character varying'),
	 ('storehub_mongo','businesses__cashregisters','badgenumber','double precision'),
	 ('storehub_mongo','businesses__cashregisters','beepbadgenumber','double precision'),
	 ('storehub_mongo','businesses__cashregisters','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__cashregisters','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__cashregisters','defaulttablelayoutsection','character varying'),
	 ('storehub_mongo','businesses__cashregisters','ecommercebadgenumber','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__cashregisters','isactivated','boolean'),
	 ('storehub_mongo','businesses__cashregisters','minno','character varying'),
	 ('storehub_mongo','businesses__cashregisters','model','character varying'),
	 ('storehub_mongo','businesses__cashregisters','name','character varying'),
	 ('storehub_mongo','businesses__cashregisters','oldapitoken','character varying'),
	 ('storehub_mongo','businesses__cashregisters','onlinebadgenumber','double precision'),
	 ('storehub_mongo','businesses__cashregisters','platform','character varying'),
	 ('storehub_mongo','businesses__cashregisters','ptu','character varying'),
	 ('storehub_mongo','businesses__cashregisters','ptudateissued','character varying'),
	 ('storehub_mongo','businesses__cashregisters','ptuvalideuntil','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__cashregisters','pushprovider','character varying'),
	 ('storehub_mongo','businesses__cashregisters','quickselectlayoutid','character varying'),
	 ('storehub_mongo','businesses__cashregisters','registerid','double precision'),
	 ('storehub_mongo','businesses__cashregisters','serialno','character varying'),
	 ('storehub_mongo','businesses__cashregisters','snsendpointarn','character varying'),
	 ('storehub_mongo','businesses__cashregisters','storeid','character varying'),
	 ('storehub_mongo','businesses__cashregisters','tablelayoutenabled','boolean'),
	 ('storehub_mongo','businesses__cashregisters','token','character varying'),
	 ('storehub_mongo','businesses__cashregisters','trialperiod','double precision');

-- Table: businesses__taxcodes (73,434 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__taxcodes','_id','character varying'),
	 ('storehub_mongo','businesses__taxcodes','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__taxcodes','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__taxcodes','isamusementtax','boolean'),
	 ('storehub_mongo','businesses__taxcodes','isdeleted','boolean'),
	 ('storehub_mongo','businesses__taxcodes','isvatexempted','boolean'),
	 ('storehub_mongo','businesses__taxcodes','name','character varying'),
	 ('storehub_mongo','businesses__taxcodes','rate','double precision');

-- Table: businesses (58,138 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','_id','character varying'),
	 ('storehub_mongo','businesses','activatedat','timestamp without time zone'),
	 ('storehub_mongo','businesses','added60daysfreesmscredits','boolean'),
	 ('storehub_mongo','businesses','addonids','character varying'),
	 ('storehub_mongo','businesses','advanceinvoiceid','character varying'),
	 ('storehub_mongo','businesses','allowanonymousqrordering','boolean'),
	 ('storehub_mongo','businesses','alloweditproductsonpos','boolean'),
	 ('storehub_mongo','businesses','assigntableid','boolean'),
	 ('storehub_mongo','businesses','autocountaccountingcode','character varying'),
	 ('storehub_mongo','businesses','autolowsmscredits','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','autoorderid','boolean'),
	 ('storehub_mongo','businesses','autorechargesmscredits','double precision'),
	 ('storehub_mongo','businesses','autosmscreditsdiscountinfoid','character varying'),
	 ('storehub_mongo','businesses','billingcurrency','character varying'),
	 ('storehub_mongo','businesses','billingperiodchanged','boolean'),
	 ('storehub_mongo','businesses','businessstatus','character varying'),
	 ('storehub_mongo','businesses','businesstype','character varying'),
	 ('storehub_mongo','businesses','campaignenabledtime','double precision'),
	 ('storehub_mongo','businesses','campaigntrialendtime','double precision'),
	 ('storehub_mongo','businesses','campaigntrialstartdate','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','cashbackclaimautorefill','boolean'),
	 ('storehub_mongo','businesses','cashbackclaimplanused','double precision'),
	 ('storehub_mongo','businesses','cashbackclaimtopuptotal','double precision'),
	 ('storehub_mongo','businesses','cashbackclaimtopupused','double precision'),
	 ('storehub_mongo','businesses','cashbackclaimtrailcount','double precision'),
	 ('storehub_mongo','businesses','cashbackexpirationduration.durationnumber','double precision'),
	 ('storehub_mongo','businesses','cashbackexpirationduration.durationunit','character varying'),
	 ('storehub_mongo','businesses','cashbackpopedupemployees','character varying'),
	 ('storehub_mongo','businesses','cashbacktrailexpiredalertclosed','boolean'),
	 ('storehub_mongo','businesses','cashbacktrailstartedalertclosed','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','cashbacktrialexpirydate','timestamp without time zone'),
	 ('storehub_mongo','businesses','chargebeecustomerid','character varying'),
	 ('storehub_mongo','businesses','claimcashbackcountperday','double precision'),
	 ('storehub_mongo','businesses','claimcashbacklimit','boolean'),
	 ('storehub_mongo','businesses','claimpointscountperday','double precision'),
	 ('storehub_mongo','businesses','country','character varying'),
	 ('storehub_mongo','businesses','coupon','character varying'),
	 ('storehub_mongo','businesses','createdtime','timestamp without time zone'),
	 ('storehub_mongo','businesses','creditcardexpirydate','character varying'),
	 ('storehub_mongo','businesses','creditcardmodifieddate','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','creditcardtype','character varying'),
	 ('storehub_mongo','businesses','currency','character varying'),
	 ('storehub_mongo','businesses','customerexceedthreshold','boolean'),
	 ('storehub_mongo','businesses','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses','defaultkitchenprinter','character varying'),
	 ('storehub_mongo','businesses','defaultloyaltyratio','double precision'),
	 ('storehub_mongo','businesses','defaultproductclassificationcode','character varying'),
	 ('storehub_mongo','businesses','defaulttaxcode','character varying'),
	 ('storehub_mongo','businesses','disablecashbackfrompos','boolean'),
	 ('storehub_mongo','businesses','disableddefaultpayments','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','displaybusinessname','character varying'),
	 ('storehub_mongo','businesses','email','character varying'),
	 ('storehub_mongo','businesses','enablecashback','boolean'),
	 ('storehub_mongo','businesses','enablegroupitem','boolean'),
	 ('storehub_mongo','businesses','enableloyalty','boolean'),
	 ('storehub_mongo','businesses','enablemultipleipads','boolean'),
	 ('storehub_mongo','businesses','enableonlinechannelsinpaymentsreport','boolean'),
	 ('storehub_mongo','businesses','enableonlinestorefeature','boolean'),
	 ('storehub_mongo','businesses','enablepax','boolean'),
	 ('storehub_mongo','businesses','enableqrorderingfeature','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','enablereportdriver','boolean'),
	 ('storehub_mongo','businesses','enablerounding','boolean'),
	 ('storehub_mongo','businesses','enableservicecharge','boolean'),
	 ('storehub_mongo','businesses','enablesmsnotifications','boolean'),
	 ('storehub_mongo','businesses','enabletakeaway','boolean'),
	 ('storehub_mongo','businesses','enablethirdparty','character varying'),
	 ('storehub_mongo','businesses','enableweights','boolean'),
	 ('storehub_mongo','businesses','existingcampaignuser','boolean'),
	 ('storehub_mongo','businesses','extrastoreoldpricingquota','double precision'),
	 ('storehub_mongo','businesses','facebookid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','firstenablecashbackdate','timestamp without time zone'),
	 ('storehub_mongo','businesses','firstenableqrorderingdate','timestamp without time zone'),
	 ('storehub_mongo','businesses','firstmembershipenabledtime','timestamp without time zone'),
	 ('storehub_mongo','businesses','firstpointsenabledtime','timestamp without time zone'),
	 ('storehub_mongo','businesses','hascreditedreferrer','boolean'),
	 ('storehub_mongo','businesses','hasdevicetype','character varying'),
	 ('storehub_mongo','businesses','hubspotdealid','double precision'),
	 ('storehub_mongo','businesses','includingtaxindisplay','boolean'),
	 ('storehub_mongo','businesses','industry','character varying'),
	 ('storehub_mongo','businesses','integrationapitoken','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','isautosms','boolean'),
	 ('storehub_mongo','businesses','iseinvoiceenabled','boolean'),
	 ('storehub_mongo','businesses','isenablebeepqremailsent','boolean'),
	 ('storehub_mongo','businesses','isinitializing','boolean'),
	 ('storehub_mongo','businesses','isinventorywebhookenabled','boolean'),
	 ('storehub_mongo','businesses','isonjimacforbir','boolean'),
	 ('storehub_mongo','businesses','isonline','boolean'),
	 ('storehub_mongo','businesses','isonlinestorepublished','boolean'),
	 ('storehub_mongo','businesses','isonlinestorerequested','boolean'),
	 ('storehub_mongo','businesses','ispositiveinvstockmanageenabled','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','isqrorderingenabled','boolean'),
	 ('storehub_mongo','businesses','issupplierpricefixedforallstores','boolean'),
	 ('storehub_mongo','businesses','kitchenprinters','character varying'),
	 ('storehub_mongo','businesses','lastchargebeeeventtime','timestamp without time zone'),
	 ('storehub_mongo','businesses','lastenablecashbackdate','timestamp without time zone'),
	 ('storehub_mongo','businesses','lastenableqrorderingdate','timestamp without time zone'),
	 ('storehub_mongo','businesses','lastmaxbarcode','double precision'),
	 ('storehub_mongo','businesses','lastpointsdisabledtime','timestamp without time zone'),
	 ('storehub_mongo','businesses','lastpopupeasyenablement','double precision'),
	 ('storehub_mongo','businesses','lastrevenuecheckingtime','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','liteplanexceedlimitmonths','double precision'),
	 ('storehub_mongo','businesses','lockedsmscredits','double precision'),
	 ('storehub_mongo','businesses','maskedcardnumber','character varying'),
	 ('storehub_mongo','businesses','maxofflinedays','double precision'),
	 ('storehub_mongo','businesses','membershipenabled','boolean'),
	 ('storehub_mongo','businesses','membershipsetting.activatedat','timestamp without time zone'),
	 ('storehub_mongo','businesses','membershipsetting.firstgoliveat','timestamp without time zone'),
	 ('storehub_mongo','businesses','membershipsetting.islive','boolean'),
	 ('storehub_mongo','businesses','membershipsetting.trialendat','timestamp without time zone'),
	 ('storehub_mongo','businesses','mrr','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','name','character varying'),
	 ('storehub_mongo','businesses','nextbillingdate','timestamp without time zone'),
	 ('storehub_mongo','businesses','notrenewing','boolean'),
	 ('storehub_mongo','businesses','numberofstores','double precision'),
	 ('storehub_mongo','businesses','ongoingsubscriptionorderid','character varying'),
	 ('storehub_mongo','businesses','operationhours','double precision'),
	 ('storehub_mongo','businesses','ordersummaryprinter','character varying'),
	 ('storehub_mongo','businesses','othermposenabled','boolean'),
	 ('storehub_mongo','businesses','paidextraregisters','double precision'),
	 ('storehub_mongo','businesses','paidextrastores','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','paidregisters','double precision'),
	 ('storehub_mongo','businesses','permanentoldpricingextrastores','boolean'),
	 ('storehub_mongo','businesses','phone','character varying'),
	 ('storehub_mongo','businesses','planid','character varying'),
	 ('storehub_mongo','businesses','plivoauthid','character varying'),
	 ('storehub_mongo','businesses','plivoauthtoken','character varying'),
	 ('storehub_mongo','businesses','pointsenabled','boolean'),
	 ('storehub_mongo','businesses','pointsexpirationduration.durationnumber','double precision'),
	 ('storehub_mongo','businesses','pointsexpirationduration.durationunit','character varying'),
	 ('storehub_mongo','businesses','pointsexpirationduration.lastupdatetime','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','remainingtrialperiod','double precision'),
	 ('storehub_mongo','businesses','remainingtrialperiodadded','boolean'),
	 ('storehub_mongo','businesses','roundalltransactions','boolean'),
	 ('storehub_mongo','businesses','roundingto','double precision'),
	 ('storehub_mongo','businesses','salesforceopportunityid','character varying'),
	 ('storehub_mongo','businesses','scheduledactivationtime','double precision'),
	 ('storehub_mongo','businesses','scheduledby','character varying'),
	 ('storehub_mongo','businesses','separatekitchenitems','boolean'),
	 ('storehub_mongo','businesses','sequentialreceiptnumber','boolean'),
	 ('storehub_mongo','businesses','servicechargerate','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','servicechargetax','character varying'),
	 ('storehub_mongo','businesses','skipeasyenablement','boolean'),
	 ('storehub_mongo','businesses','smscredits','double precision'),
	 ('storehub_mongo','businesses','smscreditsavgcost','double precision'),
	 ('storehub_mongo','businesses','smscreditslow','boolean'),
	 ('storehub_mongo','businesses','smsfrom','character varying'),
	 ('storehub_mongo','businesses','smsnotifications','character varying'),
	 ('storehub_mongo','businesses','softwareorderamount','double precision'),
	 ('storehub_mongo','businesses','softwareorderid','character varying'),
	 ('storehub_mongo','businesses','softwareorderpaymentapproved','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','specialsubscription','boolean'),
	 ('storehub_mongo','businesses','sqlaccoutingcode','character varying'),
	 ('storehub_mongo','businesses','status','character varying'),
	 ('storehub_mongo','businesses','storeswithfixedsupplierprice','character varying'),
	 ('storehub_mongo','businesses','subscriptionenddate','timestamp without time zone'),
	 ('storehub_mongo','businesses','subscriptionid','character varying'),
	 ('storehub_mongo','businesses','subscriptionstartdate','timestamp without time zone'),
	 ('storehub_mongo','businesses','subscriptionstatus','character varying'),
	 ('storehub_mongo','businesses','takeawaycharge','double precision'),
	 ('storehub_mongo','businesses','taxrate','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses','timezone','character varying'),
	 ('storehub_mongo','businesses','totalsubfeepaid','double precision'),
	 ('storehub_mongo','businesses','trialends','timestamp without time zone'),
	 ('storehub_mongo','businesses','trialextraregister','double precision'),
	 ('storehub_mongo','businesses','usestorehubpay','boolean');

-- Table: businesses__qrorderingsettings (45,612 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__qrorderingsettings','_id','character varying'),
	 ('storehub_mongo','businesses__qrorderingsettings','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__qrorderingsettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__qrorderingsettings','defaultshippingzoneid','character varying'),
	 ('storehub_mongo','businesses__qrorderingsettings','defaultshippingzonemethodid','character varying'),
	 ('storehub_mongo','businesses__qrorderingsettings','deliveryradius','double precision'),
	 ('storehub_mongo','businesses__qrorderingsettings','disableguestlogin','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','disabletodaypreorder','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','enabledelivery','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','enabledeliveryliveonline','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__qrorderingsettings','enableliveonline','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','enablepaybycash','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','enablepaylater','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','enablepreorder','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','firstenabledeliverydate','timestamp without time zone'),
	 ('storehub_mongo','businesses__qrorderingsettings','firstenablepreorderdeliverydate','timestamp without time zone'),
	 ('storehub_mongo','businesses__qrorderingsettings','hidefrombeepcom','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','marketingtags','character varying'),
	 ('storehub_mongo','businesses__qrorderingsettings','minimumconsumption','double precision'),
	 ('storehub_mongo','businesses__qrorderingsettings','searchingtags','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__qrorderingsettings','sellalcohol','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','sellnonhalalfood','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','sellpork','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','storesenabledpaybycash','character varying'),
	 ('storehub_mongo','businesses__qrorderingsettings','storesenabledpaylater','character varying'),
	 ('storehub_mongo','businesses__qrorderingsettings','usestorehublogistics','boolean'),
	 ('storehub_mongo','businesses__qrorderingsettings','validdays','character varying'),
	 ('storehub_mongo','businesses__qrorderingsettings','validtimefrom','character varying'),
	 ('storehub_mongo','businesses__qrorderingsettings','validtimeto','character varying');

-- Table: businesses__cashregisters__location (44,928 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__cashregisters__location','_id','character varying'),
	 ('storehub_mongo','businesses__cashregisters__location','businesses__cashregisters_foreignkey','character varying'),
	 ('storehub_mongo','businesses__cashregisters__location','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__cashregisters__location','coordinates','character varying'),
	 ('storehub_mongo','businesses__cashregisters__location','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__cashregisters__location','type','character varying');

-- Table: businesses__stores__location (44,517 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores__location','_id','character varying'),
	 ('storehub_mongo','businesses__stores__location','businesses__stores_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__location','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__location','coordinates','character varying'),
	 ('storehub_mongo','businesses__stores__location','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__stores__location','type','character varying');

-- Table: businesses__stores__pickupaddress (33,643 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores__pickupaddress','_id','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress','businesses__stores_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress','coordinate','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__stores__pickupaddress','googlemapsplaceid','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress','googlemapsurl','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress','location','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress','placename','character varying');

-- Table: businesses__stores__pickupaddress__addresscomponents (30,429 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores__pickupaddress__addresscomponents','_id','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress__addresscomponents','businesses__stores__pickupaddress_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress__addresscomponents','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress__addresscomponents','city','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress__addresscomponents','country','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress__addresscomponents','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__stores__pickupaddress__addresscomponents','state','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress__addresscomponents','street1','character varying'),
	 ('storehub_mongo','businesses__stores__pickupaddress__addresscomponents','street2','character varying');

-- Table: businesses__stores__qrorderingsettings (16,066 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores__qrorderingsettings','_id','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','breaktimefrom','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','breaktimeto','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','businesses__stores_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','disableondemandorder','boolean'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','disabletodaypreorder','boolean'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','enablepertimeslotlimitforpreorder','boolean'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','enablepreorder','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores__qrorderingsettings','enableselfpickupalert','boolean'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','firstenablepreorderdeliverydate','timestamp without time zone'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','maxpreorderspertimeslot','double precision'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','pausemodesettings.endingat','double precision'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','pausemodesettings.shippingtypes','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','validdays','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','validtimefrom','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings','validtimeto','character varying');

-- Table: businesses__cashregisters__device (11,032 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__cashregisters__device','_id','character varying'),
	 ('storehub_mongo','businesses__cashregisters__device','businesses__cashregisters_foreignkey','character varying'),
	 ('storehub_mongo','businesses__cashregisters__device','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__cashregisters__device','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__cashregisters__device','model','character varying'),
	 ('storehub_mongo','businesses__cashregisters__device','platform','character varying'),
	 ('storehub_mongo','businesses__cashregisters__device','version','character varying');

-- Table: businesses__stores__qrorderingsettings__vacations (6,194 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores__qrorderingsettings__vacations','_id','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings__vacations','businesses__stores__qrorderingsettings_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings__vacations','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings__vacations','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings__vacations','vacationtimefrom','character varying'),
	 ('storehub_mongo','businesses__stores__qrorderingsettings__vacations','vacationtimeto','character varying');

-- Table: businesses__addons (4,746 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__addons','_id','character varying'),
	 ('storehub_mongo','businesses__addons','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__addons','count','double precision'),
	 ('storehub_mongo','businesses__addons','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__addons','id','character varying');

-- Table: businesses__nagbar (2,259 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__nagbar','_id','character varying'),
	 ('storehub_mongo','businesses__nagbar','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__nagbar','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__nagbar','isnagbarhide','boolean'),
	 ('storehub_mongo','businesses__nagbar','ispickuponly','boolean');

-- Table: businesses__ownertransfertokens (2,079 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__ownertransfertokens','_id','character varying'),
	 ('storehub_mongo','businesses__ownertransfertokens','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__ownertransfertokens','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__ownertransfertokens','expirydate','timestamp without time zone'),
	 ('storehub_mongo','businesses__ownertransfertokens','newownerid','character varying'),
	 ('storehub_mongo','businesses__ownertransfertokens','status','character varying'),
	 ('storehub_mongo','businesses__ownertransfertokens','token','character varying');

-- Table: businesses__excludeservicechargeproductcondition (1,427 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__excludeservicechargeproductcondition','_id','character varying'),
	 ('storehub_mongo','businesses__excludeservicechargeproductcondition','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__excludeservicechargeproductcondition','conditionsmatch','character varying'),
	 ('storehub_mongo','businesses__excludeservicechargeproductcondition','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__excludeservicechargeproductcondition','isenabled','boolean');

-- Table: businesses__stores__reviewinfo (1,234 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__stores__reviewinfo','_id','character varying'),
	 ('storehub_mongo','businesses__stores__reviewinfo','businesses__stores_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__reviewinfo','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__stores__reviewinfo','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__stores__reviewinfo','rating','double precision'),
	 ('storehub_mongo','businesses__stores__reviewinfo','ratingcount','double precision');

-- Table: businesses__fixedfeesettings (3 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','businesses__fixedfeesettings','_id','character varying'),
	 ('storehub_mongo','businesses__fixedfeesettings','amount','numeric'),
	 ('storehub_mongo','businesses__fixedfeesettings','appliedstores','character varying'),
	 ('storehub_mongo','businesses__fixedfeesettings','businesses_foreignkey','character varying'),
	 ('storehub_mongo','businesses__fixedfeesettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','businesses__fixedfeesettings','fulfillmentoption','character varying'),
	 ('storehub_mongo','businesses__fixedfeesettings','isenabled','boolean');

-- =====================================================
-- Category: Customers
-- =====================================================

-- Table: customers (47,663,764 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','customers','_id','character varying'),
	 ('storehub_mongo','customers','birthday','timestamp without time zone'),
	 ('storehub_mongo','customers','business','character varying'),
	 ('storehub_mongo','customers','cashbackclaimcnt','double precision'),
	 ('storehub_mongo','customers','cashbackexpirationdate','timestamp without time zone'),
	 ('storehub_mongo','customers','city','character varying'),
	 ('storehub_mongo','customers','consumerid','character varying'),
	 ('storehub_mongo','customers','createdatstoreid','character varying'),
	 ('storehub_mongo','customers','createdtime','timestamp without time zone'),
	 ('storehub_mongo','customers','customerid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','customers','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','customers','email','character varying'),
	 ('storehub_mongo','customers','facebook','character varying'),
	 ('storehub_mongo','customers','firstname','character varying'),
	 ('storehub_mongo','customers','firstpurchaseinfo.date','timestamp without time zone'),
	 ('storehub_mongo','customers','firstpurchaseinfo.employeeid','character varying'),
	 ('storehub_mongo','customers','firstpurchaseinfo.flag','boolean'),
	 ('storehub_mongo','customers','firstpurchaseinfo.registerid','character varying'),
	 ('storehub_mongo','customers','firstpurchaseinfo.storeid','character varying'),
	 ('storehub_mongo','customers','firstpurchaseinfo.transactionid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','customers','isdeleted','boolean'),
	 ('storehub_mongo','customers','lastcashbackclaimdate','timestamp without time zone'),
	 ('storehub_mongo','customers','lastname','character varying'),
	 ('storehub_mongo','customers','lastpurchasedate','timestamp without time zone'),
	 ('storehub_mongo','customers','memberid','character varying'),
	 ('storehub_mongo','customers','membershipcreatedatstoreid','character varying'),
	 ('storehub_mongo','customers','membershipjointime','timestamp without time zone'),
	 ('storehub_mongo','customers','membershipsource','character varying'),
	 ('storehub_mongo','customers','membershiptierid','character varying'),
	 ('storehub_mongo','customers','membershiptierlastchangetime','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','customers','membershiptiernextreviewtime','timestamp without time zone'),
	 ('storehub_mongo','customers','membershiptierstarttime','timestamp without time zone'),
	 ('storehub_mongo','customers','membershiptiertotalspent','double precision'),
	 ('storehub_mongo','customers','membershiptiertotalspentupdatedtime','timestamp without time zone'),
	 ('storehub_mongo','customers','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','customers','originalconsumerid','character varying'),
	 ('storehub_mongo','customers','phone','character varying'),
	 ('storehub_mongo','customers','postalcode','character varying'),
	 ('storehub_mongo','customers','purchasedinstores','character varying'),
	 ('storehub_mongo','customers','signupbyemployee','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','customers','signupfromstore','character varying'),
	 ('storehub_mongo','customers','source','character varying'),
	 ('storehub_mongo','customers','sourcerefid','character varying'),
	 ('storehub_mongo','customers','state','character varying'),
	 ('storehub_mongo','customers','storecreditsbalance','double precision'),
	 ('storehub_mongo','customers','storecreditsspent','double precision'),
	 ('storehub_mongo','customers','street1','character varying'),
	 ('storehub_mongo','customers','street2','character varying'),
	 ('storehub_mongo','customers','tags','character varying'),
	 ('storehub_mongo','customers','taxidno','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','customers','tmpcashbackexpirationdate','timestamp without time zone'),
	 ('storehub_mongo','customers','totalspent','double precision'),
	 ('storehub_mongo','customers','totaltransactions','double precision');

-- Table: consumers (5,735,184 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','consumers','_id','character varying'),
	 ('storehub_mongo','consumers','alcoholconsenttime','timestamp without time zone'),
	 ('storehub_mongo','consumers','birthday','timestamp without time zone'),
	 ('storehub_mongo','consumers','birthdaymodifiedtime','timestamp without time zone'),
	 ('storehub_mongo','consumers','createdtime','timestamp without time zone'),
	 ('storehub_mongo','consumers','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','consumers','defaultshippingaddressid','character varying'),
	 ('storehub_mongo','consumers','email','character varying'),
	 ('storehub_mongo','consumers','firstname','character varying'),
	 ('storehub_mongo','consumers','gender','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','consumers','hasusedclevertapversion','boolean'),
	 ('storehub_mongo','consumers','isdeleted','boolean'),
	 ('storehub_mongo','consumers','lastname','character varying'),
	 ('storehub_mongo','consumers','latestappversion','character varying'),
	 ('storehub_mongo','consumers','membership','character varying'),
	 ('storehub_mongo','consumers','mergedto','character varying'),
	 ('storehub_mongo','consumers','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','consumers','password','character varying'),
	 ('storehub_mongo','consumers','phone','character varying'),
	 ('storehub_mongo','consumers','registrationsource','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','consumers','registrationtouchpoint','character varying'),
	 ('storehub_mongo','consumers','unverifiedphone','character varying');

-- =====================================================
-- Category: Digital Ordering
-- =====================================================

-- Table: fooddeliveryplatformsettings__outlets__grabitemmappings (20,492 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets__grabitemmappings','_id','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets__grabitemmappings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets__grabitemmappings','fooddeliveryplatformsettings__outlets_foreignkey','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets__grabitemmappings','fooddeliveryplatformsettings_foreignkey','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets__grabitemmappings','grabitemid','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets__grabitemmappings','sectionid','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets__grabitemmappings','storehubitemid','character varying');

-- Table: fooddeliveryplatformsettings (2,514 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','fooddeliveryplatformsettings','_id','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings','addonversion','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings','business','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','fooddeliveryplatformsettings','hadenabled','boolean'),
	 ('storehub_mongo','fooddeliveryplatformsettings','isenabled','boolean'),
	 ('storehub_mongo','fooddeliveryplatformsettings','platform','double precision');

-- Table: fooddeliveryplatformsettings__outlets (1,717 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','_id','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','addonaccount','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','addonpwd','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','fooddeliveryplatformsettings_foreignkey','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','grabportalorderpollendat','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','grabportalorderpollstartat','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','hadenabled','boolean'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','isenabled','boolean'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','islived','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','isrequested','boolean'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','issynctaxexclusiveprice','boolean'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','outletid','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','sectionids','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','storeid','character varying'),
	 ('storehub_mongo','fooddeliveryplatformsettings__outlets','taxcode','character varying');

-- =====================================================
-- Category: Employees
-- =====================================================

-- Table: employees (546,726 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','employees','_id','character varying'),
	 ('storehub_mongo','employees','accessallstores','boolean'),
	 ('storehub_mongo','employees','assignedstores','character varying'),
	 ('storehub_mongo','employees','backofficeaccess','boolean'),
	 ('storehub_mongo','employees','backofficedetailaccesses','character varying'),
	 ('storehub_mongo','employees','cashieraccess','boolean'),
	 ('storehub_mongo','employees','createdtime','timestamp without time zone'),
	 ('storehub_mongo','employees','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','employees','email','character varying'),
	 ('storehub_mongo','employees','emailnotifications','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','employees','employeenumber','double precision'),
	 ('storehub_mongo','employees','employername','character varying'),
	 ('storehub_mongo','employees','firstname','character varying'),
	 ('storehub_mongo','employees','isdeleted','boolean'),
	 ('storehub_mongo','employees','istutorialdone','boolean'),
	 ('storehub_mongo','employees','languagepreference','character varying'),
	 ('storehub_mongo','employees','lastcheckalerts','timestamp without time zone'),
	 ('storehub_mongo','employees','lastname','character varying'),
	 ('storehub_mongo','employees','limitbackofficeaccess','boolean'),
	 ('storehub_mongo','employees','manageraccess','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','employees','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','employees','passwordhash','character varying'),
	 ('storehub_mongo','employees','phone','character varying');

-- Table: employees__passwordsettingtokens (228,732 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','employees__passwordsettingtokens','_id','character varying'),
	 ('storehub_mongo','employees__passwordsettingtokens','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','employees__passwordsettingtokens','employees_foreignkey','character varying'),
	 ('storehub_mongo','employees__passwordsettingtokens','expirydate','timestamp without time zone'),
	 ('storehub_mongo','employees__passwordsettingtokens','isredeemed','boolean'),
	 ('storehub_mongo','employees__passwordsettingtokens','token','character varying');

-- =====================================================
-- Category: Inventory
-- =====================================================

-- Table: stocktransfers__ordereditems (18,498,656 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','stocktransfers__ordereditems','_id','character varying'),
	 ('storehub_mongo','stocktransfers__ordereditems','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','stocktransfers__ordereditems','isserialized','boolean'),
	 ('storehub_mongo','stocktransfers__ordereditems','productid','character varying'),
	 ('storehub_mongo','stocktransfers__ordereditems','quantity','double precision'),
	 ('storehub_mongo','stocktransfers__ordereditems','serialnumbers','character varying'),
	 ('storehub_mongo','stocktransfers__ordereditems','stocktransfers_foreignkey','character varying');

-- Table: stocktakeitems (13,273,473 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','stocktakeitems','_id','character varying'),
	 ('storehub_mongo','stocktakeitems','countedqty','double precision'),
	 ('storehub_mongo','stocktakeitems','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','stocktakeitems','productid','character varying'),
	 ('storehub_mongo','stocktakeitems','quantity','double precision'),
	 ('storehub_mongo','stocktakeitems','stocktakeid','character varying');

-- Table: stockreturns__returneditems (3,503,163 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','stockreturns__returneditems','_id','character varying'),
	 ('storehub_mongo','stockreturns__returneditems','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','stockreturns__returneditems','isserialized','boolean'),
	 ('storehub_mongo','stockreturns__returneditems','productid','character varying'),
	 ('storehub_mongo','stockreturns__returneditems','returnedquantity','double precision'),
	 ('storehub_mongo','stockreturns__returneditems','serialnumbers','character varying'),
	 ('storehub_mongo','stockreturns__returneditems','stockreturns_foreignkey','character varying'),
	 ('storehub_mongo','stockreturns__returneditems','subtotal','numeric'),
	 ('storehub_mongo','stockreturns__returneditems','supplierprice','double precision');

-- Table: stocktransfers (1,220,788 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','stocktransfers','_id','character varying'),
	 ('storehub_mongo','stocktransfers','business','character varying'),
	 ('storehub_mongo','stocktransfers','completedat','timestamp without time zone'),
	 ('storehub_mongo','stocktransfers','createdtime','timestamp without time zone'),
	 ('storehub_mongo','stocktransfers','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','stocktransfers','failedtoupdateinventory','boolean'),
	 ('storehub_mongo','stocktransfers','inventorychangemsgtrackinfo.eventid','character varying'),
	 ('storehub_mongo','stocktransfers','inventorychangemsgtrackinfo.issendmsg','boolean'),
	 ('storehub_mongo','stocktransfers','inventorychangemsgtrackinfo.sendmsgstartat','timestamp without time zone'),
	 ('storehub_mongo','stocktransfers','markshippedat','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','stocktransfers','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','stocktransfers','notes','character varying'),
	 ('storehub_mongo','stocktransfers','receivedby','character varying'),
	 ('storehub_mongo','stocktransfers','shippedby','character varying'),
	 ('storehub_mongo','stocktransfers','shippeddate','timestamp without time zone'),
	 ('storehub_mongo','stocktransfers','sourcestoreid','character varying'),
	 ('storehub_mongo','stocktransfers','status','character varying'),
	 ('storehub_mongo','stocktransfers','stocktransferid','double precision'),
	 ('storehub_mongo','stocktransfers','targetstoreid','character varying');

-- Table: stocktakes (1,106,489 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','stocktakes','_id','character varying'),
	 ('storehub_mongo','stocktakes','business','character varying'),
	 ('storehub_mongo','stocktakes','completedby','character varying'),
	 ('storehub_mongo','stocktakes','completetime','timestamp without time zone'),
	 ('storehub_mongo','stocktakes','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','stocktakes','description','character varying'),
	 ('storehub_mongo','stocktakes','inventorychangemsgtrackinfo.eventid','character varying'),
	 ('storehub_mongo','stocktakes','inventorychangemsgtrackinfo.issendmsg','boolean'),
	 ('storehub_mongo','stocktakes','inventorychangemsgtrackinfo.sendmsgstartat','timestamp without time zone'),
	 ('storehub_mongo','stocktakes','iscountedonshmanager','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','stocktakes','ismovedtostocktakeitems','boolean'),
	 ('storehub_mongo','stocktakes','source','character varying'),
	 ('storehub_mongo','stocktakes','startedby','character varying'),
	 ('storehub_mongo','stocktakes','starttime','timestamp without time zone'),
	 ('storehub_mongo','stocktakes','status','character varying'),
	 ('storehub_mongo','stocktakes','storeid','character varying'),
	 ('storehub_mongo','stocktakes','supplierid','character varying'),
	 ('storehub_mongo','stocktakes','totalcostdiff','double precision'),
	 ('storehub_mongo','stocktakes','totalqtydiff','double precision');

-- Table: stockreturns (444,590 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','stockreturns','_id','character varying'),
	 ('storehub_mongo','stockreturns','business','character varying'),
	 ('storehub_mongo','stockreturns','completedby','character varying'),
	 ('storehub_mongo','stockreturns','createdtime','timestamp without time zone'),
	 ('storehub_mongo','stockreturns','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','stockreturns','discount','numeric'),
	 ('storehub_mongo','stockreturns','failedtoupdateinventory','boolean'),
	 ('storehub_mongo','stockreturns','inventorychangemsgtrackinfo.eventid','character varying'),
	 ('storehub_mongo','stockreturns','inventorychangemsgtrackinfo.issendmsg','boolean'),
	 ('storehub_mongo','stockreturns','inventorychangemsgtrackinfo.sendmsgstartat','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','stockreturns','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','stockreturns','name','character varying'),
	 ('storehub_mongo','stockreturns','notes','character varying'),
	 ('storehub_mongo','stockreturns','sourcestoreid','character varying'),
	 ('storehub_mongo','stockreturns','status','character varying'),
	 ('storehub_mongo','stockreturns','stockreturnid','double precision'),
	 ('storehub_mongo','stockreturns','subtotal','numeric'),
	 ('storehub_mongo','stockreturns','supplierid','character varying'),
	 ('storehub_mongo','stockreturns','tax','numeric'),
	 ('storehub_mongo','stockreturns','total','numeric');

-- Table: stocktransfers__ordereditems__componentsusages (139,083 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','stocktransfers__ordereditems__componentsusages','_id','character varying'),
	 ('storehub_mongo','stocktransfers__ordereditems__componentsusages','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','stocktransfers__ordereditems__componentsusages','lockeddate','timestamp without time zone'),
	 ('storehub_mongo','stocktransfers__ordereditems__componentsusages','lockedquantity','double precision'),
	 ('storehub_mongo','stocktransfers__ordereditems__componentsusages','productid','character varying'),
	 ('storehub_mongo','stocktransfers__ordereditems__componentsusages','quantity','double precision'),
	 ('storehub_mongo','stocktransfers__ordereditems__componentsusages','stocktransfers__ordereditems_foreignkey','character varying'),
	 ('storehub_mongo','stocktransfers__ordereditems__componentsusages','stocktransfers_foreignkey','character varying');

-- Table: inventorychangeevents (45,800 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','inventorychangeevents','_id','character varying'),
	 ('storehub_mongo','inventorychangeevents','business','character varying'),
	 ('storehub_mongo','inventorychangeevents','createdat','timestamp without time zone'),
	 ('storehub_mongo','inventorychangeevents','createinvifnotexist','boolean'),
	 ('storehub_mongo','inventorychangeevents','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','inventorychangeevents','eventid','character varying'),
	 ('storehub_mongo','inventorychangeevents','eventstartat','timestamp without time zone'),
	 ('storehub_mongo','inventorychangeevents','eventtype','character varying'),
	 ('storehub_mongo','inventorychangeevents','failedat','timestamp without time zone'),
	 ('storehub_mongo','inventorychangeevents','failreason','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','inventorychangeevents','iseventidscleared','boolean'),
	 ('storehub_mongo','inventorychangeevents','isneedmanualcheck','boolean'),
	 ('storehub_mongo','inventorychangeevents','needdedupmsg','boolean'),
	 ('storehub_mongo','inventorychangeevents','retrycount','double precision'),
	 ('storehub_mongo','inventorychangeevents','rollbackedat','timestamp without time zone'),
	 ('storehub_mongo','inventorychangeevents','rollbackfailedat','timestamp without time zone'),
	 ('storehub_mongo','inventorychangeevents','rules','character varying'),
	 ('storehub_mongo','inventorychangeevents','sourceinfo.customfields','character varying'),
	 ('storehub_mongo','inventorychangeevents','sourceinfo.refid','character varying'),
	 ('storehub_mongo','inventorychangeevents','status','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','inventorychangeevents','storeid','character varying'),
	 ('storehub_mongo','inventorychangeevents','succeededat','timestamp without time zone'),
	 ('storehub_mongo','inventorychangeevents','updatedat','timestamp without time zone'),
	 ('storehub_mongo','inventorychangeevents','updaterule','character varying');

-- Table: stockreturns__returneditems__componentsusages (3,370 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','stockreturns__returneditems__componentsusages','_id','character varying'),
	 ('storehub_mongo','stockreturns__returneditems__componentsusages','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','stockreturns__returneditems__componentsusages','lockeddate','timestamp without time zone'),
	 ('storehub_mongo','stockreturns__returneditems__componentsusages','lockedquantity','double precision'),
	 ('storehub_mongo','stockreturns__returneditems__componentsusages','productid','character varying'),
	 ('storehub_mongo','stockreturns__returneditems__componentsusages','quantity','double precision'),
	 ('storehub_mongo','stockreturns__returneditems__componentsusages','stockreturns__returneditems_foreignkey','character varying'),
	 ('storehub_mongo','stockreturns__returneditems__componentsusages','stockreturns_foreignkey','character varying');

-- =====================================================
-- Category: Logistics
-- =====================================================

-- Table: logistics (5,299,975 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','logistics','_id','character varying'),
	 ('storehub_mongo','logistics','bestlastmileeta','timestamp without time zone'),
	 ('storehub_mongo','logistics','business','character varying'),
	 ('storehub_mongo','logistics','claimcheckpasscounts','double precision'),
	 ('storehub_mongo','logistics','claimedbefore','boolean'),
	 ('storehub_mongo','logistics','country','character varying'),
	 ('storehub_mongo','logistics','createdtime','timestamp without time zone'),
	 ('storehub_mongo','logistics','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','logistics','deliverydistance','double precision'),
	 ('storehub_mongo','logistics','deliveryfee','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','logistics','dependentid','character varying'),
	 ('storehub_mongo','logistics','driverid','character varying'),
	 ('storehub_mongo','logistics','dropofflocation.coordinates','character varying'),
	 ('storehub_mongo','logistics','dropofflocation.type','character varying'),
	 ('storehub_mongo','logistics','expireat','timestamp without time zone'),
	 ('storehub_mongo','logistics','id','character varying'),
	 ('storehub_mongo','logistics','isexpress','boolean'),
	 ('storehub_mongo','logistics','ismanual','boolean'),
	 ('storehub_mongo','logistics','isoffstorebefore','boolean'),
	 ('storehub_mongo','logistics','ispickedupbefore','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','logistics','ispreorder','boolean'),
	 ('storehub_mongo','logistics','ispreorderconverted','boolean'),
	 ('storehub_mongo','logistics','issendpreordernotifications','boolean'),
	 ('storehub_mongo','logistics','istest','boolean'),
	 ('storehub_mongo','logistics','istimeoutsent','boolean'),
	 ('storehub_mongo','logistics','joburl','character varying'),
	 ('storehub_mongo','logistics','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','logistics','name','character varying'),
	 ('storehub_mongo','logistics','onfleetlastcheckcompletiontime','timestamp without time zone'),
	 ('storehub_mongo','logistics','onfleetunassignedcounts','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','logistics','originalfee','double precision'),
	 ('storehub_mongo','logistics','pickuplocation.coordinates','character varying'),
	 ('storehub_mongo','logistics','pickuplocation.type','character varying'),
	 ('storehub_mongo','logistics','preorderstartat','timestamp without time zone'),
	 ('storehub_mongo','logistics','receiptnumber','character varying'),
	 ('storehub_mongo','logistics','riderclaimdistance','double precision'),
	 ('storehub_mongo','logistics','riderclaimlocation.coordinates','character varying'),
	 ('storehub_mongo','logistics','riderclaimlocation.type','character varying'),
	 ('storehub_mongo','logistics','ridercompletelocation.coordinates','character varying'),
	 ('storehub_mongo','logistics','ridercompletelocation.type','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','logistics','riderid','character varying'),
	 ('storehub_mongo','logistics','ridername','character varying'),
	 ('storehub_mongo','logistics','riderphone','character varying'),
	 ('storehub_mongo','logistics','riderpickeduplocation.coordinates','character varying'),
	 ('storehub_mongo','logistics','riderpickeduplocation.type','character varying'),
	 ('storehub_mongo','logistics','riderstraightdistancetodropoff','double precision'),
	 ('storehub_mongo','logistics','ridetype','character varying'),
	 ('storehub_mongo','logistics','ridetypemerchantsetup','character varying'),
	 ('storehub_mongo','logistics','startat','timestamp without time zone'),
	 ('storehub_mongo','logistics','state','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','logistics','status','character varying'),
	 ('storehub_mongo','logistics','teamid','character varying'),
	 ('storehub_mongo','logistics','trackingid','character varying'),
	 ('storehub_mongo','logistics','trackingurl','character varying'),
	 ('storehub_mongo','logistics','upbidtype','character varying'),
	 ('storehub_mongo','logistics','worstlastmileeta','timestamp without time zone');

-- Table: logisticsjoblogs (1,054,762 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','logisticsjoblogs','_id','character varying'),
	 ('storehub_mongo','logisticsjoblogs','createdtime','timestamp without time zone'),
	 ('storehub_mongo','logisticsjoblogs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','logisticsjoblogs','deliverydistance','double precision'),
	 ('storehub_mongo','logisticsjoblogs','deliveryfee','double precision'),
	 ('storehub_mongo','logisticsjoblogs','jobid','character varying'),
	 ('storehub_mongo','logisticsjoblogs','operation','character varying'),
	 ('storehub_mongo','logisticsjoblogs','operator','character varying'),
	 ('storehub_mongo','logisticsjoblogs','operatorname','character varying'),
	 ('storehub_mongo','logisticsjoblogs','providername','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','logisticsjoblogs','receiptnumber','character varying'),
	 ('storehub_mongo','logisticsjoblogs','ridetype','character varying'),
	 ('storehub_mongo','logisticsjoblogs','status','character varying');

-- Table: shippingzones (31,338 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shippingzones','_id','character varying'),
	 ('storehub_mongo','shippingzones','business','character varying'),
	 ('storehub_mongo','shippingzones','country','character varying'),
	 ('storehub_mongo','shippingzones','coveredcountries','character varying'),
	 ('storehub_mongo','shippingzones','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shippingzones','distance','double precision'),
	 ('storehub_mongo','shippingzones','logisticsridetype','character varying'),
	 ('storehub_mongo','shippingzones','name','character varying'),
	 ('storehub_mongo','shippingzones','postcodes','character varying'),
	 ('storehub_mongo','shippingzones','shippingtype','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shippingzones','states','character varying');

-- Table: shippingzones__deliverymethods (31,338 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shippingzones__deliverymethods','_id','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shippingzones__deliverymethods','enableconditionalfreeshipping','boolean'),
	 ('storehub_mongo','shippingzones__deliverymethods','maxshippingtime','double precision'),
	 ('storehub_mongo','shippingzones__deliverymethods','minshippingtime','double precision'),
	 ('storehub_mongo','shippingzones__deliverymethods','name','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods','rate','double precision'),
	 ('storehub_mongo','shippingzones__deliverymethods','shippingtimeunit','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods','shippingzones_foreignkey','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods','type','character varying');

-- Table: logisticslogs (27,258 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','logisticslogs','_id','character varying'),
	 ('storehub_mongo','logisticslogs','body','character varying'),
	 ('storehub_mongo','logisticslogs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','logisticslogs','deliverydistance','double precision'),
	 ('storehub_mongo','logisticslogs','deliveryfee','double precision'),
	 ('storehub_mongo','logisticslogs','id','character varying'),
	 ('storehub_mongo','logisticslogs','name','character varying'),
	 ('storehub_mongo','logisticslogs','operationtype','character varying'),
	 ('storehub_mongo','logisticslogs','operatorname','character varying'),
	 ('storehub_mongo','logisticslogs','receiptnumber','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','logisticslogs','ridetype','character varying'),
	 ('storehub_mongo','logisticslogs','status','character varying'),
	 ('storehub_mongo','logisticslogs','time','timestamp without time zone'),
	 ('storehub_mongo','logisticslogs','type','character varying');

-- Table: shippingzones__deliverymethods__ratecalculation (22,638 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation','_id','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation','shippingzones__deliverymethods_foreignkey','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation','shippingzones_foreignkey','character varying');

-- Table: shippingzones__deliverymethods__ratecalculation__additions (22,638 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions','_id','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions','additionalmeasurevalue','double precision'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions','additionalrate','double precision'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions','shippingzones__deliverymethods__ratecalculation_foreignkey','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions','shippingzones_foreignkey','character varying');

-- Table: shippingzones__deliverymethods__ratecalculation__additions__measure (22,638 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions__measure','_id','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions__measure','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions__measure','maxvalue','double precision'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions__measure','minvalue','double precision'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions__measure','shippingzones__deliverymethods__ratecalculation__additions_foreignkey','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions__measure','shippingzones_foreignkey','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions__measure','type','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__additions__measure','unit','character varying');

-- Table: shippingzones__deliverymethods__ratecalculation__firstbase (22,638 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase','_id','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase','originalrate','double precision'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase','rate','double precision'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase','shippingzones__deliverymethods__ratecalculation_foreignkey','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase','shippingzones_foreignkey','character varying');

-- Table: shippingzones__deliverymethods__ratecalculation__firstbase__measure (22,638 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase__measure','_id','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase__measure','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase__measure','maxvalue','double precision'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase__measure','minvalue','double precision'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase__measure','shippingzones__deliverymethods__ratecalculation__firstbase_foreignkey','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase__measure','shippingzones_foreignkey','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase__measure','type','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__ratecalculation__firstbase__measure','unit','character varying');

-- Table: shippingzones__deliverymethods__freeconditions (15,261 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shippingzones__deliverymethods__freeconditions','_id','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__freeconditions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shippingzones__deliverymethods__freeconditions','entity','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__freeconditions','operand','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__freeconditions','operator','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__freeconditions','propertyname','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__freeconditions','shippingzones__deliverymethods_foreignkey','character varying'),
	 ('storehub_mongo','shippingzones__deliverymethods__freeconditions','shippingzones_foreignkey','character varying');

-- =====================================================
-- Category: Loyalty
-- =====================================================

-- Table: loyaltychangelogs (54,576,038 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','loyaltychangelogs','_id','character varying'),
	 ('storehub_mongo','loyaltychangelogs','amount','numeric'),
	 ('storehub_mongo','loyaltychangelogs','business','character varying'),
	 ('storehub_mongo','loyaltychangelogs','customerid','character varying'),
	 ('storehub_mongo','loyaltychangelogs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','loyaltychangelogs','dataversion','double precision'),
	 ('storehub_mongo','loyaltychangelogs','defaultloyaltyratio','double precision'),
	 ('storehub_mongo','loyaltychangelogs','eventtime','timestamp without time zone'),
	 ('storehub_mongo','loyaltychangelogs','eventtype','character varying'),
	 ('storehub_mongo','loyaltychangelogs','loyaltyperproduct','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','loyaltychangelogs','receiptnumber','character varying'),
	 ('storehub_mongo','loyaltychangelogs','rewardtype','character varying'),
	 ('storehub_mongo','loyaltychangelogs','source','character varying'),
	 ('storehub_mongo','loyaltychangelogs','transactionid','character varying');

-- Table: pointchangelogs__points (366,525 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','pointchangelogs__points','_id','character varying'),
	 ('storehub_mongo','pointchangelogs__points','changeamount','double precision'),
	 ('storehub_mongo','pointchangelogs__points','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','pointchangelogs__points','pointchangelogs_foreignkey','character varying'),
	 ('storehub_mongo','pointchangelogs__points','pointid','character varying');

-- Table: customerpoints (291,139 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','customerpoints','_id','character varying'),
	 ('storehub_mongo','customerpoints','balance','double precision'),
	 ('storehub_mongo','customerpoints','createdtime','timestamp without time zone'),
	 ('storehub_mongo','customerpoints','customerid','character varying'),
	 ('storehub_mongo','customerpoints','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','customerpoints','earnpointsunit','double precision'),
	 ('storehub_mongo','customerpoints','expirydate','timestamp without time zone'),
	 ('storehub_mongo','customerpoints','merchantname','character varying'),
	 ('storehub_mongo','customerpoints','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','customerpoints','pointrate','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','customerpoints','source','character varying'),
	 ('storehub_mongo','customerpoints','sourcerefid','character varying'),
	 ('storehub_mongo','customerpoints','total','numeric');

-- Table: rewardsettings (4,620 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','rewardsettings','_id','character varying'),
	 ('storehub_mongo','rewardsettings','aheadofdays','double precision'),
	 ('storehub_mongo','rewardsettings','costofpoints','double precision'),
	 ('storehub_mongo','rewardsettings','createdtime','timestamp without time zone'),
	 ('storehub_mongo','rewardsettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','rewardsettings','isdeleted','boolean'),
	 ('storehub_mongo','rewardsettings','isenabled','boolean'),
	 ('storehub_mongo','rewardsettings','isstackable','boolean'),
	 ('storehub_mongo','rewardsettings','merchantname','character varying'),
	 ('storehub_mongo','rewardsettings','modifiedtime','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','rewardsettings','rewardgroupid','character varying'),
	 ('storehub_mongo','rewardsettings','rewardrefid','character varying'),
	 ('storehub_mongo','rewardsettings','rewardsource','character varying'),
	 ('storehub_mongo','rewardsettings','rewardtype','character varying'),
	 ('storehub_mongo','rewardsettings','tierlevel','double precision'),
	 ('storehub_mongo','rewardsettings','validperiod','double precision'),
	 ('storehub_mongo','rewardsettings','validperiodunit','character varying');

-- Table: rewardssets (26 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','rewardssets','_id','character varying'),
	 ('storehub_mongo','rewardssets','business','character varying'),
	 ('storehub_mongo','rewardssets','createdtime','timestamp without time zone'),
	 ('storehub_mongo','rewardssets','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','rewardssets','isenabled','boolean'),
	 ('storehub_mongo','rewardssets','type','character varying'),
	 ('storehub_mongo','rewardssets','updatedtime','timestamp without time zone');

-- =====================================================
-- Category: Marketing
-- =====================================================

-- Table: campaignjobs (6,076,635 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaignjobs','_id','character varying'),
	 ('storehub_mongo','campaignjobs','attributes','character varying'),
	 ('storehub_mongo','campaignjobs','business','character varying'),
	 ('storehub_mongo','campaignjobs','campaignid','character varying'),
	 ('storehub_mongo','campaignjobs','channel','character varying'),
	 ('storehub_mongo','campaignjobs','consumerid','character varying'),
	 ('storehub_mongo','campaignjobs','content','character varying'),
	 ('storehub_mongo','campaignjobs','createdtime','timestamp without time zone'),
	 ('storehub_mongo','campaignjobs','customeremail','character varying'),
	 ('storehub_mongo','campaignjobs','customerid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaignjobs','customerphone','character varying'),
	 ('storehub_mongo','campaignjobs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','campaignjobs','delay','double precision'),
	 ('storehub_mongo','campaignjobs','failedreason','character varying'),
	 ('storehub_mongo','campaignjobs','freemessageamount','double precision'),
	 ('storehub_mongo','campaignjobs','globalcampaigninformationid','character varying'),
	 ('storehub_mongo','campaignjobs','launchid','character varying'),
	 ('storehub_mongo','campaignjobs','lockfreesmscreditlogid','character varying'),
	 ('storehub_mongo','campaignjobs','lockpaidsmscreditlogid','character varying'),
	 ('storehub_mongo','campaignjobs','messageamount','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaignjobs','messageid','character varying'),
	 ('storehub_mongo','campaignjobs','messageprovider','character varying'),
	 ('storehub_mongo','campaignjobs','messagestatus','character varying'),
	 ('storehub_mongo','campaignjobs','messageunits','double precision'),
	 ('storehub_mongo','campaignjobs','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','campaignjobs','promotioncustomerid','character varying'),
	 ('storehub_mongo','campaignjobs','pushstatus','character varying'),
	 ('storehub_mongo','campaignjobs','sendtime','timestamp without time zone'),
	 ('storehub_mongo','campaignjobs','smsunitcredits','double precision'),
	 ('storehub_mongo','campaignjobs','validations','character varying');

-- Table: campaignjobs__additionalattributes (5,529,934 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaignjobs__additionalattributes','_id','character varying'),
	 ('storehub_mongo','campaignjobs__additionalattributes','campaignjobs_foreignkey','character varying'),
	 ('storehub_mongo','campaignjobs__additionalattributes','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','campaignjobs__additionalattributes','receiptnumber','character varying');

-- Table: campaignlogs (969,614 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaignlogs','_id','character varying'),
	 ('storehub_mongo','campaignlogs','additionallogdata.creditsactualdeducted','double precision'),
	 ('storehub_mongo','campaignlogs','additionallogdata.creditsduefordeduction','double precision'),
	 ('storehub_mongo','campaignlogs','additionallogdata.customercount','double precision'),
	 ('storehub_mongo','campaignlogs','business','character varying'),
	 ('storehub_mongo','campaignlogs','campaignid','character varying'),
	 ('storehub_mongo','campaignlogs','createdtime','timestamp without time zone'),
	 ('storehub_mongo','campaignlogs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','campaignlogs','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','campaignlogs','operation','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaignlogs','reason','character varying'),
	 ('storehub_mongo','campaignlogs','status','character varying');

-- Table: promotionclaimcounts (390,641 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','promotionclaimcounts','_id','character varying'),
	 ('storehub_mongo','promotionclaimcounts','businessname','character varying'),
	 ('storehub_mongo','promotionclaimcounts','consumerid','character varying'),
	 ('storehub_mongo','promotionclaimcounts','count','double precision'),
	 ('storehub_mongo','promotionclaimcounts','createdtime','timestamp without time zone'),
	 ('storehub_mongo','promotionclaimcounts','customerid','character varying'),
	 ('storehub_mongo','promotionclaimcounts','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','promotionclaimcounts','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','promotionclaimcounts','promotioncode','character varying'),
	 ('storehub_mongo','promotionclaimcounts','promotionid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','promotionclaimcounts','receiptnumbers','character varying'),
	 ('storehub_mongo','promotionclaimcounts','uniquepromotioncodeid','character varying');

-- Table: promotioncustomers (274,759 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','promotioncustomers','_id','character varying'),
	 ('storehub_mongo','promotioncustomers','business','character varying'),
	 ('storehub_mongo','promotioncustomers','consumerid','character varying'),
	 ('storehub_mongo','promotioncustomers','createdtime','timestamp without time zone'),
	 ('storehub_mongo','promotioncustomers','customerid','character varying'),
	 ('storehub_mongo','promotioncustomers','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','promotioncustomers','isdeleted','boolean'),
	 ('storehub_mongo','promotioncustomers','lastredemptiontime','timestamp without time zone'),
	 ('storehub_mongo','promotioncustomers','promotioncode','character varying'),
	 ('storehub_mongo','promotioncustomers','promotionid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','promotioncustomers','restclaimcount','double precision'),
	 ('storehub_mongo','promotioncustomers','rewardbirthdayrewardsyear','double precision'),
	 ('storehub_mongo','promotioncustomers','rewardsettingid','character varying'),
	 ('storehub_mongo','promotioncustomers','rewardsource','character varying'),
	 ('storehub_mongo','promotioncustomers','rewardssetid','character varying'),
	 ('storehub_mongo','promotioncustomers','status','character varying'),
	 ('storehub_mongo','promotioncustomers','updatedat','timestamp without time zone'),
	 ('storehub_mongo','promotioncustomers','validfrom','timestamp without time zone'),
	 ('storehub_mongo','promotioncustomers','validto','timestamp without time zone');

-- Table: promotions (231,293 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','promotions','_id','character varying'),
	 ('storehub_mongo','promotions','appliedclienttypes','character varying'),
	 ('storehub_mongo','promotions','appliedsources','character varying'),
	 ('storehub_mongo','promotions','appliedstores','character varying'),
	 ('storehub_mongo','promotions','applytoonlinestore','boolean'),
	 ('storehub_mongo','promotions','business','character varying'),
	 ('storehub_mongo','promotions','claimedcount','double precision'),
	 ('storehub_mongo','promotions','costpersms','double precision'),
	 ('storehub_mongo','promotions','createdby','character varying'),
	 ('storehub_mongo','promotions','createdtime','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','promotions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','promotions','discounttype','character varying'),
	 ('storehub_mongo','promotions','discountvalue','double precision'),
	 ('storehub_mongo','promotions','enablebeeptagandbanner','boolean'),
	 ('storehub_mongo','promotions','enableclaimlimit','boolean'),
	 ('storehub_mongo','promotions','enableduniquepromotioncode','boolean'),
	 ('storehub_mongo','promotions','enableperbusinessclaimlimit','boolean'),
	 ('storehub_mongo','promotions','enablepercustomerclaimlimit','boolean'),
	 ('storehub_mongo','promotions','isbindcampaign','boolean'),
	 ('storehub_mongo','promotions','isdeleted','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','promotions','iseligibletoshowonbeep','boolean'),
	 ('storehub_mongo','promotions','isenabled','boolean'),
	 ('storehub_mongo','promotions','isrepeatable','boolean'),
	 ('storehub_mongo','promotions','maxclaimcount','double precision'),
	 ('storehub_mongo','promotions','maxdiscountamount','double precision'),
	 ('storehub_mongo','promotions','maxquantity','double precision'),
	 ('storehub_mongo','promotions','minquantity','double precision'),
	 ('storehub_mongo','promotions','modifiedby','character varying'),
	 ('storehub_mongo','promotions','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','promotions','name','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','promotions','ordering','double precision'),
	 ('storehub_mongo','promotions','perbusinessclaimlimit','double precision'),
	 ('storehub_mongo','promotions','percustomerclaimlimit','double precision'),
	 ('storehub_mongo','promotions','promotioncode','character varying'),
	 ('storehub_mongo','promotions','requirefirstpurchase','boolean'),
	 ('storehub_mongo','promotions','storehubpaidpercentage','double precision'),
	 ('storehub_mongo','promotions','taxcode','character varying'),
	 ('storehub_mongo','promotions','totalsmssent','double precision'),
	 ('storehub_mongo','promotions','type','character varying'),
	 ('storehub_mongo','promotions','validdays','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','promotions','validfrom','timestamp without time zone'),
	 ('storehub_mongo','promotions','validtimefrom','double precision'),
	 ('storehub_mongo','promotions','validtimeto','double precision'),
	 ('storehub_mongo','promotions','validto','timestamp without time zone');

-- Table: campaignsegments__nestedsource__filters (25,499 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaignsegments__nestedsource__filters','_id','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource__filters','campaignsegments__nestedsource_foreignkey','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource__filters','campaignsegments_foreignkey','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource__filters','condition','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource__filters','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','campaignsegments__nestedsource__filters','defaultcomparedvalue','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource__filters','funcname','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource__filters','key','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource__filters','segmentruletype','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource__filters','symbol','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaignsegments__nestedsource__filters','valuedate','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource__filters','valuenumber','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource__filters','valuestring','character varying');

-- Table: promotions__requiredproducts (19,765 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','promotions__requiredproducts','_id','character varying'),
	 ('storehub_mongo','promotions__requiredproducts','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','promotions__requiredproducts','entity','character varying'),
	 ('storehub_mongo','promotions__requiredproducts','maxquantity','double precision'),
	 ('storehub_mongo','promotions__requiredproducts','minquantity','double precision'),
	 ('storehub_mongo','promotions__requiredproducts','operand','character varying'),
	 ('storehub_mongo','promotions__requiredproducts','operator','character varying'),
	 ('storehub_mongo','promotions__requiredproducts','promotions_foreignkey','character varying'),
	 ('storehub_mongo','promotions__requiredproducts','propertyname','character varying');

-- Table: campaignsegments (19,346 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaignsegments','_id','character varying'),
	 ('storehub_mongo','campaignsegments','business','character varying'),
	 ('storehub_mongo','campaignsegments','createdtime','timestamp without time zone'),
	 ('storehub_mongo','campaignsegments','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','campaignsegments','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','campaignsegments','name','character varying');

-- Table: campaignsegments__nestedsource (19,346 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaignsegments__nestedsource','_id','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource','campaignsegments_foreignkey','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','campaignsegments__nestedsource','groupbys','character varying'),
	 ('storehub_mongo','campaignsegments__nestedsource','source','character varying');

-- Table: campaigns (17,481 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaigns','_id','character varying'),
	 ('storehub_mongo','campaigns','brandname','character varying'),
	 ('storehub_mongo','campaigns','business','character varying'),
	 ('storehub_mongo','campaigns','campaigntype','character varying'),
	 ('storehub_mongo','campaigns','channel','character varying'),
	 ('storehub_mongo','campaigns','conditiontype','character varying'),
	 ('storehub_mongo','campaigns','createdtime','timestamp without time zone'),
	 ('storehub_mongo','campaigns','cron','character varying'),
	 ('storehub_mongo','campaigns','cronjobkey','character varying'),
	 ('storehub_mongo','campaigns','data_modified_time','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaigns','delay','double precision'),
	 ('storehub_mongo','campaigns','endtime','timestamp without time zone'),
	 ('storehub_mongo','campaigns','globalcampaigninformationid','character varying'),
	 ('storehub_mongo','campaigns','initialsegmentid','character varying'),
	 ('storehub_mongo','campaigns','isactive','boolean'),
	 ('storehub_mongo','campaigns','isinitial','boolean'),
	 ('storehub_mongo','campaigns','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','campaigns','name','character varying'),
	 ('storehub_mongo','campaigns','segmentid','character varying'),
	 ('storehub_mongo','campaigns','selectedtemplatelanguage','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','campaigns','starttime','timestamp without time zone'),
	 ('storehub_mongo','campaigns','status','character varying'),
	 ('storehub_mongo','campaigns','template','character varying'),
	 ('storehub_mongo','campaigns','timezone','character varying'),
	 ('storehub_mongo','campaigns','version','character varying');

-- Table: promotions__rewardssettings (49 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','promotions__rewardssettings','_id','character varying'),
	 ('storehub_mongo','promotions__rewardssettings','costofpoints','double precision'),
	 ('storehub_mongo','promotions__rewardssettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','promotions__rewardssettings','promotions_foreignkey','character varying'),
	 ('storehub_mongo','promotions__rewardssettings','rewardstype','character varying'),
	 ('storehub_mongo','promotions__rewardssettings','validnumber','double precision'),
	 ('storehub_mongo','promotions__rewardssettings','validunit','character varying');

-- Table: rewardssets__promotionconfigs (43 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','rewardssets__promotionconfigs','_id','character varying'),
	 ('storehub_mongo','rewardssets__promotionconfigs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','rewardssets__promotionconfigs','promotionid','character varying'),
	 ('storehub_mongo','rewardssets__promotionconfigs','rewardssets_foreignkey','character varying'),
	 ('storehub_mongo','rewardssets__promotionconfigs','validnumber','double precision'),
	 ('storehub_mongo','rewardssets__promotionconfigs','validunit','character varying');

-- =====================================================
-- Category: Online Store
-- =====================================================

-- Table: onlinecategories__conditions (131,359 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinecategories__conditions','_id','character varying'),
	 ('storehub_mongo','onlinecategories__conditions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinecategories__conditions','onlinecategories_foreignkey','character varying'),
	 ('storehub_mongo','onlinecategories__conditions','operand','character varying'),
	 ('storehub_mongo','onlinecategories__conditions','operator','character varying'),
	 ('storehub_mongo','onlinecategories__conditions','type','character varying');

-- Table: onlinestoreinfos (37,258 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos','_id','character varying'),
	 ('storehub_mongo','onlinestoreinfos','aboutstore','character varying'),
	 ('storehub_mongo','onlinestoreinfos','alternatephone1','character varying'),
	 ('storehub_mongo','onlinestoreinfos','alternatephone2','character varying'),
	 ('storehub_mongo','onlinestoreinfos','beepbrandname','character varying'),
	 ('storehub_mongo','onlinestoreinfos','beepprofileimage','character varying'),
	 ('storehub_mongo','onlinestoreinfos','business','character varying'),
	 ('storehub_mongo','onlinestoreinfos','connectstatus','character varying'),
	 ('storehub_mongo','onlinestoreinfos','customdomain','character varying'),
	 ('storehub_mongo','onlinestoreinfos','data_modified_time','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos','email','character varying'),
	 ('storehub_mongo','onlinestoreinfos','enabledchattype','character varying'),
	 ('storehub_mongo','onlinestoreinfos','facebookdomainverification','character varying'),
	 ('storehub_mongo','onlinestoreinfos','favicon','character varying'),
	 ('storehub_mongo','onlinestoreinfos','featuredproducts','character varying'),
	 ('storehub_mongo','onlinestoreinfos','firstenabledate','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos','firstpublishdate','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos','haslogo','boolean'),
	 ('storehub_mongo','onlinestoreinfos','lastenabledate','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos','lastpublishdate','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos','logo','character varying'),
	 ('storehub_mongo','onlinestoreinfos','operationhours','character varying'),
	 ('storehub_mongo','onlinestoreinfos','phone','character varying'),
	 ('storehub_mongo','onlinestoreinfos','postcode','character varying'),
	 ('storehub_mongo','onlinestoreinfos','state','character varying'),
	 ('storehub_mongo','onlinestoreinfos','storename','character varying'),
	 ('storehub_mongo','onlinestoreinfos','street','character varying'),
	 ('storehub_mongo','onlinestoreinfos','themecolor','character varying');

-- Table: onlinestoreinfos__socialmediainfo (3,450 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo','_id','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo','instagram','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo','onlinestoreinfos_foreignkey','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo','twitter','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo','whatsapp','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo','youtube','character varying');

-- Table: onlinestoreinfos__socialmediainfo__facebook (3,450 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__facebook','_id','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__facebook','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__facebook','greetingmessage','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__facebook','language','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__facebook','onlinestoreinfos__socialmediainfo_foreignkey','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__facebook','onlinestoreinfos_foreignkey','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__facebook','pageid','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__facebook','themecolor','character varying');

-- Table: onlinestoreinfos__socialmediainfo__line (3,450 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__line','_id','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__line','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__line','officialline','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__line','onlinestoreinfos__socialmediainfo_foreignkey','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__line','onlinestoreinfos_foreignkey','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__line','personalline','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__line','usepersonalline','boolean');

-- Table: onlinestoreinfos__socialmediainfo__viber (3,450 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__viber','_id','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__viber','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__viber','officialviber','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__viber','onlinestoreinfos__socialmediainfo_foreignkey','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__viber','onlinestoreinfos_foreignkey','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__viber','personalviber','character varying'),
	 ('storehub_mongo','onlinestoreinfos__socialmediainfo__viber','usepersonalviber','boolean');

-- Table: onlinestoreinfos__customizecommissionrates (1,176 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos__customizecommissionrates','_id','character varying'),
	 ('storehub_mongo','onlinestoreinfos__customizecommissionrates','beepdelivery','double precision'),
	 ('storehub_mongo','onlinestoreinfos__customizecommissionrates','beepinstore','double precision'),
	 ('storehub_mongo','onlinestoreinfos__customizecommissionrates','beeppickup','double precision'),
	 ('storehub_mongo','onlinestoreinfos__customizecommissionrates','beeptakeaway','double precision'),
	 ('storehub_mongo','onlinestoreinfos__customizecommissionrates','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos__customizecommissionrates','ecommerce','double precision'),
	 ('storehub_mongo','onlinestoreinfos__customizecommissionrates','onlinestoreinfos_foreignkey','character varying');

-- Table: onlinestoreinfos__analytictools (972 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos__analytictools','_id','character varying'),
	 ('storehub_mongo','onlinestoreinfos__analytictools','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos__analytictools','name','character varying'),
	 ('storehub_mongo','onlinestoreinfos__analytictools','onlinestoreinfos_foreignkey','character varying'),
	 ('storehub_mongo','onlinestoreinfos__analytictools','trackingid','character varying');

-- Table: thirdpartyonlineorders (701 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','thirdpartyonlineorders','_id','character varying'),
	 ('storehub_mongo','thirdpartyonlineorders','channel','double precision'),
	 ('storehub_mongo','thirdpartyonlineorders','content','character varying'),
	 ('storehub_mongo','thirdpartyonlineorders','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','thirdpartyonlineorders','iscancellationnottakeeffect','boolean'),
	 ('storehub_mongo','thirdpartyonlineorders','orderid','character varying');

-- Table: onlinestoreinfos__bankingdetails (617 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos__bankingdetails','_id','character varying'),
	 ('storehub_mongo','onlinestoreinfos__bankingdetails','bankaccountnumber','character varying'),
	 ('storehub_mongo','onlinestoreinfos__bankingdetails','bankaddress','character varying'),
	 ('storehub_mongo','onlinestoreinfos__bankingdetails','bankcode','character varying'),
	 ('storehub_mongo','onlinestoreinfos__bankingdetails','bankname','character varying'),
	 ('storehub_mongo','onlinestoreinfos__bankingdetails','beneficiaryaccountname','character varying'),
	 ('storehub_mongo','onlinestoreinfos__bankingdetails','beneficiaryaddress','character varying'),
	 ('storehub_mongo','onlinestoreinfos__bankingdetails','beneficiaryphonenumber','character varying'),
	 ('storehub_mongo','onlinestoreinfos__bankingdetails','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos__bankingdetails','onlinestoreinfos_foreignkey','character varying');

-- Table: onlinecategories (39 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinecategories','_id','character varying'),
	 ('storehub_mongo','onlinecategories','appliedsources','character varying'),
	 ('storehub_mongo','onlinecategories','appliedstores','character varying'),
	 ('storehub_mongo','onlinecategories','business','character varying'),
	 ('storehub_mongo','onlinecategories','channels','character varying'),
	 ('storehub_mongo','onlinecategories','conditionsmatch','character varying'),
	 ('storehub_mongo','onlinecategories','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinecategories','iseditable','boolean'),
	 ('storehub_mongo','onlinecategories','isenabled','boolean'),
	 ('storehub_mongo','onlinecategories','name','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinecategories','ordering','double precision'),
	 ('storehub_mongo','onlinecategories','slug','character varying'),
	 ('storehub_mongo','onlinecategories','sortordering','character varying'),
	 ('storehub_mongo','onlinecategories','sorttype','character varying');

-- =====================================================
-- Category: Other
-- =====================================================

-- Table: useractionlogs (60,089,080 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','useractionlogs','_id','character varying'),
	 ('storehub_mongo','useractionlogs','action','character varying'),
	 ('storehub_mongo','useractionlogs','additionalinfo','character varying'),
	 ('storehub_mongo','useractionlogs','business','character varying'),
	 ('storehub_mongo','useractionlogs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','useractionlogs','ipaddress','character varying'),
	 ('storehub_mongo','useractionlogs','notes','character varying'),
	 ('storehub_mongo','useractionlogs','registerid','double precision'),
	 ('storehub_mongo','useractionlogs','source','character varying'),
	 ('storehub_mongo','useractionlogs','storeid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','useractionlogs','time','timestamp without time zone'),
	 ('storehub_mongo','useractionlogs','user','character varying');

-- Table: inventories (58,541,689 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','inventories','_id','character varying'),
	 ('storehub_mongo','inventories','appliedeventids','character varying'),
	 ('storehub_mongo','inventories','business','character varying'),
	 ('storehub_mongo','inventories','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','inventories','desiredstocklevel','double precision'),
	 ('storehub_mongo','inventories','isserialized','boolean'),
	 ('storehub_mongo','inventories','pendingcancelledstocktransfers','character varying'),
	 ('storehub_mongo','inventories','pendingmanualupdatelogs','character varying'),
	 ('storehub_mongo','inventories','pendingpurchaseorders','character varying'),
	 ('storehub_mongo','inventories','pendingreturnprocess','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','inventories','pendingstockreturns','character varying'),
	 ('storehub_mongo','inventories','pendingstocktakes','character varying'),
	 ('storehub_mongo','inventories','pendingstocktransfers','character varying'),
	 ('storehub_mongo','inventories','pendingtransactions','character varying'),
	 ('storehub_mongo','inventories','productid','character varying'),
	 ('storehub_mongo','inventories','quantityonhand','double precision'),
	 ('storehub_mongo','inventories','restocklevel','double precision'),
	 ('storehub_mongo','inventories','storeid','character varying'),
	 ('storehub_mongo','inventories','supplyneedsnotified','boolean');

-- Table: orderlogs (12,779,042 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','orderlogs','_id','character varying'),
	 ('storehub_mongo','orderlogs','createdtime','timestamp without time zone'),
	 ('storehub_mongo','orderlogs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','orderlogs','info','character varying'),
	 ('storehub_mongo','orderlogs','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','orderlogs','operatorid','character varying'),
	 ('storehub_mongo','orderlogs','operatorname','character varying'),
	 ('storehub_mongo','orderlogs','operatortype','character varying'),
	 ('storehub_mongo','orderlogs','receiptnumber','character varying'),
	 ('storehub_mongo','orderlogs','time','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','orderlogs','type','character varying');

-- Table: messages (7,906,573 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','messages','_id','character varying'),
	 ('storehub_mongo','messages','amount','numeric'),
	 ('storehub_mongo','messages','business','character varying'),
	 ('storehub_mongo','messages','createdtime','timestamp without time zone'),
	 ('storehub_mongo','messages','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','messages','message','character varying'),
	 ('storehub_mongo','messages','msgid','character varying'),
	 ('storehub_mongo','messages','msgids','character varying'),
	 ('storehub_mongo','messages','phone','character varying'),
	 ('storehub_mongo','messages','provider','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','messages','rate','double precision'),
	 ('storehub_mongo','messages','senttime','timestamp without time zone'),
	 ('storehub_mongo','messages','senttimes','double precision'),
	 ('storehub_mongo','messages','source','character varying'),
	 ('storehub_mongo','messages','status','character varying'),
	 ('storehub_mongo','messages','templateid','character varying'),
	 ('storehub_mongo','messages','type','character varying'),
	 ('storehub_mongo','messages','units','double precision'),
	 ('storehub_mongo','messages','updatedtime','timestamp without time zone');

-- Table: smscreditlogs (5,258,337 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','smscreditlogs','_id','character varying'),
	 ('storehub_mongo','smscreditlogs','business','character varying'),
	 ('storehub_mongo','smscreditlogs','country','character varying'),
	 ('storehub_mongo','smscreditlogs','createdtime','timestamp without time zone'),
	 ('storehub_mongo','smscreditlogs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','smscreditlogs','engagetrialsmscreditsbalance','double precision'),
	 ('storehub_mongo','smscreditlogs','engagetrialsmscreditschange','double precision'),
	 ('storehub_mongo','smscreditlogs','eventtime','timestamp without time zone'),
	 ('storehub_mongo','smscreditlogs','eventtype','character varying'),
	 ('storehub_mongo','smscreditlogs','extrainfo.campaignid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','smscreditlogs','extrainfo.campaignjobid','character varying'),
	 ('storehub_mongo','smscreditlogs','extrainfo.campaignjoblaunchid','character varying'),
	 ('storehub_mongo','smscreditlogs','extrainfo.campaignname','character varying'),
	 ('storehub_mongo','smscreditlogs','extrainfo.currency','character varying'),
	 ('storehub_mongo','smscreditlogs','extrainfo.lockfreesmscreditlogid','character varying'),
	 ('storehub_mongo','smscreditlogs','extrainfo.lockpaidsmscreditlogid','character varying'),
	 ('storehub_mongo','smscreditlogs','extrainfo.paidamount','double precision'),
	 ('storehub_mongo','smscreditlogs','extrainfo.purchasedid','character varying'),
	 ('storehub_mongo','smscreditlogs','extrainfo.smscount','double precision'),
	 ('storehub_mongo','smscreditlogs','extrainfo.ticketid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','smscreditlogs','lockedengagetrialsmscreditsavailable','double precision'),
	 ('storehub_mongo','smscreditlogs','lockedengagetrialsmscreditschange','double precision'),
	 ('storehub_mongo','smscreditlogs','lockedmonthlysmscreditsavailable','double precision'),
	 ('storehub_mongo','smscreditlogs','lockedmonthlysmscreditschange','double precision'),
	 ('storehub_mongo','smscreditlogs','lockedsmscreditsavailable','double precision'),
	 ('storehub_mongo','smscreditlogs','lockedsmscreditschange','double precision'),
	 ('storehub_mongo','smscreditlogs','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','smscreditlogs','monthlysmscreditsbalance','double precision'),
	 ('storehub_mongo','smscreditlogs','monthlysmscreditschange','double precision'),
	 ('storehub_mongo','smscreditlogs','smscreditchange','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','smscreditlogs','smscreditsavgcost','double precision'),
	 ('storehub_mongo','smscreditlogs','smscreditsbalance','double precision'),
	 ('storehub_mongo','smscreditlogs','source','character varying'),
	 ('storehub_mongo','smscreditlogs','title','character varying'),
	 ('storehub_mongo','smscreditlogs','type','character varying');

-- Table: purchaseorders__ordereditems (2,505,698 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','purchaseorders__ordereditems','_id','character varying'),
	 ('storehub_mongo','purchaseorders__ordereditems','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','purchaseorders__ordereditems','isserialized','boolean'),
	 ('storehub_mongo','purchaseorders__ordereditems','orderedquantity','double precision'),
	 ('storehub_mongo','purchaseorders__ordereditems','productid','character varying'),
	 ('storehub_mongo','purchaseorders__ordereditems','purchaseorders_foreignkey','character varying'),
	 ('storehub_mongo','purchaseorders__ordereditems','receivedquantity','double precision'),
	 ('storehub_mongo','purchaseorders__ordereditems','serialnumbers','character varying'),
	 ('storehub_mongo','purchaseorders__ordereditems','subtotal','numeric'),
	 ('storehub_mongo','purchaseorders__ordereditems','supplierprice','double precision');

-- Table: serialnumbers__logs (1,811,210 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','serialnumbers__logs','_id','character varying'),
	 ('storehub_mongo','serialnumbers__logs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','serialnumbers__logs','docrefid','character varying'),
	 ('storehub_mongo','serialnumbers__logs','employeeid','character varying'),
	 ('storehub_mongo','serialnumbers__logs','eventtype','character varying'),
	 ('storehub_mongo','serialnumbers__logs','serialnumbers_foreignkey','character varying'),
	 ('storehub_mongo','serialnumbers__logs','storeid','character varying'),
	 ('storehub_mongo','serialnumbers__logs','timestamp','timestamp without time zone');

-- Table: serialnumbers (1,085,984 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','serialnumbers','_id','character varying'),
	 ('storehub_mongo','serialnumbers','business','character varying'),
	 ('storehub_mongo','serialnumbers','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','serialnumbers','productid','character varying'),
	 ('storehub_mongo','serialnumbers','serialnum','character varying'),
	 ('storehub_mongo','serialnumbers','storeid','character varying');

-- Table: shifts__payins (879,020 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shifts__payins','_id','character varying'),
	 ('storehub_mongo','shifts__payins','actedby','character varying'),
	 ('storehub_mongo','shifts__payins','amount','numeric'),
	 ('storehub_mongo','shifts__payins','comment','character varying'),
	 ('storehub_mongo','shifts__payins','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shifts__payins','payouttime','timestamp without time zone'),
	 ('storehub_mongo','shifts__payins','paytype','double precision'),
	 ('storehub_mongo','shifts__payins','shifts_foreignkey','character varying'),
	 ('storehub_mongo','shifts__payins','type','character varying');

-- Table: pointchangelogs (362,593 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','pointchangelogs','_id','character varying'),
	 ('storehub_mongo','pointchangelogs','changeamount','double precision'),
	 ('storehub_mongo','pointchangelogs','createdtime','timestamp without time zone'),
	 ('storehub_mongo','pointchangelogs','customerid','character varying'),
	 ('storehub_mongo','pointchangelogs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','pointchangelogs','eventtime','timestamp without time zone'),
	 ('storehub_mongo','pointchangelogs','merchantname','character varying'),
	 ('storehub_mongo','pointchangelogs','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','pointchangelogs','type','character varying');

-- Table: zreadings (356,202 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','zreadings','_id','character varying'),
	 ('storehub_mongo','zreadings','amusementtax','double precision'),
	 ('storehub_mongo','zreadings','athleteandcoachdiscount','double precision'),
	 ('storehub_mongo','zreadings','business','character varying'),
	 ('storehub_mongo','zreadings','closetime','timestamp without time zone'),
	 ('storehub_mongo','zreadings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','zreadings','endornumber','character varying'),
	 ('storehub_mongo','zreadings','endtrxnumber','character varying'),
	 ('storehub_mongo','zreadings','extendedinfoformall.customercount','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.discountedtrxcount','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','zreadings','extendedinfoformall.newvoidamount','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.newvoidnumber','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.oldvoidamount','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.oldvoidnumber','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.vatablenewnet','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.vatableoldnet','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.vatablerefundamount','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.vatablevoidamount','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.vatexemptnewnet','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.vatexemptoldnet','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','zreadings','extendedinfoformall.vatexemptrefundamount','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.vatexemptvoidamount','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.voidamount','double precision'),
	 ('storehub_mongo','zreadings','extendedinfoformall.voidtrxcount','double precision'),
	 ('storehub_mongo','zreadings','grosssales','double precision'),
	 ('storehub_mongo','zreadings','headcount','double precision'),
	 ('storehub_mongo','zreadings','medalofvalordiscount','double precision'),
	 ('storehub_mongo','zreadings','minno','character varying'),
	 ('storehub_mongo','zreadings','netsales','double precision'),
	 ('storehub_mongo','zreadings','newgross','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','zreadings','newnet','double precision'),
	 ('storehub_mongo','zreadings','oldgross','double precision'),
	 ('storehub_mongo','zreadings','oldnet','double precision'),
	 ('storehub_mongo','zreadings','ptu','character varying'),
	 ('storehub_mongo','zreadings','pwddiscount','double precision'),
	 ('storehub_mongo','zreadings','refundamount','double precision'),
	 ('storehub_mongo','zreadings','refundtrxcount','double precision'),
	 ('storehub_mongo','zreadings','registerid','character varying'),
	 ('storehub_mongo','zreadings','regulardiscount','double precision'),
	 ('storehub_mongo','zreadings','salestrxcount','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','zreadings','scdiscount','double precision'),
	 ('storehub_mongo','zreadings','serialno','character varying'),
	 ('storehub_mongo','zreadings','servicecharge','numeric'),
	 ('storehub_mongo','zreadings','servicechargetax','double precision'),
	 ('storehub_mongo','zreadings','soloparentdiscount','double precision'),
	 ('storehub_mongo','zreadings','startornumber','character varying'),
	 ('storehub_mongo','zreadings','starttrxnumber','character varying'),
	 ('storehub_mongo','zreadings','storeid','character varying'),
	 ('storehub_mongo','zreadings','tin','character varying'),
	 ('storehub_mongo','zreadings','totaldeductedvat','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','zreadings','transactionswithathleteandcoachdiscount','double precision'),
	 ('storehub_mongo','zreadings','transactionswithmedalofvalordiscount','double precision'),
	 ('storehub_mongo','zreadings','transactionswithpwddiscount','double precision'),
	 ('storehub_mongo','zreadings','transactionswithregulardiscount','double precision'),
	 ('storehub_mongo','zreadings','transactionswithscdiscount','double precision'),
	 ('storehub_mongo','zreadings','vatablesales','double precision'),
	 ('storehub_mongo','zreadings','vatamount','double precision'),
	 ('storehub_mongo','zreadings','vatexemptsales','double precision'),
	 ('storehub_mongo','zreadings','zcount','double precision'),
	 ('storehub_mongo','zreadings','zendtime','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','zreadings','zeroratedsales','double precision'),
	 ('storehub_mongo','zreadings','zstarttime','timestamp without time zone');

-- Table: registerlocalsettings__localsettings (349,408 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','registerlocalsettings__localsettings','_id','character varying'),
	 ('storehub_mongo','registerlocalsettings__localsettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','registerlocalsettings__localsettings','key','character varying'),
	 ('storehub_mongo','registerlocalsettings__localsettings','registerlocalsettings_foreignkey','character varying'),
	 ('storehub_mongo','registerlocalsettings__localsettings','value','character varying');

-- Table: suppliers (300,459 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','suppliers','_id','character varying'),
	 ('storehub_mongo','suppliers','business','character varying'),
	 ('storehub_mongo','suppliers','city','character varying'),
	 ('storehub_mongo','suppliers','contactname','character varying'),
	 ('storehub_mongo','suppliers','country','character varying'),
	 ('storehub_mongo','suppliers','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','suppliers','email','character varying'),
	 ('storehub_mongo','suppliers','fax','character varying'),
	 ('storehub_mongo','suppliers','name','character varying'),
	 ('storehub_mongo','suppliers','phone','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','suppliers','postalcode','character varying'),
	 ('storehub_mongo','suppliers','state','character varying'),
	 ('storehub_mongo','suppliers','street1','character varying'),
	 ('storehub_mongo','suppliers','street2','character varying'),
	 ('storehub_mongo','suppliers','website','character varying');

-- Table: purchaseorders (289,254 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','purchaseorders','_id','character varying'),
	 ('storehub_mongo','purchaseorders','business','character varying'),
	 ('storehub_mongo','purchaseorders','completedby','character varying'),
	 ('storehub_mongo','purchaseorders','createdtime','timestamp without time zone'),
	 ('storehub_mongo','purchaseorders','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','purchaseorders','discount','numeric'),
	 ('storehub_mongo','purchaseorders','expectedarrivaldate','timestamp without time zone'),
	 ('storehub_mongo','purchaseorders','failedtoupdateinventory','boolean'),
	 ('storehub_mongo','purchaseorders','inventorychangemsgtrackinfo.eventid','character varying'),
	 ('storehub_mongo','purchaseorders','inventorychangemsgtrackinfo.issendmsg','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','purchaseorders','inventorychangemsgtrackinfo.sendmsgstartat','timestamp without time zone'),
	 ('storehub_mongo','purchaseorders','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','purchaseorders','notes','character varying'),
	 ('storehub_mongo','purchaseorders','purchaseorderid','double precision'),
	 ('storehub_mongo','purchaseorders','status','character varying'),
	 ('storehub_mongo','purchaseorders','subtotal','numeric'),
	 ('storehub_mongo','purchaseorders','supplierid','character varying'),
	 ('storehub_mongo','purchaseorders','targetstoreid','character varying'),
	 ('storehub_mongo','purchaseorders','tax','numeric'),
	 ('storehub_mongo','purchaseorders','total','numeric');

-- Table: sharedmodifiers__optionvalues (172,384 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','sharedmodifiers__optionvalues','_id','character varying'),
	 ('storehub_mongo','sharedmodifiers__optionvalues','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','sharedmodifiers__optionvalues','isdefault','boolean'),
	 ('storehub_mongo','sharedmodifiers__optionvalues','markedsoldout','boolean'),
	 ('storehub_mongo','sharedmodifiers__optionvalues','order','double precision'),
	 ('storehub_mongo','sharedmodifiers__optionvalues','pricediff','double precision'),
	 ('storehub_mongo','sharedmodifiers__optionvalues','pricediffbeforegstadjustment','double precision'),
	 ('storehub_mongo','sharedmodifiers__optionvalues','sharedmodifiers_foreignkey','character varying'),
	 ('storehub_mongo','sharedmodifiers__optionvalues','soldoutstoreids','character varying'),
	 ('storehub_mongo','sharedmodifiers__optionvalues','value','character varying');

-- Table: reviewinfohistories (128,507 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','reviewinfohistories','_id','character varying'),
	 ('storehub_mongo','reviewinfohistories','business','character varying'),
	 ('storehub_mongo','reviewinfohistories','createdtime','timestamp without time zone'),
	 ('storehub_mongo','reviewinfohistories','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','reviewinfohistories','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','reviewinfohistories','placeid','character varying'),
	 ('storehub_mongo','reviewinfohistories','pricelevel','double precision'),
	 ('storehub_mongo','reviewinfohistories','rating','double precision'),
	 ('storehub_mongo','reviewinfohistories','ratingcount','double precision'),
	 ('storehub_mongo','reviewinfohistories','refid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','reviewinfohistories','reftype','character varying');

-- Table: subscriptions (59,084 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','subscriptions','_id','character varying'),
	 ('storehub_mongo','subscriptions','business','character varying'),
	 ('storehub_mongo','subscriptions','creditcardaddedway','character varying'),
	 ('storehub_mongo','subscriptions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','subscriptions','hasscheduledchanges','boolean'),
	 ('storehub_mongo','subscriptions','lasteventtime','timestamp without time zone'),
	 ('storehub_mongo','subscriptions','softwareorderamount','double precision'),
	 ('storehub_mongo','subscriptions','softwareorderid','character varying'),
	 ('storehub_mongo','subscriptions','subscriptioncreatedtime','timestamp without time zone'),
	 ('storehub_mongo','subscriptions','subscriptionid','character varying');

-- Table: storereviews (52,469 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','storereviews','_id','character varying'),
	 ('storehub_mongo','storereviews','allowmerchantcontact','boolean'),
	 ('storehub_mongo','storereviews','business','character varying'),
	 ('storehub_mongo','storereviews','clickcount','double precision'),
	 ('storehub_mongo','storereviews','comments','character varying'),
	 ('storehub_mongo','storereviews','contactname','character varying'),
	 ('storehub_mongo','storereviews','contactphone','character varying'),
	 ('storehub_mongo','storereviews','createdtime','timestamp without time zone'),
	 ('storehub_mongo','storereviews','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','storereviews','modifiedtime','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','storereviews','placeid','character varying'),
	 ('storehub_mongo','storereviews','rating','double precision'),
	 ('storehub_mongo','storereviews','receiptnumber','character varying'),
	 ('storehub_mongo','storereviews','storeid','character varying');

-- Table: comments (49,467 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','comments','_id','character varying'),
	 ('storehub_mongo','comments','content','character varying'),
	 ('storehub_mongo','comments','createdtime','timestamp without time zone'),
	 ('storehub_mongo','comments','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','comments','isdeleted','boolean'),
	 ('storehub_mongo','comments','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','comments','refid','character varying'),
	 ('storehub_mongo','comments','type','character varying'),
	 ('storehub_mongo','comments','useravatar','character varying'),
	 ('storehub_mongo','comments','useremail','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','comments','userid','character varying'),
	 ('storehub_mongo','comments','username','character varying');

-- Table: sharedmodifiers (40,830 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','sharedmodifiers','_id','character varying'),
	 ('storehub_mongo','sharedmodifiers','allowmultiqty','boolean'),
	 ('storehub_mongo','sharedmodifiers','business','character varying'),
	 ('storehub_mongo','sharedmodifiers','createdat','timestamp without time zone'),
	 ('storehub_mongo','sharedmodifiers','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','sharedmodifiers','enableselectionamountlimit','boolean'),
	 ('storehub_mongo','sharedmodifiers','ismodifier','boolean'),
	 ('storehub_mongo','sharedmodifiers','maxselectionamount','double precision'),
	 ('storehub_mongo','sharedmodifiers','minselectionamount','double precision'),
	 ('storehub_mongo','sharedmodifiers','name','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','sharedmodifiers','sharedmodifierid','character varying'),
	 ('storehub_mongo','sharedmodifiers','updatedat','timestamp without time zone'),
	 ('storehub_mongo','sharedmodifiers','variationtype','character varying');

-- Table: feedbacks (34,308 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','feedbacks','_id','character varying'),
	 ('storehub_mongo','feedbacks','createdtime','timestamp without time zone'),
	 ('storehub_mongo','feedbacks','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','feedbacks','email','character varying'),
	 ('storehub_mongo','feedbacks','image','character varying'),
	 ('storehub_mongo','feedbacks','logisticsprovider','character varying'),
	 ('storehub_mongo','feedbacks','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','feedbacks','notes','character varying'),
	 ('storehub_mongo','feedbacks','reasoncode','character varying'),
	 ('storehub_mongo','feedbacks','receiptnumber','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','feedbacks','reportertype','character varying'),
	 ('storehub_mongo','feedbacks','status','double precision');

-- Table: qbosettings__qboaccounts (29,017 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','qbosettings__qboaccounts','_id','character varying'),
	 ('storehub_mongo','qbosettings__qboaccounts','classification','character varying'),
	 ('storehub_mongo','qbosettings__qboaccounts','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','qbosettings__qboaccounts','id','character varying'),
	 ('storehub_mongo','qbosettings__qboaccounts','name','character varying'),
	 ('storehub_mongo','qbosettings__qboaccounts','qbosettings_foreignkey','character varying');

-- Table: xerosettings__accounts (25,457 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','xerosettings__accounts','_id','character varying'),
	 ('storehub_mongo','xerosettings__accounts','code','character varying'),
	 ('storehub_mongo','xerosettings__accounts','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','xerosettings__accounts','enablepaymentstoaccount','boolean'),
	 ('storehub_mongo','xerosettings__accounts','id','character varying'),
	 ('storehub_mongo','xerosettings__accounts','name','character varying'),
	 ('storehub_mongo','xerosettings__accounts','type','character varying'),
	 ('storehub_mongo','xerosettings__accounts','xerosettings_foreignkey','character varying');

-- Table: registerlocalsettings (21,748 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','registerlocalsettings','_id','character varying'),
	 ('storehub_mongo','registerlocalsettings','businessname','character varying'),
	 ('storehub_mongo','registerlocalsettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','registerlocalsettings','registerid','character varying');

-- Table: purchaseorders__ordereditems__componentsusages (21,380 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','purchaseorders__ordereditems__componentsusages','_id','character varying'),
	 ('storehub_mongo','purchaseorders__ordereditems__componentsusages','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','purchaseorders__ordereditems__componentsusages','lockeddate','timestamp without time zone'),
	 ('storehub_mongo','purchaseorders__ordereditems__componentsusages','lockedquantity','double precision'),
	 ('storehub_mongo','purchaseorders__ordereditems__componentsusages','productid','character varying'),
	 ('storehub_mongo','purchaseorders__ordereditems__componentsusages','purchaseorders__ordereditems_foreignkey','character varying'),
	 ('storehub_mongo','purchaseorders__ordereditems__componentsusages','purchaseorders_foreignkey','character varying'),
	 ('storehub_mongo','purchaseorders__ordereditems__componentsusages','quantity','double precision');

-- Table: subscriptionorders (21,109 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','subscriptionorders','_id','character varying'),
	 ('storehub_mongo','subscriptionorders','action','character varying'),
	 ('storehub_mongo','subscriptionorders','business','character varying'),
	 ('storehub_mongo','subscriptionorders','createdtime','timestamp without time zone'),
	 ('storehub_mongo','subscriptionorders','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','subscriptionorders','discountamount','double precision'),
	 ('storehub_mongo','subscriptionorders','errorcode','character varying'),
	 ('storehub_mongo','subscriptionorders','expirationseconds','double precision'),
	 ('storehub_mongo','subscriptionorders','isb2bpayment','boolean'),
	 ('storehub_mongo','subscriptionorders','numberofrenewals','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','subscriptionorders','ordertype','character varying'),
	 ('storehub_mongo','subscriptionorders','outdated','boolean'),
	 ('storehub_mongo','subscriptionorders','paymentgateway','character varying'),
	 ('storehub_mongo','subscriptionorders','paymentid','character varying'),
	 ('storehub_mongo','subscriptionorders','paymentmethod','character varying'),
	 ('storehub_mongo','subscriptionorders','paymentprovider','character varying'),
	 ('storehub_mongo','subscriptionorders','planid','character varying'),
	 ('storehub_mongo','subscriptionorders','price','double precision'),
	 ('storehub_mongo','subscriptionorders','shortid','character varying'),
	 ('storehub_mongo','subscriptionorders','status','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','subscriptionorders','taxamount','double precision'),
	 ('storehub_mongo','subscriptionorders','updatedtime','timestamp without time zone');

-- Table: einvoicerequestrecords (20,478 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','einvoicerequestrecords','_id','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','addonrequestinfo','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','business','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','createdat','timestamp without time zone'),
	 ('storehub_mongo','einvoicerequestrecords','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','einvoicerequestrecords','einvoicedocumenttype','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','isonline','boolean'),
	 ('storehub_mongo','einvoicerequestrecords','rawrequestinfo','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','receiptnumbers','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','requestor.requestorid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','einvoicerequestrecords','requestor.requestortype','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','requestresult.documentid','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','requestresult.documentlongid','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','requestresult.einvoicestatus','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','requestresult.errormessage','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','requestresult.statusupdatedat','timestamp without time zone'),
	 ('storehub_mongo','einvoicerequestrecords','requestresult.submitid','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','requesttype','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','storeid','character varying'),
	 ('storehub_mongo','einvoicerequestrecords','submitcontent','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','einvoicerequestrecords','updatedat','timestamp without time zone');

-- Table: bankaccounts (17,812 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','bankaccounts','_id','character varying'),
	 ('storehub_mongo','bankaccounts','appliedstores','character varying'),
	 ('storehub_mongo','bankaccounts','bankaccountnumber','character varying'),
	 ('storehub_mongo','bankaccounts','bankcode','character varying'),
	 ('storehub_mongo','bankaccounts','bankname','character varying'),
	 ('storehub_mongo','bankaccounts','business','character varying'),
	 ('storehub_mongo','bankaccounts','createdtime','timestamp without time zone'),
	 ('storehub_mongo','bankaccounts','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','bankaccounts','emails','character varying'),
	 ('storehub_mongo','bankaccounts','holdername','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','bankaccounts','isdeleted','boolean'),
	 ('storehub_mongo','bankaccounts','updatedtime','timestamp without time zone');

-- Table: shareinforequests (11,384 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shareinforequests','_id','character varying'),
	 ('storehub_mongo','shareinforequests','consumerid','character varying'),
	 ('storehub_mongo','shareinforequests','createdtime','timestamp without time zone'),
	 ('storehub_mongo','shareinforequests','customerid','character varying'),
	 ('storehub_mongo','shareinforequests','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shareinforequests','employeeid','character varying'),
	 ('storehub_mongo','shareinforequests','expireddate','timestamp without time zone'),
	 ('storehub_mongo','shareinforequests','isnewcustomer','boolean'),
	 ('storehub_mongo','shareinforequests','isnewmember','boolean'),
	 ('storehub_mongo','shareinforequests','merchantname','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shareinforequests','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','shareinforequests','registerid','character varying'),
	 ('storehub_mongo','shareinforequests','scanneddate','timestamp without time zone'),
	 ('storehub_mongo','shareinforequests','sharedinfodate','timestamp without time zone'),
	 ('storehub_mongo','shareinforequests','source','character varying'),
	 ('storehub_mongo','shareinforequests','storeid','character varying');

-- Table: subscriptions__addons (11,129 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','subscriptions__addons','count','double precision'),
	 ('storehub_mongo','subscriptions__addons','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','subscriptions__addons','id','character varying'),
	 ('storehub_mongo','subscriptions__addons','subscriptions_foreignkey','character varying'),
	 ('storehub_mongo','subscriptions__addons','unitprice','double precision');

-- Table: reviewinfos (7,525 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','reviewinfos','_id','character varying'),
	 ('storehub_mongo','reviewinfos','business','character varying'),
	 ('storehub_mongo','reviewinfos','createdtime','timestamp without time zone'),
	 ('storehub_mongo','reviewinfos','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','reviewinfos','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','reviewinfos','placeid','character varying'),
	 ('storehub_mongo','reviewinfos','pricelevel','double precision'),
	 ('storehub_mongo','reviewinfos','rating','double precision'),
	 ('storehub_mongo','reviewinfos','ratingcount','double precision'),
	 ('storehub_mongo','reviewinfos','refid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','reviewinfos','reftype','character varying');

-- Table: customtransactionfeerates (6,757 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','customtransactionfeerates','_id','character varying'),
	 ('storehub_mongo','customtransactionfeerates','business','character varying'),
	 ('storehub_mongo','customtransactionfeerates','createdtime','timestamp without time zone'),
	 ('storehub_mongo','customtransactionfeerates','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','customtransactionfeerates','modifiedtime','timestamp without time zone');

-- Table: customtransactionfeerates__rateconfig (6,757 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','customtransactionfeerates__rateconfig','_id','character varying'),
	 ('storehub_mongo','customtransactionfeerates__rateconfig','beepdelivery','double precision'),
	 ('storehub_mongo','customtransactionfeerates__rateconfig','beepinstore','double precision'),
	 ('storehub_mongo','customtransactionfeerates__rateconfig','beeppickup','double precision'),
	 ('storehub_mongo','customtransactionfeerates__rateconfig','beepselfdelivery','double precision'),
	 ('storehub_mongo','customtransactionfeerates__rateconfig','beeptakeaway','double precision'),
	 ('storehub_mongo','customtransactionfeerates__rateconfig','customtransactionfeerates_foreignkey','character varying'),
	 ('storehub_mongo','customtransactionfeerates__rateconfig','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','customtransactionfeerates__rateconfig','ecommerce','double precision');

-- Table: userjobs (5,589 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','userjobs','_id','character varying'),
	 ('storehub_mongo','userjobs','business','character varying'),
	 ('storehub_mongo','userjobs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','userjobs','employeeid','character varying'),
	 ('storehub_mongo','userjobs','error','character varying'),
	 ('storehub_mongo','userjobs','jobtype','character varying'),
	 ('storehub_mongo','userjobs','progress','double precision'),
	 ('storehub_mongo','userjobs','resultsfile','character varying'),
	 ('storehub_mongo','userjobs','status','character varying'),
	 ('storehub_mongo','userjobs','time','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','userjobs','uploadedfile','character varying');

-- Table: qbosettings__qbotaxcodes (4,447 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','qbosettings__qbotaxcodes','_id','character varying'),
	 ('storehub_mongo','qbosettings__qbotaxcodes','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','qbosettings__qbotaxcodes','qbosettings_foreignkey','character varying'),
	 ('storehub_mongo','qbosettings__qbotaxcodes','taxcodeid','character varying'),
	 ('storehub_mongo','qbosettings__qbotaxcodes','taxcodename','character varying');

-- Table: timesheets (3,752 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','timesheets','_id','character varying'),
	 ('storehub_mongo','timesheets','clockinimage','character varying'),
	 ('storehub_mongo','timesheets','clockintime','timestamp without time zone'),
	 ('storehub_mongo','timesheets','clockoutimage','character varying'),
	 ('storehub_mongo','timesheets','clockouttime','timestamp without time zone'),
	 ('storehub_mongo','timesheets','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','timesheets','employeeid','character varying'),
	 ('storehub_mongo','timesheets','storeid','character varying');

-- Table: qbosettings (2,398 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','qbosettings','_id','character varying'),
	 ('storehub_mongo','qbosettings','accesstoken','character varying'),
	 ('storehub_mongo','qbosettings','accesstokenexpiresin','double precision'),
	 ('storehub_mongo','qbosettings','accesstokensecret','character varying'),
	 ('storehub_mongo','qbosettings','accountmapping','character varying'),
	 ('storehub_mongo','qbosettings','businessname','character varying'),
	 ('storehub_mongo','qbosettings','companyid','character varying'),
	 ('storehub_mongo','qbosettings','customerid','character varying'),
	 ('storehub_mongo','qbosettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','qbosettings','firstconnected','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','qbosettings','hasrequestedstart','boolean'),
	 ('storehub_mongo','qbosettings','isallproductsmatched','boolean'),
	 ('storehub_mongo','qbosettings','pausereason','character varying'),
	 ('storehub_mongo','qbosettings','paymentmethodmapping','character varying'),
	 ('storehub_mongo','qbosettings','refreshtoken','character varying'),
	 ('storehub_mongo','qbosettings','refreshtokenexpiresin','double precision'),
	 ('storehub_mongo','qbosettings','refundfromaccountid','character varying'),
	 ('storehub_mongo','qbosettings','requesttoken','character varying'),
	 ('storehub_mongo','qbosettings','requesttokensecret','character varying'),
	 ('storehub_mongo','qbosettings','starttime','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','qbosettings','state','character varying'),
	 ('storehub_mongo','qbosettings','status','character varying'),
	 ('storehub_mongo','qbosettings','taxcodemapping','character varying'),
	 ('storehub_mongo','qbosettings','unmappedtaxcode','character varying');

-- Table: xerosettings (539 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','xerosettings','_id','character varying'),
	 ('storehub_mongo','xerosettings','accesstoken','character varying'),
	 ('storehub_mongo','xerosettings','accesstokenexpiresin','double precision'),
	 ('storehub_mongo','xerosettings','accesstokensecret','character varying'),
	 ('storehub_mongo','xerosettings','accountmapping','character varying'),
	 ('storehub_mongo','xerosettings','businessname','character varying'),
	 ('storehub_mongo','xerosettings','companyid','character varying'),
	 ('storehub_mongo','xerosettings','customerid','character varying'),
	 ('storehub_mongo','xerosettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','xerosettings','expiresat','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','xerosettings','firstconnected','boolean'),
	 ('storehub_mongo','xerosettings','hasrequestedstart','boolean'),
	 ('storehub_mongo','xerosettings','isallproductsmatched','boolean'),
	 ('storehub_mongo','xerosettings','oauthexpiresat','timestamp without time zone'),
	 ('storehub_mongo','xerosettings','oauthsessionhandle','character varying'),
	 ('storehub_mongo','xerosettings','organizationname','character varying'),
	 ('storehub_mongo','xerosettings','pausereason','character varying'),
	 ('storehub_mongo','xerosettings','paymentmethodmapping','character varying'),
	 ('storehub_mongo','xerosettings','previousstatus','character varying'),
	 ('storehub_mongo','xerosettings','refreshtoken','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','xerosettings','refreshtokenexpiresin','double precision'),
	 ('storehub_mongo','xerosettings','refundfromaccountid','character varying'),
	 ('storehub_mongo','xerosettings','requesttoken','character varying'),
	 ('storehub_mongo','xerosettings','requesttokensecret','character varying'),
	 ('storehub_mongo','xerosettings','starttime','timestamp without time zone'),
	 ('storehub_mongo','xerosettings','state','character varying'),
	 ('storehub_mongo','xerosettings','status','character varying'),
	 ('storehub_mongo','xerosettings','taxcodemapping','character varying'),
	 ('storehub_mongo','xerosettings','unmappedtaxcode','character varying');

-- Table: xerosettings__taxcodes (430 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','xerosettings__taxcodes','_id','character varying'),
	 ('storehub_mongo','xerosettings__taxcodes','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','xerosettings__taxcodes','taxcodeid','character varying'),
	 ('storehub_mongo','xerosettings__taxcodes','taxcodename','character varying'),
	 ('storehub_mongo','xerosettings__taxcodes','xerosettings_foreignkey','character varying');

-- Table: shifts (365 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shifts','_id','character varying'),
	 ('storehub_mongo','shifts','beeptransactionids','character varying'),
	 ('storehub_mongo','shifts','beeptransactions','character varying'),
	 ('storehub_mongo','shifts','business','character varying'),
	 ('storehub_mongo','shifts','cancelledamount','double precision'),
	 ('storehub_mongo','shifts','cancelledcount','double precision'),
	 ('storehub_mongo','shifts','cashreturnsroundedamount','double precision'),
	 ('storehub_mongo','shifts','cashsalesroundedamount','double precision'),
	 ('storehub_mongo','shifts','closeby','character varying'),
	 ('storehub_mongo','shifts','closetime','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shifts','closingamount','double precision'),
	 ('storehub_mongo','shifts','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shifts','detailaccountingsyncstatus','character varying'),
	 ('storehub_mongo','shifts','discountedamount','double precision'),
	 ('storehub_mongo','shifts','discountedcount','double precision'),
	 ('storehub_mongo','shifts','enablecashback','boolean'),
	 ('storehub_mongo','shifts','isaccountingsynced','boolean'),
	 ('storehub_mongo','shifts','loyaltydiscounts','character varying'),
	 ('storehub_mongo','shifts','minno','character varying'),
	 ('storehub_mongo','shifts','openby','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shifts','openingamount','double precision'),
	 ('storehub_mongo','shifts','opentime','timestamp without time zone'),
	 ('storehub_mongo','shifts','qboinvoiceid','character varying'),
	 ('storehub_mongo','shifts','qbosynctime','double precision'),
	 ('storehub_mongo','shifts','registerappversion','character varying'),
	 ('storehub_mongo','shifts','registerid','character varying'),
	 ('storehub_mongo','shifts','registerobjectid','character varying'),
	 ('storehub_mongo','shifts','registertransactionids','character varying'),
	 ('storehub_mongo','shifts','registertransactions','character varying'),
	 ('storehub_mongo','shifts','returnsroundedamount','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shifts','salesroundedamount','double precision'),
	 ('storehub_mongo','shifts','servicecharge','character varying'),
	 ('storehub_mongo','shifts','shiftid','character varying'),
	 ('storehub_mongo','shifts','storeid','character varying'),
	 ('storehub_mongo','shifts','totalsalesamount','double precision'),
	 ('storehub_mongo','shifts','transactioncount','double precision');

-- Table: shifts__taxsummary (282 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','shifts__taxsummary','_id','character varying'),
	 ('storehub_mongo','shifts__taxsummary','amount','numeric'),
	 ('storehub_mongo','shifts__taxsummary','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','shifts__taxsummary','name','character varying'),
	 ('storehub_mongo','shifts__taxsummary','rate','double precision'),
	 ('storehub_mongo','shifts__taxsummary','shifts_foreignkey','character varying'),
	 ('storehub_mongo','shifts__taxsummary','taxcodeid','character varying');

-- Table: searchingtags (151 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','searchingtags','_id','character varying'),
	 ('storehub_mongo','searchingtags','createdby','character varying'),
	 ('storehub_mongo','searchingtags','createdtime','timestamp without time zone'),
	 ('storehub_mongo','searchingtags','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','searchingtags','tagname','character varying'),
	 ('storehub_mongo','searchingtags','tagtype','character varying'),
	 ('storehub_mongo','searchingtags','updatedtime','timestamp without time zone');

-- Table: marketingtags (56 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','marketingtags','_id','character varying'),
	 ('storehub_mongo','marketingtags','businesses','character varying'),
	 ('storehub_mongo','marketingtags','createdby','character varying'),
	 ('storehub_mongo','marketingtags','createdtime','timestamp without time zone'),
	 ('storehub_mongo','marketingtags','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','marketingtags','modifiedby','character varying'),
	 ('storehub_mongo','marketingtags','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','marketingtags','tagname','character varying');

-- =====================================================
-- Category: Payments
-- =====================================================

-- Table: paymentrecordlogs (72,977,328 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','paymentrecordlogs','_id','character varying'),
	 ('storehub_mongo','paymentrecordlogs','createdtime','timestamp without time zone'),
	 ('storehub_mongo','paymentrecordlogs','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','paymentrecordlogs','logtime','timestamp without time zone'),
	 ('storehub_mongo','paymentrecordlogs','metadata','character varying'),
	 ('storehub_mongo','paymentrecordlogs','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','paymentrecordlogs','operator','character varying'),
	 ('storehub_mongo','paymentrecordlogs','paymentrecordid','character varying'),
	 ('storehub_mongo','paymentrecordlogs','receiptnumber','character varying'),
	 ('storehub_mongo','paymentrecordlogs','remark','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','paymentrecordlogs','source','character varying'),
	 ('storehub_mongo','paymentrecordlogs','status','character varying');

-- Table: payoutitems (19,231,310 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','payoutitems','_id','character varying'),
	 ('storehub_mongo','payoutitems','amount','numeric'),
	 ('storehub_mongo','payoutitems','batchpayoutid','character varying'),
	 ('storehub_mongo','payoutitems','businessname','character varying'),
	 ('storehub_mongo','payoutitems','cause','character varying'),
	 ('storehub_mongo','payoutitems','countrycode','character varying'),
	 ('storehub_mongo','payoutitems','createdtime','timestamp without time zone'),
	 ('storehub_mongo','payoutitems','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','payoutitems','deliveryrevenue','double precision'),
	 ('storehub_mongo','payoutitems','logisticsfee','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','payoutitems','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','payoutitems','offlinepaidamount','double precision'),
	 ('storehub_mongo','payoutitems','orderamount','double precision'),
	 ('storehub_mongo','payoutitems','orderpromotionamount','double precision'),
	 ('storehub_mongo','payoutitems','ordervoucheramount','double precision'),
	 ('storehub_mongo','payoutitems','paidamount','double precision'),
	 ('storehub_mongo','payoutitems','paymentgateway','character varying'),
	 ('storehub_mongo','payoutitems','paymentgatewayfee','double precision'),
	 ('storehub_mongo','payoutitems','payoutstatus','character varying'),
	 ('storehub_mongo','payoutitems','payouttype','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','payoutitems','pickupsmsfee','double precision'),
	 ('storehub_mongo','payoutitems','productrevenue','double precision'),
	 ('storehub_mongo','payoutitems','promotionamount','double precision'),
	 ('storehub_mongo','payoutitems','receiptnumber','character varying'),
	 ('storehub_mongo','payoutitems','reconstatus','character varying'),
	 ('storehub_mongo','payoutitems','refid','character varying'),
	 ('storehub_mongo','payoutitems','reftype','character varying'),
	 ('storehub_mongo','payoutitems','refundedamount','double precision'),
	 ('storehub_mongo','payoutitems','settledat','timestamp without time zone'),
	 ('storehub_mongo','payoutitems','shippingtype','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','payoutitems','storeid','character varying'),
	 ('storehub_mongo','payoutitems','transactionfee','double precision'),
	 ('storehub_mongo','payoutitems','transactionfeerate','double precision'),
	 ('storehub_mongo','payoutitems','voucheramount','double precision');

-- Table: payoutitems__storehubdetails (19,231,310 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','payoutitems__storehubdetails','_id','character varying'),
	 ('storehub_mongo','payoutitems__storehubdetails','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','payoutitems__storehubdetails','paymentgatewaycost','double precision'),
	 ('storehub_mongo','payoutitems__storehubdetails','paymentgatewayrevenue','double precision'),
	 ('storehub_mongo','payoutitems__storehubdetails','payoutitems_foreignkey','character varying'),
	 ('storehub_mongo','payoutitems__storehubdetails','storehublogisticscost','double precision'),
	 ('storehub_mongo','payoutitems__storehubdetails','storehublogisticsrevenue','double precision');

-- Table: paymentrecords (12,433,804 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','paymentrecords','_id','character varying'),
	 ('storehub_mongo','paymentrecords','amount','numeric'),
	 ('storehub_mongo','paymentrecords','business','character varying'),
	 ('storehub_mongo','paymentrecords','cancelledat','timestamp without time zone'),
	 ('storehub_mongo','paymentrecords','cardholdername','character varying'),
	 ('storehub_mongo','paymentrecords','cardtoken','character varying'),
	 ('storehub_mongo','paymentrecords','cardtype','character varying'),
	 ('storehub_mongo','paymentrecords','createdat','timestamp without time zone'),
	 ('storehub_mongo','paymentrecords','currency','character varying'),
	 ('storehub_mongo','paymentrecords','cvctoken','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','paymentrecords','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','paymentrecords','encryptedcardinfo','character varying'),
	 ('storehub_mongo','paymentrecords','isinternal','boolean'),
	 ('storehub_mongo','paymentrecords','issuercountry','character varying'),
	 ('storehub_mongo','paymentrecords','issuername','character varying'),
	 ('storehub_mongo','paymentrecords','lasterror','character varying'),
	 ('storehub_mongo','paymentrecords','lasterrorcode','character varying'),
	 ('storehub_mongo','paymentrecords','metadata','character varying'),
	 ('storehub_mongo','paymentrecords','nonce','character varying'),
	 ('storehub_mongo','paymentrecords','notificationack','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','paymentrecords','payactionway','character varying'),
	 ('storehub_mongo','paymentrecords','paymentid','character varying'),
	 ('storehub_mongo','paymentrecords','paymentmethodid','character varying'),
	 ('storehub_mongo','paymentrecords','paymentoption','character varying'),
	 ('storehub_mongo','paymentrecords','paymentrecordid','character varying'),
	 ('storehub_mongo','paymentrecords','paymenttype','character varying'),
	 ('storehub_mongo','paymentrecords','provider','character varying'),
	 ('storehub_mongo','paymentrecords','provideraccountid','character varying'),
	 ('storehub_mongo','paymentrecords','provideroption','character varying'),
	 ('storehub_mongo','paymentrecords','receiptnumber','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','paymentrecords','redirecturl','character varying'),
	 ('storehub_mongo','paymentrecords','refundid','character varying'),
	 ('storehub_mongo','paymentrecords','refundrequestid','character varying'),
	 ('storehub_mongo','paymentrecords','shippingtype','character varying'),
	 ('storehub_mongo','paymentrecords','source','character varying'),
	 ('storehub_mongo','paymentrecords','status','character varying'),
	 ('storehub_mongo','paymentrecords','storeid','character varying'),
	 ('storehub_mongo','paymentrecords','updatedat','timestamp without time zone'),
	 ('storehub_mongo','paymentrecords','userid','character varying'),
	 ('storehub_mongo','paymentrecords','webhookurl','character varying');

-- Table: gatewayrecords (10,244,168 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','gatewayrecords','_id','character varying'),
	 ('storehub_mongo','gatewayrecords','country','character varying'),
	 ('storehub_mongo','gatewayrecords','createdtime','timestamp without time zone'),
	 ('storehub_mongo','gatewayrecords','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','gatewayrecords','fee','double precision'),
	 ('storehub_mongo','gatewayrecords','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','gatewayrecords','net','double precision'),
	 ('storehub_mongo','gatewayrecords','paymentgateway','character varying'),
	 ('storehub_mongo','gatewayrecords','paymentrecordid','character varying'),
	 ('storehub_mongo','gatewayrecords','receiptnumber','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','gatewayrecords','reconstatus','character varying'),
	 ('storehub_mongo','gatewayrecords','settlementtime','timestamp without time zone'),
	 ('storehub_mongo','gatewayrecords','transactionamount','double precision'),
	 ('storehub_mongo','gatewayrecords','transactionid','character varying'),
	 ('storehub_mongo','gatewayrecords','transactiontype','character varying'),
	 ('storehub_mongo','gatewayrecords','transferstatus','character varying');

-- Table: zreadings__paymentcollections (2,775,077 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','zreadings__paymentcollections','_id','character varying'),
	 ('storehub_mongo','zreadings__paymentcollections','amount','numeric'),
	 ('storehub_mongo','zreadings__paymentcollections','count','double precision'),
	 ('storehub_mongo','zreadings__paymentcollections','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','zreadings__paymentcollections','name','character varying'),
	 ('storehub_mongo','zreadings__paymentcollections','zreadings_foreignkey','character varying');

-- Table: batchpayouts (486,016 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','batchpayouts','_id','character varying'),
	 ('storehub_mongo','batchpayouts','bankaccountid','character varying'),
	 ('storehub_mongo','batchpayouts','businessname','character varying'),
	 ('storehub_mongo','batchpayouts','countrycode','character varying'),
	 ('storehub_mongo','batchpayouts','createdtime','timestamp without time zone'),
	 ('storehub_mongo','batchpayouts','currency','character varying'),
	 ('storehub_mongo','batchpayouts','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','batchpayouts','enddate','timestamp without time zone'),
	 ('storehub_mongo','batchpayouts','merchantbankaccountname','character varying'),
	 ('storehub_mongo','batchpayouts','merchantbankaccountnumber','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','batchpayouts','merchantbankcode','character varying'),
	 ('storehub_mongo','batchpayouts','merchantbankname','character varying'),
	 ('storehub_mongo','batchpayouts','merchanttotaldeliveryrevenue','double precision'),
	 ('storehub_mongo','batchpayouts','merchanttotalproductrevenue','double precision'),
	 ('storehub_mongo','batchpayouts','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','batchpayouts','payoutitemcount','double precision'),
	 ('storehub_mongo','batchpayouts','startdate','timestamp without time zone'),
	 ('storehub_mongo','batchpayouts','storeids','character varying'),
	 ('storehub_mongo','batchpayouts','totaladjustments','double precision'),
	 ('storehub_mongo','batchpayouts','totalbanktransactionfee','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','batchpayouts','totalofflinepaidamount','double precision'),
	 ('storehub_mongo','batchpayouts','totalorderamount','double precision'),
	 ('storehub_mongo','batchpayouts','totalorderpayout','double precision'),
	 ('storehub_mongo','batchpayouts','totalorderpromotionamount','double precision'),
	 ('storehub_mongo','batchpayouts','totalordervoucheramount','double precision'),
	 ('storehub_mongo','batchpayouts','totalpaymentgatewayfee','double precision'),
	 ('storehub_mongo','batchpayouts','totalpayout','double precision'),
	 ('storehub_mongo','batchpayouts','totalpickupsmsfee','double precision'),
	 ('storehub_mongo','batchpayouts','totalpromotionamount','double precision'),
	 ('storehub_mongo','batchpayouts','totalstorehubfee','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','batchpayouts','totalstorehublogisticsfee','double precision'),
	 ('storehub_mongo','batchpayouts','totalvoucheramount','double precision');

-- Table: paymentsettlements__orders (268,970 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','paymentsettlements__orders','_id','character varying'),
	 ('storehub_mongo','paymentsettlements__orders','createdtime','timestamp without time zone'),
	 ('storehub_mongo','paymentsettlements__orders','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','paymentsettlements__orders','deliveryrevenue','double precision'),
	 ('storehub_mongo','paymentsettlements__orders','paymentgateway','character varying'),
	 ('storehub_mongo','paymentsettlements__orders','paymentgatewaycost','double precision'),
	 ('storehub_mongo','paymentsettlements__orders','paymentgatewayfee','double precision'),
	 ('storehub_mongo','paymentsettlements__orders','paymentgatewayrevenue','double precision'),
	 ('storehub_mongo','paymentsettlements__orders','paymentsettlements_foreignkey','character varying'),
	 ('storehub_mongo','paymentsettlements__orders','payout','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','paymentsettlements__orders','productrevenue','double precision'),
	 ('storehub_mongo','paymentsettlements__orders','receiptnumber','character varying'),
	 ('storehub_mongo','paymentsettlements__orders','storehubfee','double precision'),
	 ('storehub_mongo','paymentsettlements__orders','storehublogisticscost','double precision'),
	 ('storehub_mongo','paymentsettlements__orders','storehublogisticsfee','double precision'),
	 ('storehub_mongo','paymentsettlements__orders','storehublogisticsrevenue','double precision'),
	 ('storehub_mongo','paymentsettlements__orders','total','numeric');

-- Table: payoutitems__adjustmentdetails__adjustmentitems (50,257 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','payoutitems__adjustmentdetails__adjustmentitems','_id','character varying'),
	 ('storehub_mongo','payoutitems__adjustmentdetails__adjustmentitems','amount','numeric'),
	 ('storehub_mongo','payoutitems__adjustmentdetails__adjustmentitems','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','payoutitems__adjustmentdetails__adjustmentitems','payoutitems__adjustmentdetails_foreignkey','character varying'),
	 ('storehub_mongo','payoutitems__adjustmentdetails__adjustmentitems','payoutitems_foreignkey','character varying'),
	 ('storehub_mongo','payoutitems__adjustmentdetails__adjustmentitems','quantity','double precision'),
	 ('storehub_mongo','payoutitems__adjustmentdetails__adjustmentitems','refid','character varying'),
	 ('storehub_mongo','payoutitems__adjustmentdetails__adjustmentitems','reftype','character varying'),
	 ('storehub_mongo','payoutitems__adjustmentdetails__adjustmentitems','title','character varying'),
	 ('storehub_mongo','payoutitems__adjustmentdetails__adjustmentitems','type','character varying');

-- Table: payoutitems__adjustmentdetails (48,582 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','payoutitems__adjustmentdetails','_id','character varying'),
	 ('storehub_mongo','payoutitems__adjustmentdetails','amount','numeric'),
	 ('storehub_mongo','payoutitems__adjustmentdetails','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','payoutitems__adjustmentdetails','payoutitems_foreignkey','character varying'),
	 ('storehub_mongo','payoutitems__adjustmentdetails','reason','character varying'),
	 ('storehub_mongo','payoutitems__adjustmentdetails','remarks','character varying');

-- Table: qbosettings__qbopaymentmethods (1,375 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','qbosettings__qbopaymentmethods','_id','character varying'),
	 ('storehub_mongo','qbosettings__qbopaymentmethods','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','qbosettings__qbopaymentmethods','paymentmethodid','character varying'),
	 ('storehub_mongo','qbosettings__qbopaymentmethods','paymentmethodname','character varying'),
	 ('storehub_mongo','qbosettings__qbopaymentmethods','qbosettings_foreignkey','character varying');

-- Table: onlinestoreinfos__offlinepaymentinstructions (470 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentinstructions','_id','character varying'),
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentinstructions','additionalnotes','character varying'),
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentinstructions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentinstructions','enabledcontactinfo','character varying'),
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentinstructions','onlinestoreinfos_foreignkey','character varying');

-- Table: onlinestoreinfos__offlinepaymentbankaccounts (437 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentbankaccounts','_id','character varying'),
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentbankaccounts','bankaccountname','character varying'),
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentbankaccounts','bankaccountnumber','character varying'),
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentbankaccounts','bankname','character varying'),
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentbankaccounts','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentbankaccounts','onlinestoreinfos_foreignkey','character varying'),
	 ('storehub_mongo','onlinestoreinfos__offlinepaymentbankaccounts','ordering','double precision');

-- Table: onlinestoreinfos__onlinepaymentoptions (74 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','onlinestoreinfos__onlinepaymentoptions','_id','character varying'),
	 ('storehub_mongo','onlinestoreinfos__onlinepaymentoptions','additionalinfo','character varying'),
	 ('storehub_mongo','onlinestoreinfos__onlinepaymentoptions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','onlinestoreinfos__onlinepaymentoptions','isdisabled','boolean'),
	 ('storehub_mongo','onlinestoreinfos__onlinepaymentoptions','name','character varying'),
	 ('storehub_mongo','onlinestoreinfos__onlinepaymentoptions','onlinestoreinfos_foreignkey','character varying');

-- =====================================================
-- Category: Products
-- =====================================================

-- Table: products (33,301,429 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products','_id','character varying'),
	 ('storehub_mongo','products','barcode','character varying'),
	 ('storehub_mongo','products','beforegstadjustment','character varying'),
	 ('storehub_mongo','products','business','character varying'),
	 ('storehub_mongo','products','category','character varying'),
	 ('storehub_mongo','products','classificationcode','character varying'),
	 ('storehub_mongo','products','cost','numeric'),
	 ('storehub_mongo','products','createdtime','timestamp without time zone'),
	 ('storehub_mongo','products','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','products','deletedbarcode','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products','deletedskunumber','character varying'),
	 ('storehub_mongo','products','description','character varying'),
	 ('storehub_mongo','products','descriptionimages','character varying'),
	 ('storehub_mongo','products','detailedinfo','character varying'),
	 ('storehub_mongo','products','externalid','character varying'),
	 ('storehub_mongo','products','foodpandaprice','double precision'),
	 ('storehub_mongo','products','grabfoodprice','double precision'),
	 ('storehub_mongo','products','hasthumbnail','boolean'),
	 ('storehub_mongo','products','images','character varying'),
	 ('storehub_mongo','products','inventorystartdate','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products','inventorytype','character varying'),
	 ('storehub_mongo','products','isbasicnecessitiesph','boolean'),
	 ('storehub_mongo','products','ischild','boolean'),
	 ('storehub_mongo','products','isdeleted','boolean'),
	 ('storehub_mongo','products','ishalal','boolean'),
	 ('storehub_mongo','products','isonbeep','boolean'),
	 ('storehub_mongo','products','isonfoodpanda','boolean'),
	 ('storehub_mongo','products','isongrabfood','boolean'),
	 ('storehub_mongo','products','isonline','boolean'),
	 ('storehub_mongo','products','isonshopeefood','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products','issample','boolean'),
	 ('storehub_mongo','products','isserialized','boolean'),
	 ('storehub_mongo','products','issoloparentdiscountapplicable','boolean'),
	 ('storehub_mongo','products','kitchenprinter','character varying'),
	 ('storehub_mongo','products','lastsupplierprice','double precision'),
	 ('storehub_mongo','products','lastupdatethumbnail','timestamp without time zone'),
	 ('storehub_mongo','products','loyalty','double precision'),
	 ('storehub_mongo','products','markedsoldout','boolean'),
	 ('storehub_mongo','products','maxrefunitprice','double precision'),
	 ('storehub_mongo','products','minrefunitprice','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','products','onlinesaleprice','double precision'),
	 ('storehub_mongo','products','onlinetitle','character varying'),
	 ('storehub_mongo','products','onlineunitprice','double precision'),
	 ('storehub_mongo','products','onlyforpreorder','boolean'),
	 ('storehub_mongo','products','original_id','character varying'),
	 ('storehub_mongo','products','originalid','character varying'),
	 ('storehub_mongo','products','parentproductid','character varying'),
	 ('storehub_mongo','products','pricetype','character varying'),
	 ('storehub_mongo','products','producttype','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products','shopeefoodprice','double precision'),
	 ('storehub_mongo','products','skunumber','character varying'),
	 ('storehub_mongo','products','slug','character varying'),
	 ('storehub_mongo','products','soldoutstoreids','character varying'),
	 ('storehub_mongo','products','supplierid','character varying'),
	 ('storehub_mongo','products','supplierids','character varying'),
	 ('storehub_mongo','products','tags','character varying'),
	 ('storehub_mongo','products','taxcode','character varying'),
	 ('storehub_mongo','products','title','character varying'),
	 ('storehub_mongo','products','trackinventory','boolean');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products','unit','character varying'),
	 ('storehub_mongo','products','unitprice','double precision'),
	 ('storehub_mongo','products','validdays','character varying'),
	 ('storehub_mongo','products','validfrom','timestamp without time zone'),
	 ('storehub_mongo','products','validtimefrom','double precision'),
	 ('storehub_mongo','products','validtimeto','double precision'),
	 ('storehub_mongo','products','validto','timestamp without time zone');

-- Table: products__variations__optionvalues (29,309,572 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__variations__optionvalues','_id','character varying'),
	 ('storehub_mongo','products__variations__optionvalues','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','products__variations__optionvalues','isdefault','boolean'),
	 ('storehub_mongo','products__variations__optionvalues','markedsoldout','boolean'),
	 ('storehub_mongo','products__variations__optionvalues','order','double precision'),
	 ('storehub_mongo','products__variations__optionvalues','pricediff','double precision'),
	 ('storehub_mongo','products__variations__optionvalues','pricediffbeforegstadjustment','double precision'),
	 ('storehub_mongo','products__variations__optionvalues','products__variations_foreignkey','character varying'),
	 ('storehub_mongo','products__variations__optionvalues','products_foreignkey','character varying'),
	 ('storehub_mongo','products__variations__optionvalues','soldoutstoreids','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__variations__optionvalues','value','character varying');

-- Table: products__variationvalues (19,545,805 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__variationvalues','_id','character varying'),
	 ('storehub_mongo','products__variationvalues','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','products__variationvalues','products_foreignkey','character varying'),
	 ('storehub_mongo','products__variationvalues','value','character varying'),
	 ('storehub_mongo','products__variationvalues','variationid','character varying');

-- Table: products__variations (7,396,980 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__variations','_id','character varying'),
	 ('storehub_mongo','products__variations','allowmultiqty','boolean'),
	 ('storehub_mongo','products__variations','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','products__variations','enableselectionamountlimit','boolean'),
	 ('storehub_mongo','products__variations','ismodifier','boolean'),
	 ('storehub_mongo','products__variations','maxselectionamount','double precision'),
	 ('storehub_mongo','products__variations','minselectionamount','double precision'),
	 ('storehub_mongo','products__variations','name','character varying'),
	 ('storehub_mongo','products__variations','order','double precision'),
	 ('storehub_mongo','products__variations','products_foreignkey','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__variations','sharedmodifierid','character varying'),
	 ('storehub_mongo','products__variations','variationtype','character varying');

-- Table: products__quickselectpositions (6,043,581 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__quickselectpositions','_id','character varying'),
	 ('storehub_mongo','products__quickselectpositions','backgroundcolor','character varying'),
	 ('storehub_mongo','products__quickselectpositions','categoryid','character varying'),
	 ('storehub_mongo','products__quickselectpositions','column','double precision'),
	 ('storehub_mongo','products__quickselectpositions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','products__quickselectpositions','layoutid','character varying'),
	 ('storehub_mongo','products__quickselectpositions','products_foreignkey','character varying'),
	 ('storehub_mongo','products__quickselectpositions','row','double precision');

-- Table: products__stocktakes (5,717,724 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__stocktakes','_id','character varying'),
	 ('storehub_mongo','products__stocktakes','countedat','timestamp without time zone'),
	 ('storehub_mongo','products__stocktakes','countedqty','double precision'),
	 ('storehub_mongo','products__stocktakes','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','products__stocktakes','failedtoupdateinventory','boolean'),
	 ('storehub_mongo','products__stocktakes','products_foreignkey','character varying'),
	 ('storehub_mongo','products__stocktakes','quantity','double precision'),
	 ('storehub_mongo','products__stocktakes','stocktakeid','character varying');

-- Table: products__pricebooks (2,967,002 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__pricebooks','_id','character varying'),
	 ('storehub_mongo','products__pricebooks','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','products__pricebooks','max','double precision'),
	 ('storehub_mongo','products__pricebooks','min','double precision'),
	 ('storehub_mongo','products__pricebooks','pricebookid','character varying'),
	 ('storehub_mongo','products__pricebooks','products_foreignkey','character varying'),
	 ('storehub_mongo','products__pricebooks','taxcode','character varying'),
	 ('storehub_mongo','products__pricebooks','unitprice','double precision');

-- Table: products__components (1,104,444 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__components','_id','character varying'),
	 ('storehub_mongo','products__components','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','products__components','productid','character varying'),
	 ('storehub_mongo','products__components','products_foreignkey','character varying'),
	 ('storehub_mongo','products__components','usages','character varying');

-- Table: products__variations__optionvalues__soldoutstores (724,208 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__variations__optionvalues__soldoutstores','_id','character varying'),
	 ('storehub_mongo','products__variations__optionvalues__soldoutstores','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','products__variations__optionvalues__soldoutstores','duration','double precision'),
	 ('storehub_mongo','products__variations__optionvalues__soldoutstores','products__variations__optionvalues_foreignkey','character varying'),
	 ('storehub_mongo','products__variations__optionvalues__soldoutstores','products_foreignkey','character varying'),
	 ('storehub_mongo','products__variations__optionvalues__soldoutstores','storeid','character varying');

-- Table: products__soldoutstores (488,470 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__soldoutstores','_id','character varying'),
	 ('storehub_mongo','products__soldoutstores','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','products__soldoutstores','duration','double precision'),
	 ('storehub_mongo','products__soldoutstores','products_foreignkey','character varying'),
	 ('storehub_mongo','products__soldoutstores','storeid','character varying');

-- Table: products__beerdocketsettings (24,115 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','products__beerdocketsettings','_id','character varying'),
	 ('storehub_mongo','products__beerdocketsettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','products__beerdocketsettings','docketcount','double precision'),
	 ('storehub_mongo','products__beerdocketsettings','expirationdateduration','double precision'),
	 ('storehub_mongo','products__beerdocketsettings','isenable','boolean'),
	 ('storehub_mongo','products__beerdocketsettings','products_foreignkey','character varying');

-- =====================================================
-- Category: Transactions
-- =====================================================

-- Table: transactionrecords__items (2,434,587,238 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items','_id','character varying'),
	 ('storehub_mongo','transactionrecords__items','adhocdiscount','double precision'),
	 ('storehub_mongo','transactionrecords__items','athleteandcoachdiscount','double precision'),
	 ('storehub_mongo','transactionrecords__items','comments','character varying'),
	 ('storehub_mongo','transactionrecords__items','cost','numeric'),
	 ('storehub_mongo','transactionrecords__items','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__items','discount','numeric'),
	 ('storehub_mongo','transactionrecords__items','discounttype','character varying'),
	 ('storehub_mongo','transactionrecords__items','discountvalue','double precision'),
	 ('storehub_mongo','transactionrecords__items','fullbilldiscount','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items','image','character varying'),
	 ('storehub_mongo','transactionrecords__items','isamusementtax','boolean'),
	 ('storehub_mongo','transactionrecords__items','ishalal','boolean'),
	 ('storehub_mongo','transactionrecords__items','isservicechargenotapplicable','boolean'),
	 ('storehub_mongo','transactionrecords__items','istakeaway','boolean'),
	 ('storehub_mongo','transactionrecords__items','isvatexempted','boolean'),
	 ('storehub_mongo','transactionrecords__items','itemchannel','double precision'),
	 ('storehub_mongo','transactionrecords__items','itemtype','character varying'),
	 ('storehub_mongo','transactionrecords__items','lockeddate','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__items','lockedquantity','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items','loyaltydiscount','double precision'),
	 ('storehub_mongo','transactionrecords__items','medalofvalordiscount','double precision'),
	 ('storehub_mongo','transactionrecords__items','notes','character varying'),
	 ('storehub_mongo','transactionrecords__items','orderingvalue','double precision'),
	 ('storehub_mongo','transactionrecords__items','originalitemid','character varying'),
	 ('storehub_mongo','transactionrecords__items','productid','character varying'),
	 ('storehub_mongo','transactionrecords__items','promotiondiscount','double precision'),
	 ('storehub_mongo','transactionrecords__items','pwddiscount','double precision'),
	 ('storehub_mongo','transactionrecords__items','quantity','double precision'),
	 ('storehub_mongo','transactionrecords__items','refundedquantity','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items','seniordiscount','double precision'),
	 ('storehub_mongo','transactionrecords__items','sn','character varying'),
	 ('storehub_mongo','transactionrecords__items','soloparentdiscount','double precision'),
	 ('storehub_mongo','transactionrecords__items','source','character varying'),
	 ('storehub_mongo','transactionrecords__items','sourcevalue','character varying'),
	 ('storehub_mongo','transactionrecords__items','status','character varying'),
	 ('storehub_mongo','transactionrecords__items','submitid','character varying'),
	 ('storehub_mongo','transactionrecords__items','subtotal','numeric'),
	 ('storehub_mongo','transactionrecords__items','takeawaycharge','double precision'),
	 ('storehub_mongo','transactionrecords__items','tax','numeric');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items','taxableamount','double precision'),
	 ('storehub_mongo','transactionrecords__items','taxcode','character varying'),
	 ('storehub_mongo','transactionrecords__items','taxexemptamount','double precision'),
	 ('storehub_mongo','transactionrecords__items','taxrate','double precision'),
	 ('storehub_mongo','transactionrecords__items','title','character varying'),
	 ('storehub_mongo','transactionrecords__items','total','numeric'),
	 ('storehub_mongo','transactionrecords__items','totaldeductedtax','double precision'),
	 ('storehub_mongo','transactionrecords__items','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__items','unitprice','double precision'),
	 ('storehub_mongo','transactionrecords__items','zeroratedsales','double precision');

-- Table: transactionrecords__payments (984,792,794 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__payments','_id','character varying'),
	 ('storehub_mongo','transactionrecords__payments','amount','numeric'),
	 ('storehub_mongo','transactionrecords__payments','cardname','character varying'),
	 ('storehub_mongo','transactionrecords__payments','cardno','character varying'),
	 ('storehub_mongo','transactionrecords__payments','cashtendered','double precision'),
	 ('storehub_mongo','transactionrecords__payments','changeamount','double precision'),
	 ('storehub_mongo','transactionrecords__payments','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__payments','isdeposit','boolean'),
	 ('storehub_mongo','transactionrecords__payments','isonline','boolean'),
	 ('storehub_mongo','transactionrecords__payments','mpostxnid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__payments','paymentgateway','character varying'),
	 ('storehub_mongo','transactionrecords__payments','paymentmethod','character varying'),
	 ('storehub_mongo','transactionrecords__payments','paymentmethodid','character varying'),
	 ('storehub_mongo','transactionrecords__payments','paymentprovider','character varying'),
	 ('storehub_mongo','transactionrecords__payments','paymentprovidermid','character varying'),
	 ('storehub_mongo','transactionrecords__payments','roundedamount','double precision'),
	 ('storehub_mongo','transactionrecords__payments','subtype','character varying'),
	 ('storehub_mongo','transactionrecords__payments','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords (971,611,229 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','_id','character varying'),
	 ('storehub_mongo','transactionrecords','addonbircompliance.athleteandcoachdiscount','double precision'),
	 ('storehub_mongo','transactionrecords','addonbircompliance.collectedinfo','character varying'),
	 ('storehub_mongo','transactionrecords','addonbircompliance.discounttype','character varying'),
	 ('storehub_mongo','transactionrecords','addonbircompliance.medalofvalordiscount','double precision'),
	 ('storehub_mongo','transactionrecords','addonbircompliance.soloparentdiscount','double precision'),
	 ('storehub_mongo','transactionrecords','amusementtax','double precision'),
	 ('storehub_mongo','transactionrecords','appversion','character varying'),
	 ('storehub_mongo','transactionrecords','business','character varying'),
	 ('storehub_mongo','transactionrecords','cancelledat','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','cancelledby','character varying'),
	 ('storehub_mongo','transactionrecords','cancelleddate','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','cancelledsource','character varying'),
	 ('storehub_mongo','transactionrecords','cancelreason','character varying'),
	 ('storehub_mongo','transactionrecords','cancelreasondetail','character varying'),
	 ('storehub_mongo','transactionrecords','cashtendered','double precision'),
	 ('storehub_mongo','transactionrecords','changedtoofflinepaymentnotifiedsmscount','double precision'),
	 ('storehub_mongo','transactionrecords','channel','double precision'),
	 ('storehub_mongo','transactionrecords','clientid','character varying'),
	 ('storehub_mongo','transactionrecords','comment','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','consumerid','character varying'),
	 ('storehub_mongo','transactionrecords','containerfee','double precision'),
	 ('storehub_mongo','transactionrecords','containerfeetax','double precision'),
	 ('storehub_mongo','transactionrecords','cost','numeric'),
	 ('storehub_mongo','transactionrecords','createdtime','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','createdvouchercodes','character varying'),
	 ('storehub_mongo','transactionrecords','customerid','character varying'),
	 ('storehub_mongo','transactionrecords','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','deductinventorymethod','character varying'),
	 ('storehub_mongo','transactionrecords','delaydetail','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','delayreason','character varying'),
	 ('storehub_mongo','transactionrecords','depositamount','double precision'),
	 ('storehub_mongo','transactionrecords','deviceid','character varying'),
	 ('storehub_mongo','transactionrecords','discount','numeric'),
	 ('storehub_mongo','transactionrecords','einvoiceinfo.documentid','character varying'),
	 ('storehub_mongo','transactionrecords','einvoiceinfo.documenttype','character varying'),
	 ('storehub_mongo','transactionrecords','einvoiceinfo.einvoicestatus','character varying'),
	 ('storehub_mongo','transactionrecords','einvoiceinfo.statusupdatedat','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','emailreceipt','boolean'),
	 ('storehub_mongo','transactionrecords','employeenumber','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','enablecashback','boolean'),
	 ('storehub_mongo','transactionrecords','enabledgooglereviewsmscampaign','boolean'),
	 ('storehub_mongo','transactionrecords','expectdeliverydatefrom','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','expectdeliverydateto','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','failedtosendmembershipstatsqueue','boolean'),
	 ('storehub_mongo','transactionrecords','failedtoupdateinventory','boolean'),
	 ('storehub_mongo','transactionrecords','failedtoupdateloyalty','boolean'),
	 ('storehub_mongo','transactionrecords','fixedfee','double precision'),
	 ('storehub_mongo','transactionrecords','fulfilldate','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','headcount','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','inventorychangemsgtrackinfo.eventid','character varying'),
	 ('storehub_mongo','transactionrecords','inventorychangemsgtrackinfo.issendmsg','boolean'),
	 ('storehub_mongo','transactionrecords','inventorychangemsgtrackinfo.sendmsgstartat','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','invoiceseqnumber','double precision'),
	 ('storehub_mongo','transactionrecords','iscancelled','boolean'),
	 ('storehub_mongo','transactionrecords','isdisbursed','boolean'),
	 ('storehub_mongo','transactionrecords','isnextdaypreorder','boolean'),
	 ('storehub_mongo','transactionrecords','ispaidzero','boolean'),
	 ('storehub_mongo','transactionrecords','ispaylater','boolean'),
	 ('storehub_mongo','transactionrecords','issplittedby','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','issplittedfromreceiptnumber','character varying'),
	 ('storehub_mongo','transactionrecords','lastuploadedtime','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','minno','character varying'),
	 ('storehub_mongo','transactionrecords','modifiedtime','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','notifiedselfpickupsmscount','double precision'),
	 ('storehub_mongo','transactionrecords','onlinebirdate','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','ordersource','character varying'),
	 ('storehub_mongo','transactionrecords','originalreceiptnumber','character varying'),
	 ('storehub_mongo','transactionrecords','originalshippingtype','character varying'),
	 ('storehub_mongo','transactionrecords','otherfee','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','otherreason','character varying'),
	 ('storehub_mongo','transactionrecords','paiddate','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','pax','double precision'),
	 ('storehub_mongo','transactionrecords','paymentmethod','character varying'),
	 ('storehub_mongo','transactionrecords','pendingclaimcashback','double precision'),
	 ('storehub_mongo','transactionrecords','pendingpaymentstarttime','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','pendingtime','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','pickupdate','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','pickupid','character varying'),
	 ('storehub_mongo','transactionrecords','platformservicefee','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','platformservicefeetax','double precision'),
	 ('storehub_mongo','transactionrecords','preorderby','character varying'),
	 ('storehub_mongo','transactionrecords','preorderdate','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','preorderid','character varying'),
	 ('storehub_mongo','transactionrecords','printkitchendocket','boolean'),
	 ('storehub_mongo','transactionrecords','printreceipt','boolean'),
	 ('storehub_mongo','transactionrecords','productsmanualdiscount','double precision'),
	 ('storehub_mongo','transactionrecords','prooffiles','character varying'),
	 ('storehub_mongo','transactionrecords','pwdcount','double precision'),
	 ('storehub_mongo','transactionrecords','pwddiscount','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','receiptnumber','character varying'),
	 ('storehub_mongo','transactionrecords','receiptnumbersbeforefix','character varying'),
	 ('storehub_mongo','transactionrecords','registerid','character varying'),
	 ('storehub_mongo','transactionrecords','registernumber','double precision'),
	 ('storehub_mongo','transactionrecords','returnreason','character varying'),
	 ('storehub_mongo','transactionrecords','returnstatus','character varying'),
	 ('storehub_mongo','transactionrecords','revenue','double precision'),
	 ('storehub_mongo','transactionrecords','roundedamount','double precision'),
	 ('storehub_mongo','transactionrecords','saleschannel','double precision'),
	 ('storehub_mongo','transactionrecords','seniordiscount','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','seniorscount','double precision'),
	 ('storehub_mongo','transactionrecords','seqnumbercreatedtime','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','sequencenumber','double precision'),
	 ('storehub_mongo','transactionrecords','servedtime','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords','servicecharge','numeric'),
	 ('storehub_mongo','transactionrecords','servicechargerate','double precision'),
	 ('storehub_mongo','transactionrecords','servicechargetax','double precision'),
	 ('storehub_mongo','transactionrecords','sessionid','character varying'),
	 ('storehub_mongo','transactionrecords','shippingfee','numeric'),
	 ('storehub_mongo','transactionrecords','shippingfeediscount','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','shippingtype','character varying'),
	 ('storehub_mongo','transactionrecords','smallorderfee','double precision'),
	 ('storehub_mongo','transactionrecords','smallorderfeetax','double precision'),
	 ('storehub_mongo','transactionrecords','status','character varying'),
	 ('storehub_mongo','transactionrecords','storeid','character varying'),
	 ('storehub_mongo','transactionrecords','subtotal','numeric'),
	 ('storehub_mongo','transactionrecords','subtotaltax','double precision'),
	 ('storehub_mongo','transactionrecords','tableid','character varying'),
	 ('storehub_mongo','transactionrecords','takeawaycharges','double precision'),
	 ('storehub_mongo','transactionrecords','tax','numeric');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','taxablesales','double precision'),
	 ('storehub_mongo','transactionrecords','taxexemptedsales','double precision'),
	 ('storehub_mongo','transactionrecords','total','numeric'),
	 ('storehub_mongo','transactionrecords','totaldeductedtax','double precision'),
	 ('storehub_mongo','transactionrecords','transactionid','character varying'),
	 ('storehub_mongo','transactionrecords','transactiontype','character varying'),
	 ('storehub_mongo','transactionrecords','urltype','character varying'),
	 ('storehub_mongo','transactionrecords','version','double precision'),
	 ('storehub_mongo','transactionrecords','voidnumber','character varying'),
	 ('storehub_mongo','transactionrecords','voidseqnumber','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords','vouchervaliddays','double precision'),
	 ('storehub_mongo','transactionrecords','zeroratedsales','double precision');

-- Table: transactionrecords__items__selectedoptions (956,891,680 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items__selectedoptions','_id','character varying'),
	 ('storehub_mongo','transactionrecords__items__selectedoptions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__items__selectedoptions','optionid','character varying'),
	 ('storehub_mongo','transactionrecords__items__selectedoptions','optionvalue','character varying'),
	 ('storehub_mongo','transactionrecords__items__selectedoptions','quantity','double precision'),
	 ('storehub_mongo','transactionrecords__items__selectedoptions','transactionrecords__items_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__items__selectedoptions','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__items__selectedoptions','variationid','character varying');

-- Table: transactionrecords__items__componentsusages (72,349,548 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items__componentsusages','_id','character varying'),
	 ('storehub_mongo','transactionrecords__items__componentsusages','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__items__componentsusages','lockeddate','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__items__componentsusages','lockedquantity','double precision'),
	 ('storehub_mongo','transactionrecords__items__componentsusages','productid','character varying'),
	 ('storehub_mongo','transactionrecords__items__componentsusages','quantity','double precision'),
	 ('storehub_mongo','transactionrecords__items__componentsusages','transactionrecords__items_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__items__componentsusages','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords__items__productinfo (66,696,215 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items__productinfo','_id','character varying'),
	 ('storehub_mongo','transactionrecords__items__productinfo','category','character varying'),
	 ('storehub_mongo','transactionrecords__items__productinfo','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__items__productinfo','displayprice','double precision'),
	 ('storehub_mongo','transactionrecords__items__productinfo','image','character varying'),
	 ('storehub_mongo','transactionrecords__items__productinfo','inventorytype','character varying'),
	 ('storehub_mongo','transactionrecords__items__productinfo','isamusementtax','boolean'),
	 ('storehub_mongo','transactionrecords__items__productinfo','ishalal','boolean'),
	 ('storehub_mongo','transactionrecords__items__productinfo','isvatexempted','boolean'),
	 ('storehub_mongo','transactionrecords__items__productinfo','originaldisplayprice','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items__productinfo','originimage','character varying'),
	 ('storehub_mongo','transactionrecords__items__productinfo','productid','character varying'),
	 ('storehub_mongo','transactionrecords__items__productinfo','productparentid','character varying'),
	 ('storehub_mongo','transactionrecords__items__productinfo','tags','character varying'),
	 ('storehub_mongo','transactionrecords__items__productinfo','taxcode','character varying'),
	 ('storehub_mongo','transactionrecords__items__productinfo','taxrate','double precision'),
	 ('storehub_mongo','transactionrecords__items__productinfo','title','character varying'),
	 ('storehub_mongo','transactionrecords__items__productinfo','trackinventory','boolean'),
	 ('storehub_mongo','transactionrecords__items__productinfo','transactionrecords__items_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__items__productinfo','transactionrecords_foreignkey','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items__productinfo','unitprice','double precision');

-- Table: transactionrecords__location (42,716,363 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__location','_id','character varying'),
	 ('storehub_mongo','transactionrecords__location','coordinates','character varying'),
	 ('storehub_mongo','transactionrecords__location','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__location','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__location','type','character varying');

-- Table: transactionrecords__items__promotions (30,836,822 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items__promotions','_id','character varying'),
	 ('storehub_mongo','transactionrecords__items__promotions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__items__promotions','discount','numeric'),
	 ('storehub_mongo','transactionrecords__items__promotions','discounttype','character varying'),
	 ('storehub_mongo','transactionrecords__items__promotions','originaldiscounttype','character varying'),
	 ('storehub_mongo','transactionrecords__items__promotions','promotioncode','character varying'),
	 ('storehub_mongo','transactionrecords__items__promotions','promotionid','character varying'),
	 ('storehub_mongo','transactionrecords__items__promotions','promotionname','character varying'),
	 ('storehub_mongo','transactionrecords__items__promotions','promotiontype','character varying'),
	 ('storehub_mongo','transactionrecords__items__promotions','pwddiscount','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items__promotions','quantity','double precision'),
	 ('storehub_mongo','transactionrecords__items__promotions','seniordiscount','double precision'),
	 ('storehub_mongo','transactionrecords__items__promotions','shippingfeediscount','double precision'),
	 ('storehub_mongo','transactionrecords__items__promotions','storehubpaidpercentage','double precision'),
	 ('storehub_mongo','transactionrecords__items__promotions','tax','numeric'),
	 ('storehub_mongo','transactionrecords__items__promotions','taxableamount','double precision'),
	 ('storehub_mongo','transactionrecords__items__promotions','taxcode','character varying'),
	 ('storehub_mongo','transactionrecords__items__promotions','taxexemptamount','double precision'),
	 ('storehub_mongo','transactionrecords__items__promotions','transactionrecords__items_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__items__promotions','transactionrecords_foreignkey','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__items__promotions','uniquepromotioncode','character varying'),
	 ('storehub_mongo','transactionrecords__items__promotions','uniquepromotioncodeid','character varying');

-- Table: transactionrecords__contactdetail (22,804,306 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__contactdetail','_id','character varying'),
	 ('storehub_mongo','transactionrecords__contactdetail','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__contactdetail','email','character varying'),
	 ('storehub_mongo','transactionrecords__contactdetail','info','character varying'),
	 ('storehub_mongo','transactionrecords__contactdetail','name','character varying'),
	 ('storehub_mongo','transactionrecords__contactdetail','phone','character varying'),
	 ('storehub_mongo','transactionrecords__contactdetail','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords__suborders (13,576,743 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__suborders','_id','character varying'),
	 ('storehub_mongo','transactionrecords__suborders','comments','character varying'),
	 ('storehub_mongo','transactionrecords__suborders','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__suborders','isprinted','boolean'),
	 ('storehub_mongo','transactionrecords__suborders','printedtime','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__suborders','submitid','character varying'),
	 ('storehub_mongo','transactionrecords__suborders','submittedby','character varying'),
	 ('storehub_mongo','transactionrecords__suborders','submittedbyphone','character varying'),
	 ('storehub_mongo','transactionrecords__suborders','submittedfrom','character varying'),
	 ('storehub_mongo','transactionrecords__suborders','submittedtime','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__suborders','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords__promotions (12,139,704 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__promotions','_id','character varying'),
	 ('storehub_mongo','transactionrecords__promotions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__promotions','discount','numeric'),
	 ('storehub_mongo','transactionrecords__promotions','discounttype','character varying'),
	 ('storehub_mongo','transactionrecords__promotions','originaldiscounttype','character varying'),
	 ('storehub_mongo','transactionrecords__promotions','promotioncode','character varying'),
	 ('storehub_mongo','transactionrecords__promotions','promotionid','character varying'),
	 ('storehub_mongo','transactionrecords__promotions','promotionname','character varying'),
	 ('storehub_mongo','transactionrecords__promotions','promotiontype','character varying'),
	 ('storehub_mongo','transactionrecords__promotions','pwddiscount','double precision');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__promotions','quantity','double precision'),
	 ('storehub_mongo','transactionrecords__promotions','seniordiscount','double precision'),
	 ('storehub_mongo','transactionrecords__promotions','shippingfeediscount','double precision'),
	 ('storehub_mongo','transactionrecords__promotions','storehubpaidpercentage','double precision'),
	 ('storehub_mongo','transactionrecords__promotions','tax','numeric'),
	 ('storehub_mongo','transactionrecords__promotions','taxableamount','double precision'),
	 ('storehub_mongo','transactionrecords__promotions','taxcode','character varying'),
	 ('storehub_mongo','transactionrecords__promotions','taxexemptamount','double precision'),
	 ('storehub_mongo','transactionrecords__promotions','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__promotions','uniquepromotioncode','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__promotions','uniquepromotioncodeid','character varying');

-- Table: transactionrecords__loyaltydiscounts (8,004,277 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__loyaltydiscounts','_id','character varying'),
	 ('storehub_mongo','transactionrecords__loyaltydiscounts','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__loyaltydiscounts','discountedtax','double precision'),
	 ('storehub_mongo','transactionrecords__loyaltydiscounts','displaydiscount','double precision'),
	 ('storehub_mongo','transactionrecords__loyaltydiscounts','loyaltytype','character varying'),
	 ('storehub_mongo','transactionrecords__loyaltydiscounts','spentvalue','double precision'),
	 ('storehub_mongo','transactionrecords__loyaltydiscounts','taxrate','double precision'),
	 ('storehub_mongo','transactionrecords__loyaltydiscounts','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords__deliveryinformation (6,578,078 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__deliveryinformation','_id','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','bestlastmileeta','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','comments','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','courier','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','deliverydistance','double precision'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','deliverydistanceunit','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','deliveryfee','double precision'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','driverphone','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','jobid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__deliveryinformation','ridetypemerchantsetup','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','shippingfee','numeric'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','trackingid','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','trackingurl','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','usestorehublogistics','boolean'),
	 ('storehub_mongo','transactionrecords__deliveryinformation','worstlastmileeta','timestamp without time zone');

-- Table: transactionrecords__deliveryinformation__address (6,578,025 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','_id','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','address','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','addressdetails','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','addressid','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','city','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','companyname','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','country','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','createdtime','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','deliveryto','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','name','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','phone','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','postcode','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','state','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','transactionrecords__deliveryinformation_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address','updatedtime','timestamp without time zone');

-- Table: transactionrecords__deliveryinformation__deliverymethodinfo (2,979,587 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','_id','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','deliverymethodid','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','deliverymethodname','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','isfree','boolean'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','maxshippingtime','double precision'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','minshippingtime','double precision'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','rate','double precision'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','shippingtimeunit','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','shippingzoneid','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','shippingzonename','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','transactionrecords__deliveryinformation_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__deliverymethodinfo','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords__deliveryinformation__address__location (2,634,226 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__deliveryinformation__address__location','_id','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address__location','coordinates','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address__location','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address__location','transactionrecords__deliveryinformation__address_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address__location','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__deliveryinformation__address__location','type','character varying');

-- Table: transactionrecords__fromlocation (2,554,263 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__fromlocation','_id','character varying'),
	 ('storehub_mongo','transactionrecords__fromlocation','coordinates','character varying'),
	 ('storehub_mongo','transactionrecords__fromlocation','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__fromlocation','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__fromlocation','type','character varying');

-- Table: transactionrecords__returnprocess (2,506,561 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__returnprocess','_id','character varying'),
	 ('storehub_mongo','transactionrecords__returnprocess','actionrequired','boolean'),
	 ('storehub_mongo','transactionrecords__returnprocess','comment','character varying'),
	 ('storehub_mongo','transactionrecords__returnprocess','completedtime','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__returnprocess','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__returnprocess','failedtoupdateinventory','boolean'),
	 ('storehub_mongo','transactionrecords__returnprocess','inventoryaction','character varying'),
	 ('storehub_mongo','transactionrecords__returnprocess','productid','character varying'),
	 ('storehub_mongo','transactionrecords__returnprocess','skunumber','character varying'),
	 ('storehub_mongo','transactionrecords__returnprocess','sn','character varying');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__returnprocess','title','character varying'),
	 ('storehub_mongo','transactionrecords__returnprocess','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords__pickupinformation__store__qrorderingsettings__vacations (891,916 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings__vacations','_id','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings__vacations','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings__vacations','transactionrecords__pickupinformation__store__qrorderingsettings_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings__vacations','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings__vacations','vacationtimefrom','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings__vacations','vacationtimeto','character varying');

-- Table: transactionrecords__payments__manualapproveinfo (835,889 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__payments__manualapproveinfo','_id','character varying'),
	 ('storehub_mongo','transactionrecords__payments__manualapproveinfo','approvedate','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__payments__manualapproveinfo','approver','character varying'),
	 ('storehub_mongo','transactionrecords__payments__manualapproveinfo','approvereason','character varying'),
	 ('storehub_mongo','transactionrecords__payments__manualapproveinfo','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__payments__manualapproveinfo','transactionrecords__payments_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__payments__manualapproveinfo','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords__pickupinformation (829,856 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__pickupinformation','_id','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__pickupinformation','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords__pickupinformation__store__pickupaddress__addresscomponents (760,012 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress__addresscomponents','_id','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress__addresscomponents','city','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress__addresscomponents','country','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress__addresscomponents','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress__addresscomponents','state','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress__addresscomponents','street1','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress__addresscomponents','street2','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress__addresscomponents','transactionrecords__pickupinformation__store__pickupaddress_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress__addresscomponents','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords__pickupinformation__store__pickupaddress (759,993 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress','_id','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress','coordinate','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress','googlemapsplaceid','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress','googlemapsurl','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress','location','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress','placename','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress','transactionrecords__pickupinformation__store_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__pickupaddress','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords__pickupinformation__store__location (738,555 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__pickupinformation__store__location','_id','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__location','coordinates','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__location','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__location','transactionrecords__pickupinformation__store_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__location','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__location','type','character varying');

-- Table: transactionrecords__pickupinformation__store__qrorderingsettings (714,331 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','_id','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','breaktimefrom','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','breaktimeto','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','disableondemandorder','boolean'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','disabletodaypreorder','boolean'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','enablepertimeslotlimitforpreorder','boolean'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','enablepreorder','boolean'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','enableselfpickupalert','boolean'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','firstenablepreorderdeliverydate','timestamp without time zone');
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','maxpreorderspertimeslot','double precision'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','pausemodesettings.endingat','double precision'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','pausemodesettings.shippingtypes','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','transactionrecords__pickupinformation__store_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','validdays','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','validtimefrom','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__qrorderingsettings','validtimeto','character varying');

-- Table: transactionrecords__returnprocess__selectedoptions (167,197 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__returnprocess__selectedoptions','_id','character varying'),
	 ('storehub_mongo','transactionrecords__returnprocess__selectedoptions','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__returnprocess__selectedoptions','optionid','character varying'),
	 ('storehub_mongo','transactionrecords__returnprocess__selectedoptions','optionvalue','character varying'),
	 ('storehub_mongo','transactionrecords__returnprocess__selectedoptions','quantity','double precision'),
	 ('storehub_mongo','transactionrecords__returnprocess__selectedoptions','transactionrecords__returnprocess_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__returnprocess__selectedoptions','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__returnprocess__selectedoptions','variationid','character varying');

-- Table: transactionrecords__appliedvoucher (25,133 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__appliedvoucher','_id','character varying'),
	 ('storehub_mongo','transactionrecords__appliedvoucher','cost','numeric'),
	 ('storehub_mongo','transactionrecords__appliedvoucher','coveredbysh','boolean'),
	 ('storehub_mongo','transactionrecords__appliedvoucher','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__appliedvoucher','purchasechannel','character varying'),
	 ('storehub_mongo','transactionrecords__appliedvoucher','transactionrecords_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__appliedvoucher','value','double precision'),
	 ('storehub_mongo','transactionrecords__appliedvoucher','vouchercode','character varying'),
	 ('storehub_mongo','transactionrecords__appliedvoucher','voucherid','character varying');

-- Table: transactionrecords__review (949 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__review','_id','character varying'),
	 ('storehub_mongo','transactionrecords__review','allowmerchantcontact','boolean'),
	 ('storehub_mongo','transactionrecords__review','comments','character varying'),
	 ('storehub_mongo','transactionrecords__review','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__review','rating','double precision'),
	 ('storehub_mongo','transactionrecords__review','transactionrecords_foreignkey','character varying');

-- Table: transactionrecords__pickupinformation__store__reviewinfo (240 rows)
INSERT INTO svv_columns (table_schema,table_name,column_name,data_type) VALUES
	 ('storehub_mongo','transactionrecords__pickupinformation__store__reviewinfo','_id','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__reviewinfo','data_modified_time','timestamp without time zone'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__reviewinfo','rating','double precision'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__reviewinfo','ratingcount','double precision'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__reviewinfo','transactionrecords__pickupinformation__store_foreignkey','character varying'),
	 ('storehub_mongo','transactionrecords__pickupinformation__store__reviewinfo','transactionrecords_foreignkey','character varying');


-- =====================================================
-- METADATA AND STATISTICS
-- =====================================================

-- Summary Statistics:
-- Total Tables: 172
-- Total Columns: 2,547
-- Total Rows: 6,212,891,851

-- Key Relationships:
-- Primary Keys: All tables use '_id' as primary key (MongoDB convention)
-- Foreign Keys: Identified by '_foreignkey' suffix or common patterns:
--   - business/businessid -> businesses._id
--   - customerid -> customers._id
--   - productid -> products._id
--   - transactionid/receiptnumber -> transactionrecords.receiptnumber
--   - storeid -> businesses__stores._id

-- Top 10 Largest Tables:
--   1. transactionrecords__items: 2,434,587,238 rows
--   2. transactionrecords__payments: 984,792,794 rows
--   3. transactionrecords: 971,611,229 rows
--   4. transactionrecords__items__selectedoptions: 956,891,680 rows
--   5. paymentrecordlogs: 72,977,328 rows
--   6. transactionrecords__items__componentsusages: 72,349,548 rows
--   7. transactionrecords__items__productinfo: 66,696,215 rows
--   8. useractionlogs: 60,089,080 rows
--   9. inventories: 58,541,689 rows
--   10. loyaltychangelogs: 54,576,038 rows

