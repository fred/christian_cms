/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.entities : false;
	config.contentsLanguage : 'es';
	config.entities_latin : false;
	config.entities_processNumerical : false;
	config.emailProtection : 'encode';
	config.forcePasteAsPlainText = true;
	config.height = '400px';
};
