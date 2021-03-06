<%@ page import="grails.converters.JSON" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search | Atlas of Living Australia</title>
    <meta name="layout" content="ala2"/>
    <link rel="stylesheet" type="text/css" media="screen" href="${resource(dir:'css',file:'expert.css')}" />
    <link rel="stylesheet" href="${resource(dir:'css/smoothness',file:'jquery-ui-1.8.19.custom.css')}" type="text/css" media="screen"/>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&libraries=drawing"></script>
    <r:require modules="jquery, jqueryui, tooltipster, application"/>
    <r:layoutResources />
</head>
<body class="search">
<header id="page-header">
    <div class="inner" style="margin-top: 16px;">
        <h1>Species of National Environmental Significance</h1><hr style="height: 1px;">
    </div>
</header>
<div class="inner" style="margin-top: -16px;">
    <section id="search">
        <p class="searchInstructions">
            This search application facilitates the retrieving of species information on the Database of Species of National Environmental Significance, which includes:
            <ul style="margin-top: -10px;">
                <li>threatened species</li>
                <li>migratory species</li>
                <li>marine species</li>
                <li>cetaceans</li>
                <li>non-native species that threaten biodiversity</li>
                <li>species in other countries covered by international agreements that Australia is a party to.</li>
            </ul>
        </p>
        <p>
            <nav id="breadcrumb"><ol><li class="last">Search Threatened and Migratory Species</li></ol></nav>
            Select group and location and press the 'Search' button below <%-- or
            use the <span style="padding: 0;" class="toggleAdvanced
            link">advanced search&nbsp;</span><span class="sea">&gt;</span>.<br>
            <span id="advWarning"><r:img uri="/images/skin/warning.png" style="padding-right:4px;"/>Some advanced criteria are hidden.</span> --%>
        </p>
        <g:form action="search" class="searchGroup">
 <%--
            <div class="search-block">
                <g:set var="bathomeTitle" value="Select broad depth category or use advanced search to set custom depth range."/>
                <label for="bathome" class="mainLabel tooltip" title="${bathomeTitle}">Depth</label>
                <g:select name="bathome" class="tooltip" from="${bathomeValues}" title="${bathomeTitle}"
                          value="${criteria.bathome ?: 'coastal/shallow water (0-40m)'}"/>
                <div class="advanced top-pad tooltip" id="advancedDepthSearch" title="Set custom depth range using the sliders or the value boxes.">
                    <span>OR</span>
                    <label style="padding-right: 5px;">Custom depth range (m)</label>
                    Min: <g:textField name="minDepth" class="depthInput" value="${criteria.minDepth}"/>
                    Max: <g:textField name="maxDepth" class="depthInput" value="${criteria.maxDepth}"/>
                    <span id="plusMarker"></span>
                    <div id="depthRangeSlider"></div>
                </div>
            </div>
--%>
<%--
            <div class="search-block">
                <g:set var="groupTitle" value="Commonly recognisable fish ‘groupings’ are included. To search for a specific family or multiple families click on advanced search link above and select from ‘only these families’ pull-down menu, then click ‘+’ button."/>
                <label for="fishGroup" class="mainLabel tooltip" title="${groupTitle}">Fish group</label>
                <g:select name="fishGroup" from="${fishGroups.display}" value="${criteria.fishGroup}" class="tooltip"
                          keys="${fishGroups.keys}" noSelection="['':'All fishes']" title="${groupTitle}"/>
                <div class="advanced top-pad" id="advancedTaxonSearch">
                    <g:set var="ecosystemTitle" value="Restrict search to the selected ecosystem or choose ‘any’ to include all options."/>
                    <label for="ecosystem" title="${ecosystemTitle}" class="tooltip">Primary ecosystem</label>
                    <g:select name="ecosystem" from="['estuarine','coastal','demersal','pelagic']" class="tooltip"
                              noSelection="['':'any']" style="margin-top:0;" title="${ecosystemTitle}"/><br/>
                    <div id="family-widget" class="tooltip" title="Restrict the search to specified families. Type a few letters or select from pulldown menu. Select any number of families but ensure you click the + button after selecting each family to add it to the search list. Remove a family from a completed search by clicking the red X or click the ‘clear’ button below to remove all criteria.">
                        <label for="family">Only these families</label>
                        <g:select title="Type a few letters or pick from list." name="family" class="tooltip" from="${allFamilies}" noSelection="['':'']"/>
                        <button type="button" id="addFamily">
                            <img alt="add selected family" title="Add selected family to search criteria"
                                 src="${resource(dir:'images/skin',file:'plus_icon.gif')}"/></button>
                    </div>
                    <div>
                        <label for="endemic" class="advanced">
                            Only include <abbr class="tooltip" title="Species is not found in any other areas">Endemic</abbr> species
                        </label>
                        <g:checkBox name="endemic" id="endemic" value="${params.endemic}"/>
                    </div>
                    <g:hiddenField name="families"/>
                    <div><ul id="familyList"></ul></div>
                </div>
            </div>
