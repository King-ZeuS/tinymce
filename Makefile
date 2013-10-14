
#
# Used to install TinyMCE 4 into our source tree. We only include the
# non-minified, compiled output. We will do our own minification.
#
# [andy 14.Oct.2013]
#

# Your TeamPage source tree
SRC=~/src/hg/jetty

# Destination directory for TinyMCE 4
TINYMCE=$(SRC)/html/js/tinymce4

# Plugin list copied from js/traction/edit/tinymce/TinyMce.js
PLUGINS=table paste charmap textcolor directionality noneditable contextmenu link code fullscreen

# Files that we don't need that are removed after we install
GARBAGE=skins/lightgray/fonts themes/modern/theme.min.js 

install:
	@echo "Recreating TinyMCE 4 Installation Directories"
	-@rm -rf $(TINYMCE)
	-@mkdir $(TINYMCE)
	-@mkdir $(TINYMCE)/themes
	-@mkdir $(TINYMCE)/skins
	-@mkdir $(TINYMCE)/plugins

	@echo "Installing TinyMCE 4 Core"
	@cp js/tinymce/tinymce.js $(TINYMCE)/tinymce.js

	@echo "Installing TinyMCE 4 Skin - lightgray"
	@cp -r js/tinymce/skins/lightgray $(TINYMCE)/skins
	@rm $(TINYMCE)/skins/lightgray/*.less

	@echo "Installing TinyMCE 4 Theme - modern"
	@cp -r js/tinymce/themes/modern $(TINYMCE)/themes

	@for plugin in $(PLUGINS); do echo "Installing TinyMCE 4 Plugin - $$plugin"; mkdir $(TINYMCE)/plugins/$$plugin; cp -r js/tinymce/plugins/$$plugin/plugin.js $(TINYMCE)/plugins/$$plugin/plugin.js; done

	@for file in $(GARBAGE); do echo "Removing $(TINYMCE)/$$file"; rm -rf $(TINYMCE)/$$file; done

	@echo "TinyMCE Installation complete. Please checkin and push the new installation to our Mercurial tree."
