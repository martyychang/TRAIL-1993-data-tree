# SFDX App

This repo helps to ask a question, "How can a junction object be exported
then imported successfully using the Salesforce DX CLI?"

## Dev, Build and Test

Clone this repo and then execute the commands below to reproduce the error.

```bash
# Create a new scratch org
sfdx force:org:create -f config/project-scratch-def.json -s

# Push source to the new scratch org
sfdx force:source:push

# Create test data in the new scratch org
# using anonymous Apex
sfdx force:apex:execute -f force-apex/setup.apex

# Open the org and poke around
sfdx force:org:open
```

At this point your scratch org will have the following.

* Two sample products
* One new price book
* Entries for the sample products in the new price book
* Entries for the sample products in the standard price book

Then try these `sfdx` commands.

```bash
# Export price book entries
mkdir -p tmp
sfdx force:data:tree:export -q force-data/PricebookEntry.soql -d tmp -p

# Create a new scratch org
sfdx force:org:create -f config/project-scratch-def.json -s

# Push source to the new scratch org
sfdx force:source:push

# Import price book entries
sfdx force:data:tree:import -p tmp/PricebookEntry-plan.json
```

At this point errors like the following will be reported.

```txt
=== PricebookEntryRef1 [2]
STATUSCODE     MESSAGE                                           FIELDS
─────────────  ────────────────────────────────────────────────  ──────
INVALID_FIELD  Cannot reference a foreign key field Pricebook2.
INVALID_FIELD  Cannot reference a foreign key field Product2.
=== PricebookEntryRef2 [2]
STATUSCODE     MESSAGE                                           FIELDS
─────────────  ────────────────────────────────────────────────  ──────
INVALID_FIELD  Cannot reference a foreign key field Pricebook2.
INVALID_FIELD  Cannot reference a foreign key field Product2.
=== PricebookEntryRef3 [2]
STATUSCODE     MESSAGE                                           FIELDS
─────────────  ────────────────────────────────────────────────  ──────
INVALID_FIELD  Cannot reference a foreign key field Pricebook2.
INVALID_FIELD  Cannot reference a foreign key field Product2.
=== PricebookEntryRef4 [2]
STATUSCODE     MESSAGE                                           FIELDS
─────────────  ────────────────────────────────────────────────  ──────
INVALID_FIELD  Cannot reference a foreign key field Pricebook2.
INVALID_FIELD  Cannot reference a foreign key field Product2.
ERROR:  ERROR_HTTP_400.
```

The expected outcome is that new price book entries along with the associated
products and price books are created.

## Resources

* "[data Commands]". _Salesforce CLI Command Reference_.

[1]: https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference_force_data.htm
