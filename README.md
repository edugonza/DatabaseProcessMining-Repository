DatabaseProcessMining-Repository
===============

Releases and binary versions repository


# How to import using Ivy

ivysettings.xml.

	<ivysettings>
		<settings defaultResolver="default" />
		<resolvers>
			<url name="db-process-mining">
				<ivy
					pattern="https://github.com/edugonza/DatabaseProcessMining-Repository/raw/master/Releases/[organisation]/[module]/[revision]/ivy-[revision].xml" />
				<artifact
					pattern="https://github.com/edugonza/DatabaseProcessMining-Repository/raw/master/Releases/[organisation]/[module]/[revision]/[module]-[revision].[ext]" />
			</url>
			<url name="rapidprom" checkmodified="true" checksums="">
				<ivy
					pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.2/prom/[module]-[revision]/ivy-[module]-[revision].xml" />
				<artifact
					pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.2/prom/[module]-[revision]/[module]-[revision].[ext]" />
			</url>
			<url name="rapidprom-thirdparty-lib" checkmodified="true" checksums="">
				<ivy
					pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.2/thirdparty/lib/[module]-[revision]/ivy-[module]-[revision].xml" />
				<artifact
					pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.2/thirdparty/lib/[module]-[revision]/[module]-[revision].[ext]" />
			</url>
			<url name="rapidprom-thirdparty-resource" checkmodified="true" checksums="">
				<ivy
					pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.2/thirdparty/resource/[module]-[revision]/ivy-[module]-[revision].xml" />
				<artifact
					pattern="https://github.com/rapidprom/rapidprom-libraries/raw/4.0.2/thirdparty/resource/[module]-[revision]/[module]-[revision].[ext]" />
			</url>
			<ibiblio name="maven2" m2compatible="true" />
			<chain name="default" returnFirst="true">
				<resolver ref="db-process-mining" />
				<resolver ref="rapidprom" />
				<resolver ref="rapidprom-thirdparty-lib" />
				<resolver ref="rapidprom-thirdparty-resource" />
				<resolver ref="maven2" />
			</chain>
		</resolvers>
	</ivysettings>

Depencency block in ivy.xml:

	<dependency org="org.processminig" name="MODULE-NAME" rev="VERSION"/>

For OpenSLEX:

	<dependency org="org.processminig" name="OpenSLEX" rev="0.8"/>

For DAPOQ-Lang:

	<dependency org="org.processminig" name="DAPOQ-Lang" rev="0.8"/>