--%>
            <div class="search-block">
                <g:set var="localityTitle" value="If area of interest is not listed, use map tools in advanced search to draw region of interest."/>
                <label for="locality" class="mainLabel tooltip" title="${localityTitle}">Locality</label>
                <select name="locality" id="locality" class="tooltip" title="${localityTitle}"><option value="">any</option></select>
                <div class="top-pad tooltip" title="Choose the radius of the area around the selected locality. You can only adjust slider bar if a locality is selected.">
                    <label for="radiusSlider">Distance from locality</label>
                    <div id="radiusSlider"></div><span id="radiusDisplay">50km</span>
                </div>
                <div class="advanced top-pad" id="advancedRegionSearch">
                    <span>OR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    <!-- Added by Alan on for fetching multiple layers on 30/07/2014 --- START -->
                    <select name="myLayer" id="myLayer" class="tooltip" title="Select a layer">
                        <g:each in="${myLayer}" var="ix">
                            <option value="${ix.pid}" id="${ix.pid}" ${ix.name == criteria.imcra ? "selected='selected'" : ""}>${ix.name}</option>
                        </g:each>
                    </select>
                    <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <!-- Added by Alan Lin --- END -->
                    <g:set var="imcraTitle" value="Restrict your search to the following bioregion selected from the list or choose ‘any’ to include all areas. Bioregion will appear on map when selected."/>
                    <select name="imcra" id="imcra" class="tooltip" title="${imcraTitle}">
                        <option value="">any</option>
                        <g:each in="${imcras}" var="ix">
                            <option value="${ix.name}" id="${ix.pid}" ${ix.name == criteria.imcra ? "selected='selected'" : ""}>${ix.name}</option>
                        </g:each>
                    </select>
                    <br />
                    <span>OR use the tools below the map to draw a region.</span>
                </div>
            </div>
            <g:hiddenField name="radius" value="${criteria.radius ?: 50000}"/>
            <g:hiddenField name="wkt" value="${criteria.wkt}"/>
            <g:hiddenField name="circleLat" value="${criteria.circleLat}"/>
            <g:hiddenField name="circleLon" value="${criteria.circleLon}"/>
            <g:hiddenField name="circleRadius" value="${criteria.circleRadius}"/>
            <g:hiddenField name="imcraPid" value="${criteria.imcraPid}"/>
            <g:hiddenField name="myLayerPid" value="${criteria.myLayerPid}"/>
            <hr>
            <fieldset id="submit-buttons" class='one-line' style="margin-top: -20px;">
                <button type="button" id="searchButton" class="search" title="Search using the selected criteria.">Search</button>
                <img src="${resource(dir:'images',file:'spinner.gif')}" id="waiting" style="visibility:hidden"/>
                <button type="button" id="clearButton" class="clear" title="Clear all search criteria and results.">Clear</button>
            </fieldset>
        </g:form>
        <section id="searchResults" style="display:${summary ? 'block' : 'none'}">
            <h3>Search results</h3>
            <div class="widgets">
                <g:if test="${searchError}">
                    <p class='error'>${searchError}</p>
                </g:if>
                <g:else>
                    <div id="resultsText">
                        <span class="results">Search found <strong id="total">${summary?.total}</strong> species in <strong id="familyCount">${summary?.familyCount}</strong> families.</span>
                        <div id="resultsLinks">
                            <p style="font-weight:bold;padding-bottom:3px;padding-top:3px;">View results by:</p>
                            <a id="familiesLink" href="${grailsApplication.config.explorer.baseUrl}/taxon/view?key=${key}">family list</a>
                            <span class="sea">|</span>
                            <a id="speciesLink" href="${grailsApplication.config.explorer.baseUrl}/taxon/species?key=${key}">species list</a>
                            <span class="sep">|</span>
                            <a id="speciesDataLink" href="${grailsApplication.config.explorer.baseUrl}/taxon/data?key=${key}">species data</a>
                        </div>
                        <p id="queryDescription">For the query: <span id="qDescription">${criteria?.queryDescription}</span>
                            <span style="color:#606060;padding-left:10px;" class="link" id="showQueryToggle">show&nbsp;full&nbsp;query</span>
                        </p>
                        <p id="queryDisplay">(${query})</p>
                    </div>
                </g:else>
            </div>
        </section>

        <div style="margin-top: 20px;">
            <a href="./admin" style="text-decoration: none"><i class="icon-asterisk"></i>Admin</a>
        </div>
    </section>

    <section id="map">
        <div id="map-wrap">
            <div id="map-canvas"></div>
        </div>%{--map-wrap--}%
