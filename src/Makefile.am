NULL = 

AM_CPPFLAGS = \
	$(HTML5APP_CFLAGS) \
	-include config.h \
	-DLOCALEDIR=\""$(localedir)"\" \
	-DPKGDATADIR=\""$(pkgdatadir)"\" \
	$(NULL)

bin_PROGRAMS = html5app

html5app_SOURCES = webview.vala \
		window.vala \
    main.vala \
	$(NULL)

html5app_VALAFLAGS = \
    --vapidir ../vapi \
	--pkg config \
    $(VALA_PACKAGES) \
    $(NULL)

html5app_LDADD = \
	$(HTML5APP_LIBS) \
	$(NULL)

EXTRA_DIST = \
	$(NULL)

DISTCLEANFILES = \
	$(NULL)


