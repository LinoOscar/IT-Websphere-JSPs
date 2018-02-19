<%--
  Document : sn3Xslt.jsp
  Created on : 2015
  Author : Er Lino
  Utilidad: Transformar
   
 --%>
 
<%@page contentType="text/html; charset=ISO-8859-1"%>

<%@ page import="java.io.BufferedInputStream" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.OutputStreamWriter" %>
<%@ page import="java.io.Reader" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<%@ page import="javax.xml.transform.Result" %>
<%@ page import="javax.xml.transform.Source" %>
<%@ page import="javax.xml.transform.Templates" %>
<%@ page import="javax.xml.transform.Transformer" %>
<%@ page import="javax.xml.transform.TransformerFactory" %>
<%@ page import="javax.xml.transform.sax.SAXResult" %>
<%@ page import="javax.xml.transform.stream.StreamResult" %>
<%@ page import="javax.xml.transform.stream.StreamSource" %>
<%@ page import="org.apache.xalan.processor.TransformerFactoryImpl" %>
<%@ page import="org.apache.xalan.processor.TransformerFactoryImpl" %>
<%@ page import="org.apache.log4j.ConsoleAppender" %>
<%@ page import="org.apache.log4j.Level" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="org.apache.log4j.PatternLayout" %>
<%@ page import="org.apache.log4j.RollingFileAppender" %>
<%@ page import="com.isb.rigel.common.util.StreamUtil" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLClassLoader" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.nio.charset.Charset" %>
<%@ page import="java.lang.Runtime" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="javax.xml.parsers.ParserConfigurationException" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.xml.sax.InputSource" %>
<%@ page import="org.xml.sax.SAXException" %>
<%@ page import="java.io.StringReader" %>




