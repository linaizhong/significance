modules = {
    application {
        dependsOn 'jquery, jqueryui'
        //defaultBundle false
        resource url:'js/expert.js', disposition: 'head'
        resource url:'js/selection-map.js', disposition: 'head'
        resource url:'js/wms.js', disposition: 'head'
        resource url:'js/combobox.js', disposition: 'head'
        resource url:'js/jquery.ba-bbq.min.js', disposition: 'head'
        resource url:'js/keydragzoom.js', disposition: 'head'
    }

    jquery {
        resource url:'js/jquery-1.7.1.min.js', disposition: 'head'
    }

    jqueryui {
        resource url:'js/jquery-ui-1.8.19.custom.min.js', disposition: 'head'
    }

    tooltipster {
        dependsOn 'jquery'
        resource url:'css/tooltipster.css'
        resource url:'js/jquery.tooltipster.min.js', disposition: 'head'
    }

    html5 {
        resource url:'js/html5.js', wrapper: { s -> "<!--[if lt IE 9]>$s<![endif]-->" }
    }

    bootstrap {
        resource url:'css/bootstrap.min.css'
        resource url:'js/bootstrap.min.js', disposition: 'head'
    }
}