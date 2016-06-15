DatabaseProcessMining-Repository
===============

Releases and binary versions repository


# How to import using Ivy

ivysettings.xml

	<ivysettings>
	    <settings defaultResolver="default" />   
	    <resolvers>
	    	<url name="db-process-mining">
	            <ivy pattern="https://git.yerappa.com/gitbucket/TUE-PhD/DatabaseProcessMining-Repository/raw/master/Releases/[module]/[module]-[revision]-ivy.xml" />
	            <artifact pattern="https://git.yerappa.com/gitbucket/TUE-PhD/DatabaseProcessMining-Repository/raw/master/Releases/[module]/[module]-[revision].[ext]" />
	        </url>
	        <url name="prom" checkmodified="true">
	            <ivy pattern="https://svn.win.tue.nl/repos/[organisation]/Releases/Packages/[module]/[revision]/ivy.xml" />
	            <artifact pattern="https://svn.win.tue.nl/repos/[organisation]/Releases/Packages/[module]/[revision]/[artifact]-[revision].[ext]" />
	        </url>
	        <url name="prom-libs">
	            <ivy pattern="https://svn.win.tue.nl/repos/prom/Libraries/[module]/[revision]/ivy.xml" />
	            <artifact pattern="https://svn.win.tue.nl/repos/prom/Libraries/[module]/[revision]/[artifact]-[revision].[ext]" />
	            <artifact pattern="https://svn.win.tue.nl/repos/prom/Libraries/[module]/[revision]/[artifact]_[revision].[ext]" />
	         </url>
	        <ibiblio name="maven2" m2compatible="true"/>
	        <chain name="default" returnFirst="true">  
	        	<resolver ref="db-process-mining" />
	            <resolver ref="prom" />  
	            <resolver ref="prom-libs" />  
	            <resolver ref="maven2" />  
	        </chain>  
	    </resolvers>
	</ivysettings>

Depencency block in ivy.xml:

	<dependency org="db-process-mining" name="MODULE-NAME" rev="VERSION"/>

For OpenSLEX:

	<dependency org="db-process-mining" name="OpenSLEX" rev="0.5"/>

For DAPOQ-Lang:

	<dependency org="db-process-mining" name="DAPOQ-Lang" rev="0.5"/>
