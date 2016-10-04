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
         <url name="rapidprom" checkmodified="true" checksums="">
         	<ivy pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.1/prom/[module]-[revision]/ivy-[module]-[revision].xml" />
            <artifact pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.1/prom/[module]-[revision]/[module]-[revision].[ext]" />
        </url>
        <url name="rapidprom-thirdparty-lib" checkmodified="true" checksums="">
            <ivy pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.1/thirdparty/lib/[module]-[revision]/ivy-[module]-[revision].xml" />
            <artifact pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.1/thirdparty/lib/[module]-[revision]/[module]-[revision].[ext]" />
        </url>
        <url name="rapidprom-thirdparty-resource" checkmodified="true" checksums="">
            <ivy pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.1/thirdparty/resource/[module]-[revision]/ivy-[module]-[revision].xml" />
            <artifact pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.1/thirdparty/resource/[module]-[revision]/[module]-[revision].[ext]" />
        </url>
        <ibiblio name="maven2" m2compatible="true"/>
        <chain name="default" returnFirst="true">
        	<resolver ref="db-process-mining" />
        	<resolver ref="rapidprom"/>
            <resolver ref="rapidprom-thirdparty-lib"/>
            <resolver ref="rapidprom-thirdparty-resource"/>  
            <resolver ref="maven2" />  
        </chain>  
    </resolvers>
</ivysettings>

Depencency block in ivy.xml:

	<dependency org="db-process-mining" name="MODULE-NAME" rev="VERSION"/>

For OpenSLEX:

	<dependency org="db-process-mining" name="OpenSLEX" rev="0.7"/>

For DAPOQ-Lang:

	<dependency org="db-process-mining" name="DAPOQ-Lang" rev="0.7"/>
