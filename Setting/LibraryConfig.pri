isEmpty(PROJECT_LIB) {
    error("PROJECT_LIB path is illegal, please define the PROJECT_LIB variable")
}
isEmpty(PROJECT_PATH) {
    error("PROJECT_PATH path is illegal, please define the PROJECT_PATH variable")
}

!isEmpty(ImportLibrary) {
    for(Delete,LoadLibrary) {
	LoadLibrary -= $$Delete
    }
    for(Library,ImportLibrary) {
	!contains(LoadLibrary,$$Library) {
	    IMPORT_LIBRARY_SETTING = $$PROJECT_IMPORT_LIBRARY_SETTING_PATH/$${Library}.pri
	    exists($$IMPORT_LIBRARY_SETTING) {
		include($$IMPORT_LIBRARY_SETTING)
		LoadLibrary += $$Library
	    }else {
		warning("Library has been loaded.")
	    }
	} else {
	    isEqual(IMPORT_LIBRARY_FAIL_WARNING,ON) {
		warning("The library interface is not present in the setup file.")
	    } else {
		error("The library interface is not present in the setup file.")
	    }
	}
    }
}