<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	
<title>SN3 XSLT</title>


	
<style type="text/css"> 
body {
	font: normal .8em/1.5em Arial, Helvetica, sans-serif;
	background: #ebebeb;
	width: 100%;
	margin: 0px auto;
	color: #666;
}
a {
	color: #333;
}
#nav {
	margin: 0;
	padding: 7px 6px 0;
	line-height: 100%;
	border-radius: 2em;
 
	-webkit-border-radius: 2em;
	-moz-border-radius: 2em;
	
	-webkit-box-shadow: 0 1px 3px rgba(0, 0, 0, .4);
	-moz-box-shadow: 0 1px 3px rgba(0, 0, 0, .4);
 
	background: #8b8b8b; /* for non-css3 browsers */
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#a9a9a9', endColorstr='#7a7a7a'); /* for IE */
	background: -webkit-gradient(linear, left top, left bottom, from(#a9a9a9), to(#7a7a7a)); /* for webkit browsers */
	background: -moz-linear-gradient(top,  #a9a9a9,  #7a7a7a); /* for firefox 3.6+ */
 
	border: solid 1px #6d6d6d;
}
#nav li {
	margin: 0 5px;
	padding: 0 0 8px;
	float: left;
	position: relative;
	list-style: none;
}
/* main level link */
#nav a {
	font-weight: bold;
	color: #e7e5e5;
	text-decoration: none;
	display: block;
	padding:  8px 20px;
	margin: 0;
	-webkit-border-radius: 1.6em;
	-moz-border-radius: 1.6em;
	text-shadow: 0 1px 1px rgba(0, 0, 0, .3);
}
/* main level link */
#nav select {
	font-weight: bold;
	color: #e7e5e5;
	text-decoration: none;
	display: block;
	padding:  8px 20px;
	margin: 0;
	-webkit-border-radius: 1.6em;
	-moz-border-radius: 1.6em;
	text-shadow: 0 1px 1px rgba(0, 0, 0, .3);
}
/* main level link hover */
#nav .current a, #nav li:hover > a {
	background: #d1d1d1; /* for non-css3 browsers */
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ebebeb', endColorstr='#a1a1a1'); /* for IE */
	background: -webkit-gradient(linear, left top, left bottom, from(#ebebeb), to(#a1a1a1)); /* for webkit browsers */
	background: -moz-linear-gradient(top,  #ebebeb,  #a1a1a1); /* for firefox 3.6+ */
 
	color: #444;
	border-top: solid 1px #f8f8f8;
	-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	-moz-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	text-shadow: 0 1px 0 rgba(255, 255, 255, .8);
}
#nav .currentblue a, #nav li:hover > a {
	background: #d1d1d1; /* for non-css3 browsers */
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ebebeb', endColorstr='#a1a1a1'); /* for IE */
	background: -webkit-gradient(linear, left top, left bottom, from(#ebebeb), to(#a1a1a1)); /* for webkit browsers */
	background: -moz-linear-gradient(top,  #ebebeb,  #a1a1a1); /* for firefox 3.6+ */
 
	color: #44f;
	border-top: solid 1px #f8f8f8;
	-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	-moz-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	text-shadow: 0 1px 0 rgba(255, 255, 255, .8);
}
/* sub levels link hover */
#nav ul li:hover a, #nav li:hover li a {
	background: none;
	border: none;
	color: #666;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
}
#nav ul a:hover {
	background: #0399d4 !important; /* for non-css3 browsers */
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#04acec', endColorstr='#0186ba'); /* for IE */
	background: -webkit-gradient(linear, left top, left bottom, from(#04acec), to(#0186ba)) !important; /* for webkit browsers */
	background: -moz-linear-gradient(top,  #04acec,  #0186ba) !important; /* for firefox 3.6+ */
 
	color: #fff !important;
	-webkit-border-radius: 0;
	-moz-border-radius: 0;
	text-shadow: 0 1px 1px rgba(0, 0, 0, .1);
}
/* level 2 list */
#nav ul {
	background: #ddd; /* for non-css3 browsers */
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#cfcfcf'); /* for IE */
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#cfcfcf)); /* for webkit browsers */
	background: -moz-linear-gradient(top,  #fff,  #cfcfcf); /* for firefox 3.6+ */
 
	display: none;
	margin: 0;
	padding: 0;
	width: 185px;
	position: absolute;
	top: 35px;
	left: 0;
	border: solid 1px #b4b4b4;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 1px 3px rgba(0, 0, 0, .3);
	-moz-box-shadow: 0 1px 3px rgba(0, 0, 0, .3);
	box-shadow: 0 1px 3px rgba(0, 0, 0, .3);
}
/* dropdown */
#nav li:hover > ul {
	display: block;
}
#nav ul li {
	float: none;
	margin: 0;
	padding: 0;
}
#nav ul a {
	font-weight: normal;
	text-shadow: 0 1px 1px rgba(255, 255, 255, .9);
}
/* level 3+ list */
#nav ul ul {
	left: 181px;
	top: -3px;
}
/* rounded corners for first and last child */
#nav ul li:first-child > a {
	-webkit-border-top-left-radius: 9px;
	-moz-border-radius-topleft: 9px;
	-webkit-border-top-right-radius: 9px;
	-moz-border-radius-topright: 9px;
}
#nav ul li:last-child > a {
	-webkit-border-bottom-left-radius: 9px;
	-moz-border-radius-bottomleft: 9px;
	-webkit-border-bottom-right-radius: 9px;
	-moz-border-radius-bottomright: 9px;
}
/* clearfix */
#nav:after {
	content: ".";
	display: block;
	clear: both;
	visibility: hidden;
	line-height: 0;
	height: 0;
}
#nav {
	display: inline-block;
}
html[xmlns] #nav {
	display: block;
}
* html #nav {
	height: 1%;
}
</style>
<script>
function ejecutar(descargar){

	 var form = document.createElement("form");
	 form.setAttribute("method", "POST");
	
	 var hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "xmlInput");
	  hiddenField.setAttribute("value", this.xmlInput.value);
	  form.appendChild(hiddenField);
	  
	   hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "urlXmlInput");
	  hiddenField.setAttribute("value", this.urlXmlInput.value);
	  form.appendChild(hiddenField);	  
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "xsltInput");
	  hiddenField.setAttribute("value", this.xsltInput.value);
	  form.appendChild(hiddenField);
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "urlXsltInput");
	  hiddenField.setAttribute("value", this.urlXsltInput.value);
	  form.appendChild(hiddenField);	
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "saxParserFactory");
	  hiddenField.setAttribute("value", this.saxParserFactory.value);
	  form.appendChild(hiddenField);	  
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "transformerFactory");
	  hiddenField.setAttribute("value", this.transformerFactory.value);
	  form.appendChild(hiddenField);		
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "charsetXml");
	  hiddenField.setAttribute("value", this.charsetXml.value);
	  form.appendChild(hiddenField);	  
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "charsetXslt");
	  hiddenField.setAttribute("value", this.charsetXslt.value);
	  form.appendChild(hiddenField);	
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "urlXmlOutput");
	  hiddenField.setAttribute("value", this.urlXmlOutput.value);
	  form.appendChild(hiddenField);	

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "download");
	  hiddenField.setAttribute("value", descargar);
	  form.appendChild(hiddenField);	  
	  
      document.body.appendChild(form);
      form.submit();	
}
</script>
</head>

