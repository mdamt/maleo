NULL = 

AM_CPPFLAGS = \
	$(maleo_CFLAGS) \
	-include config.h \
	-DLOCALEDIR=\""$(localedir)"\" \
	-DPKGDATADIR=\""$(pkgdatadir)"\" \
	$(NULL)

bin_PROGRAMS = maleo

maleo_SOURCES = webview.vala \
		window.vala \
		config.vala \
    main.vala \
	$(NULL)

maleo_VALAFLAGS = \
    --vapidir ../vapi \
	--pkg config \
    $(VALA_PACKAGES) \
    $(NULL)

maleo_LDADD = \
	$(maleo_LIBS) \
	$(NULL)

EXTRA_DIST = \
	$(NULL)

DISTCLEANFILES = \
	$(NULL)

install-exec-hook:
	$(LN_S) $(DESTDIR)$(bindir)/maleo$(EXEEXT) \ 
		$(DESTDIR)$(bindir)/html5app$(EXEEXT)