<%--
        <div id="intro-text">Read more <g:link target="_maps" action="distributionModelling">here</g:link>.</div>
--%>
        <div id="map-controls" style="display: block">
            <ul id="control-buttons">
                <li class="active tooltip" id="pointer" title="Drag to move. Double click or use the zoom control to zoom.">
                    <img src="${resource(dir:'images/map',file:'pointer.png')}" alt="pointer"/>
                    Move & zoom
                </li>
                <li id="circle" class="tooltip" title="Click at centre and drag the desired radius. Values can be adjusted in the boxes.">
                    <img src="${resource(dir:'images/map',file:'circle.png')}" alt="center and radius"/>
                    Draw circle
                </li>
                <li id="rectangle" class="tooltip" title="Click and drag a rectangle.">
                    <img src="${resource(dir:'images/map',file:'rectangle.png')}" alt="rectangle"/>
                    Draw rect
                </li>
                <li id="polygon" class="tooltip" title="Click any number of times to draw a polygon. Double click to close the polygon.">
                    <img src="${resource(dir:'images/map',file:'polygon.png')}" alt="polygon"/>
                    Draw polygon
                </li>
                <li id="clear" class="tooltip" title="Clear the region from the map.">
                    <img src="${resource(dir:'images/map',file:'clear.png')}" alt="clear"/>
                    Clear
                </li>
                <li id="reset" class="tooltip" title="Zoom and centre on Australia.">
                    <img src="${resource(dir:'images/map',file:'reset.png')}" alt="reset map"/>
                    Reset
                </li>
            </ul>
            <div id="drawnArea">
                <div id="circleArea">
                    Circle<br/>
                    <ul>
                        <li><label for="circLat">Lat:</label><input type="text" id="circLat"/></li>
                        <li><label for="circLon">Lon:</label><input type="text" id="circLon"/></li>
                        <li><label for="circRadius">Radius:</label><input type="text" id="circRadius"/></li>
                    </ul>
                    %{--<img id="circRadiusUndo" src="${resource(dir:'images/map',file:'undo.png')}"
                    style="display:none"/>--}%
                </div>
                <div id="rectangleArea">
                    Rectangle<br/>
                    <ul>
                        <li><label for="swLat">SW Lat:</label><input type="text" id="swLat"/></li>
                        <li><label for="swLon">SW Lon:</label><input type="text" id="swLon"/></li>
                        <li><label for="neLat">NE Lat:</label><input type="text" id="neLat"/></li>
                        <li><label for="neLon">NE Lon:</label><input type="text" id="neLon"/></li>
                    </ul>
                </div>
                <div id="polygonArea">
                    Polygon (lat | lon)<br/>
                    <ul>
                        <li><input type="text" id="lat0"/><input type="text" id="lon0"/></li>
                        <li><input type="text" id="lat1"/><input type="text" id="lon1"/></li>
                        <li><input type="text" id="lat2"/><input type="text" id="lon2"/></li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
