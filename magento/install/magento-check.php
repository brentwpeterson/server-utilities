<?php
extension_check(array( 
	'curl',
	'dom', 
	'gd', 
	'hash',
	'iconv',
	'mcrypt',
	'pcre', 
	'pdo', 
	'pdo_mysql', 
	'simplexml'
));

function extension_check($extensions) {
	$fail = '';
	$pass = '';
	
	if(version_compare(phpversion(), '5.2.0', '<')) {
		$fail .= '<li>You need<strong> PHP 5.2.0</strong> (or greater)</li>';
	}
	else {
		$pass .='<li>You have<strong> PHP 5.2.0</strong> (or greater)</li>';
	}

	if(!ini_get('safe_mode')) {
		$pass .='<li>Safe Mode is <strong>off</strong></li>';
		preg_match('/[0-9]\.[0-9]+\.[0-9]+/', shell_exec('mysql -V'), $version);
		
		if(version_compare($version[0], '4.1.20', '<')) {
			$fail .= '<li>You need<strong> MySQL 4.1.20</strong> (or greater)</li>';
		}
		else {
			$pass .='<li>You have<strong> MySQL 4.1.20</strong> (or greater)</li>';
		}
	}
	else { $fail .= '<li>Safe Mode is <strong>on</strong></li>';  }

	foreach($extensions as $extension) {
		if(!extension_loaded($extension)) {
			$fail .= '<li> You are missing the <strong>'.$extension.'</strong> extension</li>';
		}
		else{	$pass .= '<li>You have the <strong>'.$extension.'</strong> extension</li>';
		}
	}
	
	if($fail) {
		echo '<p><strong>Your server does not meet the following requirements in order to install Magento.</strong>';
		echo '<br>The following requirements failed, please contact your hosting provider in order to receive assistance with meeting the system requirements for Magento:';
		echo '<ul>'.$fail.'</ul></p>';
		echo 'The following requirements were successfully met:';
		echo '<ul>'.$pass.'</ul>';
	} else {
		echo '<p><strong>Congratulations!</strong> Your server meets the requirements for Magento.</p>';
		echo '<ul>'.$pass.'</ul>';

	}
}
?>
