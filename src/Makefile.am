AM_CPPFLAGS = \
	$(CB_CFLAGS) \
	-include $(CONFIG_HEADER) \
	-DDATADIR=\"$(datadir)\" \
	-DPKGDATADIR=\"$(pkgdatadir)\" \
	-DG_LOG_DOMAIN=\"corebird\" \
	-I$(top_srcdir)/src/rest/


AM_VALAFLAGS = \
	--thread \
	--enable-deprecated \
	--enable-checking \
	--vapidir $(builddir) \
	--vapidir $(top_srcdir)/vapi \
	--basedir $(srcdir) \
	--directory $(builddir) \
	--gresources $(top_srcdir)/corebird.gresource.xml \
	-D G_LOG_DOMAIN=\"corebird\" \
	$(top_srcdir)/vapi/config.vapi \
	$(top_srcdir)/vapi/corebird-internal.vapi \
	$(top_srcdir)/vapi/rest-0.7.vapi \
	-C \
	$(NULL)

BUILT_SOURCES = \
	corebird.h \
	corebird-resources.c

bin_PROGRAMS = corebird
noinst_LTLIBRARIES = libcorebird.la

libcorebird_la_VALASOURCES = \
	Corebird.vala \
	MainWindow.vala \
	MainWidget.vala \
	Account.vala \
	HomeTimeline.vala \
	MentionsTimeline.vala \
	SearchPage.vala \
	DMPage.vala \
	IPage.vala \
	DefaultTimeline.vala \
	DMThreadsPage.vala \
	Settings.vala \
	NotificationManager.vala \
	Twitter.vala \
	ProfilePage.vala \
	TweetInfoPage.vala \
	ListStatusesPage.vala \
	ListsPage.vala \
	FavoritesTimeline.vala \
	FilterPage.vala \
	UserEventReceiver.vala \
	DMManager.vala \
	widgets/TweetListBox.vala \
	widgets/MaxSizeContainer.vala \
	widgets/ScrollWidget.vala \
	widgets/TextButton.vala \
	widgets/DoubleTapButton.vala \
	widgets/ReplyEntry.vala \
	widgets/PixbufButton.vala \
	widgets/BadgeRadioButton.vala \
	widgets/DMPlaceholderBox.vala \
	widgets/AccountCreateWidget.vala \
	widgets/AspectImage.vala \
	widgets/UserListsWidget.vala \
	widgets/ReplyIndicator.vala \
	widgets/MultiMediaWidget.vala \
	widgets/AvatarWidget.vala \
	widgets/AvatarBannerWidget.vala \
	widgets/CropWidget.vala \
	widgets/AddImageButton.vala \
	widgets/CompletionTextView.vala \
	widgets/LazyMenuButton.vala \
	widgets/ImpostorWidget.vala \
	widgets/FollowButton.vala \
	widgets/MediaButton.vala \
	widgets/ComposeImageManager.vala \
	widgets/FavImageView.vala \
	util/TweetUtils.vala \
	util/Utils.vala \
	util/UserCompletion.vala \
	util/Dirs.vala \
	util/UserUtils.vala \
	list/TweetListEntry.vala \
	list/DMListEntry.vala \
	list/UserListEntry.vala \
	list/DMThreadEntry.vala \
	list/StartConversationEntry.vala \
	list/ListListEntry.vala \
	list/NewListEntry.vala \
	list/FilterListEntry.vala \
	list/UserFilterEntry.vala \
	list/AddListEntry.vala \
	list/SnippetListEntry.vala \
	list/FavImageRow.vala \
	util/Benchmark.vala \
	window/ComposeTweetWindow.vala \
	window/SettingsDialog.vala \
	window/UserListDialog.vala \
	window/ModifyFilterDialog.vala \
	window/AboutDialog.vala \
	window/AccountDialog.vala \
	window/MediaDialog.vala \
	window/ModifySnippetDialog.vala \
	sql/Database.vala \
	sql/InsertStatement.vala \
	sql/UpdateStatement.vala \
	sql/SelectStatement.vala \
	async/Collect.vala \
	async/ComposeJob.vala \
	model/DMThreadsModel.vala

nodist_libcorebird_la_SOURCES = \
	libcorebird_la_vala.stamp \
	$(libcorebird_la_VALASOURCES:.vala=.c)

corebird.h corebird.vapi: libcorebird_la_vala.stamp
$(libcorebird_la_VALASOURCES:.vala=.c): libcorebird_la_vala.stamp


