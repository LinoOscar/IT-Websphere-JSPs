JSPS 4 IT Supports Teams in Websphere Servers (because like you know, "in my computer it rules")
-----------------------------------------------

There are some jsps that can help you in your WAS assemblies that have one servlet up listening jsps.


CC4IT.jsp
-----------

This jsp is a simple lineCommand that try to emulate one OS console. When you have not access to operative system this jsp can help you

ftp4IT.jsp
-----------

For lauch jsps test against your repositories from WAS server and test your conectivity, proxies, etc...
all data is configurable.

log4Admin4IT.jsp
-----------------

For review all log levels in your app, and change it if your mbean configuration allows it.

mbean4IT.jsp
-----------------

Shows all your mbean levels and allow change all configuration in them. Really util if you have a good jmx toolkit in your assemblies.

ws4IT.jsp
-----------------

For make all WebService tries from your WAS app. In this jsp you can:

-> Test your proxy with user/pass , or not
-> Test your encodings
-> Test your SSL certs (if you don't indicate ssl configuration system will use "trustAllCerts" and all will be valid); for me is the best option when i have problems in SSL handshake.
-> Test your SOAP actions.



xslt4IT.jsp
-----------------

For make all your xslt tests in your Websphere Server. You can change your xstl tranformer Factory and your xml parser factory for probe them in all configurations that you really need.