<body>


<%

	String download = (String) request.getParameter("download");if (download == null) download = "N";	
	String urlXmlOutput = (String) request.getParameter("urlXmlOutput");if (urlXmlOutput == null) urlXmlOutput = "";			

    if (download.equals("S"))
	{
		%><script>alert("In a galaxy far far away...")</script><%
	}

	 
    InetAddress host = null;
    host = InetAddress.getLocalHost();
    String nombreHost=host.getHostName();


	%><h3>XSLT GENERATOR SN3 - CLON <%=nombreHost%> </h3><%
	
	System.setProperty("javax.xml.parsers.SAXParserFactory","org.apache.xerces.jaxp.SAXParserFactoryImpl");
    String currentTransformerFactory = System.getProperty("javax.xml.transform.TransformerFactory");
	System.out.println("currentTransformerFactory es [" + currentTransformerFactory + "]");
	String currentSaxParserFactory = System.getProperty("javax.xml.parsers.SAXParserFactory");
	System.out.println("currentSaxParserFactory es [" + currentSaxParserFactory + "]");
	
	 if (currentTransformerFactory==null) currentTransformerFactory = "(default-property not exists)";
	 if (currentSaxParserFactory==null) currentSaxParserFactory = "(default-property not exists)";
	


	String xmlInput = (String) request.getParameter("xmlInput");if (xmlInput == null) xmlInput = "";	
	String urlXmlInput = (String) request.getParameter("urlXmlInput");if (urlXmlInput == null) urlXmlInput = "";
	String charsetXml = (String) request.getParameter("charsetXml");if (charsetXml == null) charsetXml = "UTF-8";		
	String xsltInput = (String) request.getParameter("xsltInput");if (xsltInput == null) xsltInput = "";
	String urlXsltInput = (String) request.getParameter("urlXsltInput");if (urlXsltInput == null) urlXsltInput = "";
	String charsetXslt = (String) request.getParameter("charsetXslt");if (charsetXslt == null) charsetXslt = "UTF-8";	
	String saxParserFactory = (String) request.getParameter("saxParserFactory");if (saxParserFactory == null) saxParserFactory = currentSaxParserFactory;
	String transformerFactory = (String) request.getParameter("transformerFactory");if (transformerFactory == null) transformerFactory = currentTransformerFactory;
	%>
	<h5>IN XML -->  <textarea id="xmlInput" rows="10" cols="70"><%=xmlInput%></textarea></h5>
	<h5>...OR IN XML PATH -->  <input type="text" size="80" name="urlXmlInput" value="<%=urlXmlInput%>"></input>  CHARSET XML-->  <input type="text" size="30" name="charsetXml" value="<%=charsetXml%>"></input></h5>
	<h5>IN XSLT -->  <textarea id="xsltInput" rows="10" cols="70"><%=xsltInput%></textarea></h5>
	<h5>...OR IN XSLT PATH -->  <input type="text" size="80" name="urlXsltInput" value="<%=urlXsltInput%>"></input>  CHARSET XSLT -->  <input type="text" size="30" name="charsetXslt" value="<%=charsetXslt%>"></input></h5>
	
	<h5 style="color:red">&#8595&#8595&#8595&#8595&#8595 THIS PROPERTIES CHANGE ALL MACHINE BEHAVIOR; REMEMBER TO LEAVE CORRECT VALUES WHEN YOUR TESTS ENDED &#8595&#8595&#8595&#8595&#8595</h5>
	<h5>SAX PARSER FACTORY --> <select name="saxParserFactory"><option value="(default-property not exists)" <% if (saxParserFactory.equals("(default-property not exists)")) {%>  selected="selected"   <%}%>>(default-property not exists)</option>
															   <option value="org.apache.xerces.jaxp.SAXParserFactoryImpl" <% if (saxParserFactory.equals("org.apache.xerces.jaxp.SAXParserFactoryImpl")) {%>  selected="selected"   <%}%>>org.apache.xerces.jaxp.SAXParserFactoryImpl</option>
															   <option value="org.apache.xerces.jaxp.SAXParserFactoryImpl" <% if (saxParserFactory.equals("org.apache.xerces.jaxp.SAXParserFactoryImpl")) {%>  selected="selected"   <%}%>>org.apache.xerces.jaxp.SAXParserFactoryImpl</option>															   
															   </select></h5>
	<h5>TRANSFORMER FACTORY --> <select name="transformerFactory"><option value="(default-property not exists)" <% if (transformerFactory.equals("(default-property not exists)")) {%>  selected="selected"   <%}%>>(default-property not exists)</option>
																  <option value="org.apache.xalan.xsltc.trax.TransformerFactoryImpl" <% if (transformerFactory.equals("org.apache.xalan.xsltc.trax.TransformerFactoryImpl")) {%>  selected="selected"   <%}%>>org.apache.xalan.xsltc.trax.TransformerFactoryImpl</option>
																  <option value="org.apache.xalan.processor.TransformerFactoryImpl" <% if (transformerFactory.equals("org.apache.xalan.processor.TransformerFactoryImpl")) {%>  selected="selected"   <%}%>>org.apache.xalan.processor.TransformerFactoryImpl</option>
																  <option value="com.ibm.xtq.xslt.jaxp.compiler.TransformerFactoryImpl" <% if (transformerFactory.equals("com.ibm.xtq.xslt.jaxp.compiler.TransformerFactoryImpl")) {%>  selected="selected"   <%}%>>com.ibm.xtq.xslt.jaxp.compiler.TransformerFactoryImpl</option>
																  <option value="com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl" <% if (transformerFactory.equals("com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl")) {%>  selected="selected"   <%}%>>com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl</option>																																
																  </select></h5>
	<h5 style="color:red">&#8593&#8593&#8593&#8593&#8593 THIS PROPERTIES CHANGE ALL MACHINE BEHAVIOR; REMEMBER TO LEAVE CORRECT VALUES WHEN YOUR TESTS ENDED &#8593&#8593&#8593&#8593&#8593</h5>
	<h5>OUT XML PATH -->  <input type="text" size="100" name="urlXmlOutput" value="<%=urlXmlOutput%>"></input></h5> 	
	
	<h5><button id="ejecutar" onclick="javascript:ejecutar('N')">Go!</button></h5>
	
	<%
	
	   %><h3>CURRENT TRANSFORMER FACTORY [<%=currentTransformerFactory%>]</h3><%
	   %><h3>CURRENT SAX PARSER FACTORY [<%=currentSaxParserFactory%>]</h3><%
	  
	
	//Cargo xml de entrada
	String xmlsource=null;
	if ((urlXmlInput != null) && (!urlXmlInput.trim().equals("")))
	{
		xmlsource = readFileEncoding(urlXmlInput,charsetXml);
	}
	else if ((xmlInput != null) && (!xmlInput.trim().equals("")))
	{
	    xmlsource = xmlInput;
	}
	else
	{
	   %><h3 style="color:red">[XML IN] OR [XML IN URL] IS NEEDED</h3><%
	}
	
	boolean entrar = false;
	
	if (entrar)
	{
	try
	{
	System.err.println("vamos a ver 2 con [" + xmlsource + "]");
	
	DocumentBuilderFactory m_buildFactory = DocumentBuilderFactory.newInstance();
	m_buildFactory.setExpandEntityReferences(false);
	
	//m_buildFactory.setFeature("http://apache.org/xml/features/disallow-doctype-decl	", true);
	//m_buildFactory.setFeature("http://xml.org/sax/features/external-general-entities", false);
		  
	
	DocumentBuilder myDomBuilder = m_buildFactory.newDocumentBuilder();
	

	
	//Document doc = myDomBuilder.parse(new InputSource(new StringReader(xmlsource)));  
	InputStream in = new FileInputStream("/tmp/AWSServPersonalizacion.wsdl");
		
	Document doc = myDomBuilder.parse(new InputSource(new InputStreamReader(in,"UTF-8")));  	

	System.err.println("acaba bien");	
	}
	catch (Exception e)
	{
	  e.printStackTrace();
	}
	}
	
	
	Templates template2 = null;
	TransformerFactory factory = null;
	Reader rdr = null;
	
	//Cargo xslt de entrada
	if ((urlXsltInput != null) && (!urlXsltInput.trim().equals("")))
	{
	System.out.println("casa");
		//rdr = new InputStreamReader(Thread.currentThread().getContextClassLoader().getResourceAsStream("TOKGBM_ServAdminGBM_LN/activateSignTokenRequest.xslt"), charsetXslt);
		
		rdr = new InputStreamReader(new FileInputStream(urlXsltInput), charsetXslt);
	}
	else if ((xsltInput != null) && (!xsltInput.trim().equals("")))
	{
		InputStream stream = new ByteArrayInputStream(xsltInput.getBytes(charsetXslt));
	    rdr = new InputStreamReader(stream);
	}
	else
	{
	   %><h3 style="color:red">[XSLT IN] OR [XSLT IN URL] IS NEEDED</h3><%
	}	
	
	
	if ((rdr != null) && (xmlsource != null))
	{
	
	try
	{
	  //Cambiamos propiedades si es necesario
	  if (!currentTransformerFactory.equals(transformerFactory))
	  {
	    if (transformerFactory.equals("(default-property not exists)"))  //borramos
		{
		  System.clearProperty("javax.xml.transform.TransformerFactory");
		  %><h3>DELETING TRANSFORMER FACTORY</h3><%
		}
		else //creamos
		{
		  System.setProperty("javax.xml.transform.TransformerFactory",transformerFactory);
		  %><h3>CHANGING TRANSFORMER FACTORY TO [<%=transformerFactory%>]</h3><%
		}
	  }
	  
	  if (!currentSaxParserFactory.equals(saxParserFactory))
	  {
	    if (saxParserFactory.equals("(default-property not exists)"))  //borramos
		{
		  System.clearProperty("javax.xml.parsers.SAXParserFactory");
		  %><h3>DELETING SAXPARSER FACTORY</h3><%
		}
		else //creamos
		{
		  System.setProperty("javax.xml.parsers.SAXParserFactory",saxParserFactory);
		  %><h3>CHANGING TRANSFORMER FACTORY TO [<%=saxParserFactory%>]</h3><%
		}
	  }	  
	  
	try
	{
	factory = TransformerFactory.newInstance();
	}
	catch (Exception e)
	{
	   System.clearProperty("javax.xml.transform.TransformerFactory");
	   %><h3 style="color:red"> INDICATED TRANSFORMER FACTORY FAILS. DELETING CURRENT VALUE...</h3><%
	   factory = TransformerFactory.newInstance();
	}
	
	Source xsl = new StreamSource(rdr);  
	template2 = factory.newTemplates(xsl);
	Transformer transformer = template2.newTransformer();

	byte [] bufferIn = xmlsource.getBytes(charsetXml);
	ByteArrayInputStream  input = new ByteArrayInputStream(bufferIn); 
	Source                inXML = new StreamSource(input);
	ByteArrayOutputStream out2 = new ByteArrayOutputStream();
	
	String encondingXmlOut =  (String)template2.getOutputProperties().get("encoding");
	
	 %><h3>BEGINNING...OUTPUT CHARSET IN XSLT IS EVER UTF-8</h3><%
	 
	 if (encondingXmlOut==null)
	 {
	    %><h3>NO CHARSET IN XSLT. WE WILL USE IN XML [<%=charsetXml%>]</h3><%
		encondingXmlOut=charsetXml;
	 }
	 

	 
	 
	
	transformer.transform(inXML, new StreamResult(out2));
	BufferedInputStream localBufferedInputStream = new BufferedInputStream(new ByteArrayInputStream(out2.toByteArray()));
	
	 OutputStream outData = null;
	 %><h3>WRITING OUT...</h3><%
	 
	 if ((urlXmlOutput != null) && (!urlXmlOutput.trim().equals("")))
	 {
	 outData = new FileOutputStream(urlXmlOutput);
	 StreamUtil.copy(localBufferedInputStream, outData);
	 outData.close();
	 }
	 
	 if ((urlXmlOutput!=null) && (!urlXmlOutput.trim().equals("")))
	 {
	    %><h3>OUTPUT!! (output file path is filled, download &nbsp;<button id="downloadBtn" onclick="javascript:ejecutar('S')">here</button>&nbsp;)</h3><%
	 }
	 else
	 {
	 %><h3>OUTPUT!!</h3><%
	 }
	 %><h3>(visual output charset will be same that used in transform)</h3><%
	 %><h4><textarea id="XML2" rows="10" cols="200"><%=out2.toString(encondingXmlOut)%></textarea></h4><%
	 

	 
	 }
	 catch (Exception e2)
	 {
			e2.printStackTrace();
			%><h3>EXCEPTION!!! (review systemout/systemerr)</h3><%
			StackTraceElement[] elements2 = e2.getStackTrace();
			for(int i=0; i<elements2.length; i++) {
				%><h3><%=elements2[i]%></h3><%
			}  
	 }
	 }
