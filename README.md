# Scripts for the SAP BTP CLI

Before running any script make sure to have the [SAP BTP CLI](https://help.sap.com/docs/btp/sap-business-technology-platform/download-and-start-using-btp-cli-client) installed. If you need to install to BAS you can follow this steps:

```
cd /tmp
curl -LJO https://tools.hana.ondemand.com/additional/btp-cli-linux-amd64-latest.tar.gz --cookie "eula_3_2_agreed=tools.hana.ondemand.com/developer-license-3_2.txt"
tar -xvf btp-cli-linux-amd64-latest.tar.gz
mv linux-amd64/btp /home/user/.asdf/bin
```

and you did a login with:

```
btp login --sso
```

If you already logged in, you can check your current target with:

```
btp
```

If you want to change your target, you can do it with:

```
btp target
```
