<cfoutput><!doctype html>

	<title>Lucee on Jetty</title>

	<h1>Congratulations, you are running Lucee on Jetty.</h1>

	<p>Lucee Version: <var>#Server.Lucee.Version#</var>
	<p>Jetty Version: <var>#ListRest(Server.Servlet.Name,'/')#</var>

	<p>This file is located at <var>#HtmlEditFormat(getCurrentTemplatePath())#</var>

	<h2>Local Links</h2>
	<p>Server Admin: <a href="#cgi.context_path#/lucee/admin/server.cfm">/lucee/admin/server.cfm</a>
	<p>Web Admin: <a href="#cgi.context_path#/lucee/admin/web.cfm">/lucee/admin/web.cfm</a>
	<p>Built-in documentation: <a href="#cgi.context_path#/lucee/doc.cfm">/lucee/doc.cfm</a>

	<h2>Online Links</h2>
	<p>Website: <a href="http://lucee.org">//lucee.org</a>
	<p>Online documentation: <a href="https://bitbucket.org/lucee/lucee/wiki/Home">//bitbucket.org/lucee/lucee/wiki/Home</a>

</cfoutput>