</div>
<!-- Dialogs -->
<div id="search-confirm" title="Selected family has not been added">
    <p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>
        You have selected a family but have not added it to the search.<br>
        Press the + button next to the family selector to add it to the search criteria.
    </p>
</div>

<script>
    var serverUrl = "${grailsApplication.config.grails.serverURL}";

    $(document).ready( function () {
        $('#site-header .inner').css("padding-top", "2px");

        $('#search-confirm').dialog({
            resizable: false,
            modal: true,
            width: 350,
            autoOpen: false,
            buttons: {
                "Search anyway": function() {
                    $(this).dialog( "close" );
                    search(true);
                },
                Cancel: function() {
                    $(this).dialog( "close" );
                }
            }
        });

        // init some widgets before we try to set their values from stored state
        // set up depth interactions
        customDepth.init();

        // set up locality interactions
        locationWidgets.init(50000, ${tv.toObjectLiteral(obj:localities)});

        // set up family widget
        familyWidget.init();

        // create map and controls
        init_map({
            server: serverUrl,
            spatialService: '${grailsApplication.config.spatial.layers.service.url}',
            spatialWms: '${grailsApplication.config.spatial.wms.url}',
            spatialCache: '${grailsApplication.config.spatial.wms.cache.url}',
            mapContainer: 'map-canvas'
        });

        // this sets the function to call when the user draws a shape
        setCurrentShapeCallback(shapeDrawn);
        // set search criteria and results from any stored data
        if (window.sessionStorage) {
            setPageValues();
        }

        // wire search button
        $('#searchButton').click( function () {
            search();
        });

        // wire clear button
        $('#clearButton').click( function () {
            clearSessionData();
            document.location.href = "${createLink()}";
        });

        // wire show query toggle
        var $queryDisplay = $('#queryDisplay'),
                $queryToggle = $('#showQueryToggle');
        $queryToggle.click(function () {
            if ($queryDisplay.css('display') === 'block') {
                $queryDisplay.css('display','none');
                $queryToggle.html('show&nbsp;full&nbsp;query');
            } else {
                $queryDisplay.css('display','block');
                $queryToggle.html('hide&nbsp;full&nbsp;query');
            }
        });

        // wire simple/advanced toggle and set initial state
        var advanced = window.sessionStorage ? window.sessionStorage.getItem('advancedSearch') : false;
        searchMode.init(advanced);

        //$('.tooltip').tooltipster({maxWidth: 450, delay: 2000});
    });

    function clearData() {
        $('#drawnArea > div').css('display','none');
        $('#drawnArea input').val("");
        $('#wkt').val("");
        $('#circleLat').val("");
        $('#circleLon').val("");
        $('#circleRadius').val("");
        $('#imcraPid').val("");
        $('#myLayerPid').val("");
    }

    function shapeDrawn(source, type, shape) {
        if (source === 'user-drawn') {
            locationWidgets.clear();
        }
        if (source === 'clear') {
            clearData();
            clearSessionData('drawnShapes');
        } else {
            switch (type) {
                case google.maps.drawing.OverlayType.CIRCLE:
                    /*// don't show or set circle props if source is a locality
                     if (source === "user-drawn") {*/
                    var center = shape.getCenter();
                    // set coord display
                    $('#circLat').val(round(center.lat()));
                    $('#circLon').val(round(center.lng()));
                    $('#circRadius').val(round(shape.getRadius()/1000,2) + "km");
                    $('#circleArea').css('display','block');
                    // set hidden inputs
                    $('#circleLat').val(center.lat());
                    $('#circleLon').val(center.lng());
                    $('#circleRadius').val(shape.getRadius());
                    /*}*/
                    break;
                case google.maps.drawing.OverlayType.RECTANGLE:
                    var bounds = shape.getBounds(),
                            sw = bounds.getSouthWest(),
                            ne = bounds.getNorthEast();
                    // set coord display
                    $('#swLat').val(round(sw.lat()));
                    $('#swLon').val(round(sw.lng()));
                    $('#neLat').val(round(ne.lat()));
                    $('#neLon').val(round(ne.lng()));
                    $('#rectangleArea').css('display','block');
                    // set hidden inputs
                    $('#wkt').val(rectToWkt(sw, ne));
                    break;
                case google.maps.drawing.OverlayType.POLYGON:
                    /*
                     * Note that the path received from the drawing manager does not end by repeating the starting
                     * point (number coords = number vertices). However the path derived from a WKT does repeat
                     * (num coords = num vertices + 1). So we need to check whether the last coord is the same as the
                     * first and if so ignore it.
                     */
                    var path = shape.getPath(),
                            $lat = null,
                            $ul = $('#polygonArea ul'),
                            realLength = 0,
                            isRect = representsRectangle(path);
                    if (!locationWidgets.hasImcra()) {
                        // set coord display
                        if (isRect) {
                            $('#swLat').val(round(path.getAt(0).lat()));
                            $('#swLon').val(round(path.getAt(0).lng()));
                            $('#neLat').val(round(path.getAt(2).lat()));
                            $('#neLon').val(round(path.getAt(2).lng()));
                            $('#rectangleArea').css('display','block');
                        } else if (!locationWidgets.hasImcra()) {
                            $ul.find('li').remove();
                            realLength = path.getLength();
                            if (path.getAt(0).equals(path.getAt(path.length - 1))) {
                                realLength = realLength - 1;
                            }
                            for (i = 0; i < realLength; i++) {
                                // check whether widget exists
                                $lat = $('#lat' + i);
                                if ($lat.length === 0) {
                                    // doesn't so create it
                                    $lat = $('<li><input type="text" id="lat' + i +
                                            '"/><input type="text" id="lon' + i + '"/></li>')
                                            .appendTo($ul);
                                }
                                $('#lat' + i).val(round(path.getAt(i).lat()));
                                $('#lon' + i).val(round(path.getAt(i).lng()));
                            }
                            $('#polygonArea').css('display','block');
                        }
                        // set hidden inputs
                        $('#wkt').val(polygonToWkt(path));
                    }
                    break;
            }
        }
    }

    function rectToWkt(sw, ne) {
        var swLat = sw.lat(),
                swLng = sw.lng(),
                neLat = ne.lat(),
                neLng = ne.lng(),
                wkt = "POLYGON((";
        wkt += swLng + " " + swLat + ',' +
                swLng + " " + neLat + ',' +
                neLng + " " + neLat + ',' +
                neLng + " " + swLat + ',' +
                swLng + " " + swLat;

        return wkt + "))";
    }

    function polygonToWkt(path) {
        var wkt = "POLYGON((",
                firstPoint = path.getAt(0),
                points = [];
        path.forEach(function (obj, i) {
            points.push(obj.lng() + " " + obj.lat());
        });
        // a polygon array from the drawingManager will not have a closing point
        // but one that has been drawn from a wkt will have - so only add closing
        // point if the first and last don't match
        if (!firstPoint.equals(path.getAt(path.length -1))) {
            // add first points at end
            points.push(firstPoint.lng() + " " + firstPoint.lat());
        }
        wkt += points.join(',') + "))";
        //console.log(wkt);
        return wkt;
    }

    function round(number, places) {
        var p = places || 4;
        return places === 0 ? number.toFixed() : number.toFixed(p);
    }

    function representsRectangle(path) {
        // must have 5 points
        if (path.getLength() !== 5) { return false; }
        var arr = path.getArray();
        if ($.isArray(arr[0])) { return false; }  // must be multipolygon (array of arrays)
        if (arr[0].lng() != arr[1].lng()) { return false; }
        if (arr[2].lng() != arr[3].lng()) { return false; }
        if (arr[0].lat() != arr[3].lat()) { return false; }
        if (arr[1].lat() != arr[2].lat()) { return false; }
        return true
    }
</script>

</body>
</html>