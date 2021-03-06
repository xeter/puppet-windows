class maven($source, 
	$target='c:\\dev\\maven',
	$maven_home,
	$trigramme) {
	
	require 7zip
	
	notify {"Installing Maven-$trigramme-+${::username}+...":}
	
	exec { "7z.exe x -o$target $source":
		cwd => 'c:\\Program Files\\7-Zip\\',
		creates => "$target",
		path => 'c:\\Program Files\\7-Zip\\',
	}
	windows_env{ 'MAVEN_HOME':
		ensure => present,
		value  => "$maven_home",
		mergemode => clobber,
	}
	windows_env{ "PATH=%MAVEN_HOME%\\bin": }
	
	file { "C:\\Users\\${::username}\\.m2\\":
		ensure => directory,
		source_permissions => ignore,
	}
	
	file { "C:\\Users\\${::username}\\.m2\\settings_gmi.xml":
		content => template('maven/settings.xml.erb'),
	}
}