class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

        "/test" (view: "test")
        "/admin"(controller: "index")
		"/"(controller: "search")
		"500"(view:'/error')
	}
}
