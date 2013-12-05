= Maleo

This is a html5 application runner. It is built using Gtk+ Webkit port in Vala programming language. To use it, jut feed the application with the absolute path containing the config.xml.
The runner is powered by Seed runtime, or you can use Node.js.

Maleo is an endangered species of bird originating from Sulawesi island, Indonesia.

== config.xml

The config.xml is a metadata document accompanying an HTML5 app, using widget W3C specification. We can define the geometry of the application, the entry point page, and other aspects of the application.

=== Width and height
You should specify width and height so Maleo will prepare the window size accordingly. Width and height are specified as widget tag attributes.

    <widget id="com.example.app" version="1.0.0" xmlns="http://www.w3.org/ns/widgets" width="480" height="800">

=== Entry point
Entry point is the first page loaded by the application.

    <content src="index.html"/>

=== To Seed or not to Seed
By default, Maleo uses Seed as the JavaScript interpreter. If you want to disable Seed, specify this option:

    <preference name="enable-seed" value="none" />

=== Node.js
If you have a Node.js back-end application required by the HTML5 app, you can specify the application path. Internally, Maleo will try to invoke Node.js with the specified application first. 

    <preference name="nodejs-app" value="/path/to/nodejs/app" />
