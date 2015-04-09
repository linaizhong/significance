<%@ page import="grails.converters.JSON" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search | Atlas of Living Australia</title>
    <meta name="layout" content="ala2"/>
    <link rel="stylesheet" type="text/css" media="screen" href="${resource(dir:'css',file:'expert.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/smoothness',file:'jquery-ui-1.8.19.custom.css')}" type="text/css" media="screen"/>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&libraries=drawing"></script>
    <r:require modules="jquery, jqueryui, tooltipster, application, bootstrap"/>
    <r:layoutResources />
</head>
<body class="admin">
<div class="nav" role="navigation">
    <ul>
        <li><g:link class="create" action="create">Create New Group</g:link></li>
    </ul>
</div>
<script>
    var serverUrl = "${grailsApplication.config.grails.serverURL}";

    $(document).ready( function () {
        $('#site-header .inner').css("padding-top", "0px");
    });
</script>
</body>
</html>