%>

<%!
private String readFileEncoding(String f,String charset)
{
	try {
		return new String(copiarFicheroAMemoria(f),charset);
	} catch (UnsupportedEncodingException e) {
		// TODO Bloque catch generado automáticamente
		e.printStackTrace();
		return null;
	}

}
%>

<%!

private byte[] copiarFicheroAMemoria(String nombreFichero)
  {
	byte[] contenidoDelFichero = null;
	File theFile = new File(nombreFichero);
	FileInputStream theFIS = null;
	BufferedInputStream theBIS = null;
	byte[] buffer = new byte[8 * 1024];
	int leido = 0;
	ByteArrayOutputStream theBOS = new ByteArrayOutputStream();

	try
	{
	  theFIS = new FileInputStream(theFile);
	  theBIS = new BufferedInputStream(theFIS);
	  while ((leido = theBIS.read(buffer)) >= 0)
	  {
		theBOS.write(buffer, 0, leido);
	  }
	  // Fichero leido del todo, pasamos el contenido
	  // del BOS al byte[]
	  contenidoDelFichero = theBOS.toByteArray();
	  // Liberamos y cerramos para ser eficientes
	  theBOS.reset();
	  // Este close no va dentro de un try/catch por que
	  // BOS es un Stream especial y close no hace nada
	  theBOS.close();
	}
	catch (IOException e1)
	{
	  // Error leyendo el fichero así que no tenemos
	  // en memoria el fichero. 
	  e1.printStackTrace();
	}
	finally
	{
	  if (theBIS != null)
	  {
		try
		{
		  theBIS.close();
		}
		catch (IOException e)
		{
		  // Error cerrando stream del fichero
		  e.printStackTrace();
		}
	  }
	}
	return contenidoDelFichero;
  }

%>

</body>
</html>