libcorebird_la_SOURCES = \
	CbMedia.c \
	CbMedia.h \
	CbMediaDownloader.c \
	CbMediaDownloader.h \
	CbTypes.c \
	CbTypes.h \
	CbTextTransform.c \
	CbTextTransform.h \
	CbTweet.c \
	CbTweet.h \
	CbFilter.c \
	CbFilter.h \
	CbAvatarCache.c \
	CbAvatarCache.h \
	CbUserCounter.c \
	CbUserCounter.h \
	CbMediaImageWidget.h \
	CbMediaImageWidget.c \
	CbTweetModel.h \
	CbTweetModel.c \
	CbTwitterItem.h \
	CbTwitterItem.c \
	CbDeltaUpdater.h \
	CbDeltaUpdater.c \
	CbUtils.h \
	CbUtils.c \
	CbBundle.h \
	CbBundle.c \
	CbBundleHistory.h \
	CbBundleHistory.c \
	CbSnippetManager.h \
	CbSnippetManager.c \
	CbMediaVideoWidget.h \
	CbMediaVideoWidget.c \
	CbSurfaceProgress.h \
	CbSurfaceProgress.c \
	CbMessageReceiver.h \
	CbMessageReceiver.c \
	CbUserStream.h \
	CbUserStream.c \
	CbGtkCompat.h \
	rest/rest/rest-param.c \
	rest/rest/rest-params.c \
	rest/rest/rest-proxy.c \
	rest/rest/rest-proxy-auth.c \
	rest/rest/rest-proxy-auth-private.h \
	rest/rest/rest-proxy-call.c \
	rest/rest/rest-proxy-call-private.h \
	rest/rest/rest-main.c \
	rest/rest/rest-private.h \
	rest/rest/oauth-proxy.c \
	rest/rest/oauth-proxy-call.c \
	rest/rest/oauth-proxy-private.h \
	rest/rest/sha1.c \
	rest/rest/sha1.h \
	rest/rest/rest-param.h \
	rest/rest/rest-params.h \
	rest/rest/rest-proxy.h \
	rest/rest/rest-proxy-auth.h \
	rest/rest/rest-proxy-call.h \
	rest/rest/oauth-proxy.h \
	rest/rest/oauth-proxy-call.h




libcorebird_la_vala.stamp: $(libcorebird_la_VALASOURCES) Makefile
	@$(VALAC) \
		$(AM_VALAFLAGS) $(CB_VALA_FLAGS) \
		-H corebird.h \
		--library corebird \
		--vapi corebird.vapi \
		$(filter %.vala %.c,$^)
	touch $@

libcorebird_la_LIBADD = $(CB_LIBS)

corebird_VALASOURCES = \
	main.vala


nodist_corebird_SOURCES = \
	corebird_vala.stamp \
	corebird-resources.c \
	$(corebird_VALASOURCES:.vala=.c)

corebird_LDADD = \
	$(CB_LIBS) \
	$(builddir)/libcorebird.la

corebird_VALAFLAGS = \
	$(CB_VALA_FLAGS) \
	corebird.vapi

$(corebird_VALASOURCES:.vala=.c): corebird_vala.stamp

corebird_vala.stamp: $(builddir)/libcorebird.la $(builddir)/corebird.vapi $(corebird_VALASOURCES) Makefile
	@$(VALAC) \
		$(AM_VALAFLAGS) $(CB_VALA_FLAGS) \
		--pkg corebird \
		$(filter %.vala %.c,$^)
	touch $@

resource_deps = $(shell $(GLIB_COMPILE_RESOURCES) --generate-dependencies --sourcedir=$(top_srcdir) $(top_srcdir)/corebird.gresource.xml)
corebird-resources.c: $(top_srcdir)/corebird.gresource.xml $(resource_deps) Makefile
	XMLLINT=$(XMLLINT) $(GLIB_COMPILE_RESOURCES) --target $@ --generate --sourcedir=$(top_srcdir) --c-name corebird $<

CLEANFILES = \
	libcorebird_la_vala.stamp \
	corebird_vala.stamp \
	$(libcorebird_la_VALASOURCES:.vala=.c) \
	$(nodist_corebird_SOURCES) \
	corebird.vapi \
	corebird.h

EXTRA_DIST = \
	$(libcorebird_la_VALASOURCES) \
	$(corebird_VALASOURCES) \
	$(corebird_SOURCES) \
	$(resource_deps)
